using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Repositories;
using WanderlustApi.DTOs;
using WanderlustApi.Models;
using WanderlustApi.Services;
using System.Security.Claims;
using System.Net;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IUserRepository _userRepository;
        private readonly ICodeExampleRepository _codeExampleRepository;
        private readonly IJwtService _jwtService;
        private readonly IPasswordService _passwordService;
        private readonly ILogger<AuthController> _logger;

        public AuthController(
            IUserRepository userRepository,
            ICodeExampleRepository codeExampleRepository,
            IJwtService jwtService,
            IPasswordService passwordService,
            ILogger<AuthController> logger)
        {
            _userRepository = userRepository;
            _codeExampleRepository = codeExampleRepository;
            _jwtService = jwtService;
            _passwordService = passwordService;
            _logger = logger;
        }

        [HttpPost("register")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> Register(RegisterRequest request)
        {
            // Check if user already exists
            if (await _userRepository.EmailExistsAsync(request.Email))
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "Registration failed", 
                    new ApiError 
                    { 
                        Code = ApiErrorCodes.VALIDATION_ERROR, 
                        Message = "User with this email already exists" 
                    },
                    HttpStatusCode.BadRequest));
            }

            if (await _userRepository.UsernameExistsAsync(request.Username))
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "Registration failed", 
                    new ApiError 
                    { 
                        Code = ApiErrorCodes.VALIDATION_ERROR, 
                        Message = "Username is already taken" 
                    },
                    HttpStatusCode.BadRequest));
            }

            // Create new user
            var user = new User
            {
                Username = request.Username,
                Email = request.Email,
                DisplayName = request.DisplayName,
                Bio = request.Bio,
                PasswordHash = _passwordService.HashPassword(request.Password),
                Role = UserRole.Member,
                CreatedAt = DateTime.UtcNow,
                LastLoginAt = DateTime.UtcNow,
                IsActive = true,
                IsEmailVerified = false // In production, send verification email
            };

            // Generate refresh token
            user.RefreshToken = _jwtService.GenerateRefreshToken();
            user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);

            await _userRepository.CreateAsync(user);

            // Generate JWT token
            var accessToken = _jwtService.GenerateAccessToken(user);

            _logger.LogInformation("New user registered: {Email}", request.Email);

            var authResponse = new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            };

            return Ok(ApiResponse<AuthResponse>.SuccessResponse(
                authResponse, 
                "User registered successfully"));
        }

        [HttpPost("login")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> Login(LoginRequest request)
        {
            var user = await _userRepository.GetByEmailAsync(request.Email);

            if (user == null || !_passwordService.VerifyPassword(request.Password, user.PasswordHash))
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "Login failed", 
                    new ApiError 
                    { 
                        Code = ApiErrorCodes.AUTHENTICATION_FAILED, 
                        Message = "Invalid email or password" 
                    },
                    HttpStatusCode.BadRequest));
            }

            if (!user.IsActive)
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "Login failed", 
                    new ApiError 
                    { 
                        Code = ApiErrorCodes.FORBIDDEN, 
                        Message = "Account is deactivated" 
                    },
                    HttpStatusCode.BadRequest));
            }

            // Update last login
            user.LastLoginAt = DateTime.UtcNow;

            // Generate new refresh token if requested or if current one is expired
            if (request.RememberMe || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            {
                user.RefreshToken = _jwtService.GenerateRefreshToken();
                user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(request.RememberMe ? 30 : 7);
            }

            await _userRepository.UpdateAsync(user);

            // Generate JWT token
            var accessToken = _jwtService.GenerateAccessToken(user);

            _logger.LogInformation("User logged in: {Email}", request.Email);

            var authResponse = new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken!,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            };

            return Ok(ApiResponse<AuthResponse>.SuccessResponse(
                authResponse, 
                "User logged in successfully"));
        }

        [HttpPost("refresh-token")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> RefreshToken(RefreshTokenRequest request)
        {
            var user = await _userRepository.GetByRefreshTokenAsync(request.RefreshToken);

            if (user == null || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "Token refresh failed", 
                    new ApiError 
                    { 
                        Code = ApiErrorCodes.AUTHENTICATION_FAILED, 
                        Message = "Invalid or expired refresh token" 
                    },
                    HttpStatusCode.BadRequest));
            }

            // Generate new tokens
            var accessToken = _jwtService.GenerateAccessToken(user);
            user.RefreshToken = _jwtService.GenerateRefreshToken();
            user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);

            await _userRepository.UpdateAsync(user);

            var authResponse = new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            };

            return Ok(ApiResponse<AuthResponse>.SuccessResponse(
                authResponse, 
                "Token refreshed successfully"));
        }

        [HttpPost("logout")]
        [Authorize]
        public async Task<IActionResult> Logout()
        {
            var userId = GetCurrentUserId();
            var user = await _userRepository.GetByIdAsync(userId);

            if (user != null)
            {
                user.RefreshToken = null;
                user.RefreshTokenExpiryTime = null;
                await _userRepository.UpdateAsync(user);
            }

            return Ok(ApiResponse.CreateSuccess("Logged out successfully"));
        }

        [HttpPost("change-password")]
        [Authorize]
        public async Task<IActionResult> ChangePassword(ChangePasswordRequest request)
        {
            var userId = GetCurrentUserId();
            var user = await _userRepository.GetByIdAsync(userId);

            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            if (!_passwordService.VerifyPassword(request.CurrentPassword, user.PasswordHash))
            {
                return BadRequest(new { message = "Current password is incorrect" });
            }

            user.PasswordHash = _passwordService.HashPassword(request.NewPassword);
            user.RefreshToken = null; // Invalidate existing refresh tokens
            user.RefreshTokenExpiryTime = null;

            await _userRepository.UpdateAsync(user);

            _logger.LogInformation("Password changed for user: {UserId}", userId);

            return Ok(new { message = "Password changed successfully" });
        }

        [HttpGet("me")]
        [Authorize]
        public async Task<ActionResult<UserDto>> GetCurrentUser()
        {
            var userId = GetCurrentUserId();
            var user = await _userRepository.GetByIdAsync(userId);

            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            return Ok(MapToUserDto(user));
        }

        // IONOS Compatibility: Convert PUT to POST with action suffix
        [HttpPost("profile/update")]
        [Authorize]
        public async Task<ActionResult<UserDto>> UpdateProfile(UpdateProfileRequest request)
        {
            var userId = GetCurrentUserId();
            var user = await _userRepository.GetByIdAsync(userId);

            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            if (!string.IsNullOrEmpty(request.DisplayName))
                user.DisplayName = request.DisplayName;

            if (request.Bio != null)
                user.Bio = request.Bio;

            if (request.AvatarUrl != null)
                user.AvatarUrl = request.AvatarUrl;

            await _userRepository.UpdateAsync(user);

            return Ok(MapToUserDto(user));
        }

        [HttpGet("users/{id}/stats")]
        public async Task<ActionResult<UserStatsDto>> GetUserStats(int id)
        {
            var user = await _userRepository.GetByIdAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            // Note: For now we'll just use the code examples count
            // In a full implementation, you'd also need repositories for Articles and CommunityPosts
            var codeExamplesCount = (await _codeExampleRepository.GetByAuthorAsync(id)).Count();

            return Ok(new UserStatsDto
            {
                ArticlesCreated = 0, // Will need Article repository
                CodeExamplesCreated = codeExamplesCount,
                CommunityPostsCreated = 0, // Will need CommunityPost repository  
                TotalContributions = codeExamplesCount,
                JoinedAt = user.CreatedAt,
                LastActiveAt = user.LastLoginAt
            });
        }

        private int GetCurrentUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            return int.Parse(userIdClaim ?? "0");
        }

        private static UserDto MapToUserDto(User user)
        {
            return new UserDto
            {
                Id = user.Id,
                Username = user.Username,
                Email = user.Email,
                DisplayName = user.DisplayName,
                Bio = user.Bio,
                AvatarUrl = user.AvatarUrl,
                Role = user.Role,
                IsEmailVerified = user.IsEmailVerified,
                CreatedAt = user.CreatedAt,
                LastLoginAt = user.LastLoginAt
            };
        }
    }
}
