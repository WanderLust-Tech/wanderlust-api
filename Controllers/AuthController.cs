using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.DTOs;
using WanderlustApi.Models;
using WanderlustApi.Services;
using System.Security.Claims;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly WanderlustDbContext _context;
        private readonly IJwtService _jwtService;
        private readonly IPasswordService _passwordService;
        private readonly ILogger<AuthController> _logger;

        public AuthController(
            WanderlustDbContext context,
            IJwtService jwtService,
            IPasswordService passwordService,
            ILogger<AuthController> logger)
        {
            _context = context;
            _jwtService = jwtService;
            _passwordService = passwordService;
            _logger = logger;
        }

        [HttpPost("register")]
        public async Task<ActionResult<AuthResponse>> Register(RegisterRequest request)
        {
            // Check if user already exists
            if (await _context.Users.AnyAsync(u => u.Email == request.Email))
            {
                return BadRequest(new { message = "User with this email already exists" });
            }

            if (await _context.Users.AnyAsync(u => u.Username == request.Username))
            {
                return BadRequest(new { message = "Username is already taken" });
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

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            // Generate JWT token
            var accessToken = _jwtService.GenerateAccessToken(user);

            _logger.LogInformation("New user registered: {Email}", request.Email);

            return Ok(new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            });
        }

        [HttpPost("login")]
        public async Task<ActionResult<AuthResponse>> Login(LoginRequest request)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == request.Email);

            if (user == null || !_passwordService.VerifyPassword(request.Password, user.PasswordHash))
            {
                return BadRequest(new { message = "Invalid email or password" });
            }

            if (!user.IsActive)
            {
                return BadRequest(new { message = "Account is deactivated" });
            }

            // Update last login
            user.LastLoginAt = DateTime.UtcNow;

            // Generate new refresh token if requested or if current one is expired
            if (request.RememberMe || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            {
                user.RefreshToken = _jwtService.GenerateRefreshToken();
                user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(request.RememberMe ? 30 : 7);
            }

            await _context.SaveChangesAsync();

            // Generate JWT token
            var accessToken = _jwtService.GenerateAccessToken(user);

            _logger.LogInformation("User logged in: {Email}", request.Email);

            return Ok(new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken!,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            });
        }

        [HttpPost("refresh-token")]
        public async Task<ActionResult<AuthResponse>> RefreshToken(RefreshTokenRequest request)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.RefreshToken == request.RefreshToken);

            if (user == null || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            {
                return BadRequest(new { message = "Invalid or expired refresh token" });
            }

            // Generate new tokens
            var accessToken = _jwtService.GenerateAccessToken(user);
            user.RefreshToken = _jwtService.GenerateRefreshToken();
            user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);

            await _context.SaveChangesAsync();

            return Ok(new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            });
        }

        [HttpPost("logout")]
        [Authorize]
        public async Task<IActionResult> Logout()
        {
            var userId = GetCurrentUserId();
            var user = await _context.Users.FindAsync(userId);

            if (user != null)
            {
                user.RefreshToken = null;
                user.RefreshTokenExpiryTime = null;
                await _context.SaveChangesAsync();
            }

            return Ok(new { message = "Logged out successfully" });
        }

        [HttpPost("change-password")]
        [Authorize]
        public async Task<IActionResult> ChangePassword(ChangePasswordRequest request)
        {
            var userId = GetCurrentUserId();
            var user = await _context.Users.FindAsync(userId);

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

            await _context.SaveChangesAsync();

            _logger.LogInformation("Password changed for user: {UserId}", userId);

            return Ok(new { message = "Password changed successfully" });
        }

        [HttpGet("me")]
        [Authorize]
        public async Task<ActionResult<UserDto>> GetCurrentUser()
        {
            var userId = GetCurrentUserId();
            var user = await _context.Users.FindAsync(userId);

            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            return Ok(MapToUserDto(user));
        }

        [HttpPut("profile")]
        [Authorize]
        public async Task<ActionResult<UserDto>> UpdateProfile(UpdateProfileRequest request)
        {
            var userId = GetCurrentUserId();
            var user = await _context.Users.FindAsync(userId);

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

            await _context.SaveChangesAsync();

            return Ok(MapToUserDto(user));
        }

        [HttpGet("users/{id}/stats")]
        public async Task<ActionResult<UserStatsDto>> GetUserStats(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            var articlesCount = await _context.Articles.CountAsync(a => a.Id == id); // Note: This needs Author relationship
            var codeExamplesCount = await _context.CodeExamples.CountAsync(c => c.Author == user.Username);
            var communityPostsCount = await _context.CommunityPosts.CountAsync(p => p.AuthorName == user.Username);

            return Ok(new UserStatsDto
            {
                ArticlesCreated = articlesCount,
                CodeExamplesCreated = codeExamplesCount,
                CommunityPostsCreated = communityPostsCount,
                TotalContributions = articlesCount + codeExamplesCount + communityPostsCount,
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
