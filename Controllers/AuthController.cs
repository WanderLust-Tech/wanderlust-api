using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Repositories;
using WanderlustApi.DTOs;
using WanderlustApi.Models;
using WanderlustApi.Services;
using System.Security.Claims;
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json.Serialization;

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
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ILogger<AuthController> _logger;

        public AuthController(
            IUserRepository userRepository,
            ICodeExampleRepository codeExampleRepository,
            IJwtService jwtService,
            IPasswordService passwordService,
            IHttpClientFactory httpClientFactory,
            ILogger<AuthController> logger)
        {
            _userRepository = userRepository;
            _codeExampleRepository = codeExampleRepository;
            _jwtService = jwtService;
            _passwordService = passwordService;
            _httpClientFactory = httpClientFactory;
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

        // Federated sign-in: the custom-browser fork already has its own
        // working Google/Microsoft OAuth (GoogleAuthProvider/
        // MicrosoftAuthProvider, used for cloud bookmark sync) -- this
        // endpoint exchanges an access token from that existing flow for a
        // wanderlust-api session, rather than wiring Chromium's native
        // Gaia sign-in (which the fork otherwise de-googles). Auto-
        // provisions a wanderlust-api user on first sign-in from a given
        // email, matching Register's shape but with a random, unusable
        // password (this account can only ever sign in via this endpoint).
        [HttpPost("external-login")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> ExternalLogin(ExternalLoginRequest request)
        {
            (string Email, string DisplayName)? identity = request.Provider.ToLowerInvariant() switch
            {
                "google" => await VerifyGoogleTokenAsync(request.AccessToken),
                "microsoft" => await VerifyMicrosoftTokenAsync(request.AccessToken),
                _ => null,
            };

            if (identity == null)
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "External sign-in failed",
                    new ApiError
                    {
                        Code = ApiErrorCodes.AUTHENTICATION_FAILED,
                        Message = "Could not verify the provided access token"
                    },
                    HttpStatusCode.BadRequest));
            }

            var user = await _userRepository.GetByEmailAsync(identity.Value.Email);
            if (user == null)
            {
                user = new User
                {
                    Username = await GenerateUniqueUsernameAsync(identity.Value.Email),
                    Email = identity.Value.Email,
                    DisplayName = string.IsNullOrWhiteSpace(identity.Value.DisplayName)
                        ? identity.Value.Email
                        : identity.Value.DisplayName,
                    // Never used to sign in -- external-login is the only
                    // path for this account. A verifiable password would
                    // imply a credential that doesn't exist.
                    PasswordHash = _passwordService.HashPassword(Guid.NewGuid().ToString("N")),
                    Role = UserRole.Member,
                    CreatedAt = DateTime.UtcNow,
                    LastLoginAt = DateTime.UtcNow,
                    IsActive = true,
                    IsEmailVerified = true, // the provider already verified the email
                };
                await _userRepository.CreateAsync(user);
                _logger.LogInformation("New user auto-provisioned via {Provider} sign-in: {Email}", request.Provider, identity.Value.Email);
            }
            else
            {
                user.LastLoginAt = DateTime.UtcNow;
                await _userRepository.UpdateAsync(user);
            }

            var accessToken = _jwtService.GenerateAccessToken(user);

            var authResponse = new AuthResponse
            {
                AccessToken = accessToken,
                RefreshToken = user.RefreshToken ?? string.Empty,
                ExpiresAt = _jwtService.GetTokenExpiration(accessToken),
                User = MapToUserDto(user)
            };

            return Ok(ApiResponse<AuthResponse>.SuccessResponse(
                authResponse,
                "Signed in successfully"));
        }

        private async Task<(string Email, string DisplayName)?> VerifyGoogleTokenAsync(string accessToken)
        {
            try
            {
                var client = _httpClientFactory.CreateClient();
                var request = new HttpRequestMessage(HttpMethod.Get, "https://www.googleapis.com/oauth2/v3/userinfo");
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                var response = await client.SendAsync(request);
                if (!response.IsSuccessStatusCode)
                {
                    return null;
                }
                var info = await response.Content.ReadFromJsonAsync<GoogleUserInfo>();
                if (info == null || string.IsNullOrWhiteSpace(info.Email))
                {
                    return null;
                }
                return (info.Email, info.Name ?? info.Email);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Google access token verification failed");
                return null;
            }
        }

        private async Task<(string Email, string DisplayName)?> VerifyMicrosoftTokenAsync(string accessToken)
        {
            try
            {
                var client = _httpClientFactory.CreateClient();
                var request = new HttpRequestMessage(HttpMethod.Get, "https://graph.microsoft.com/v1.0/me");
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                var response = await client.SendAsync(request);
                if (!response.IsSuccessStatusCode)
                {
                    return null;
                }
                var info = await response.Content.ReadFromJsonAsync<MicrosoftUserInfo>();
                var email = info?.Mail ?? info?.UserPrincipalName;
                if (info == null || string.IsNullOrWhiteSpace(email))
                {
                    return null;
                }
                return (email!, info.DisplayName ?? email!);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Microsoft access token verification failed");
                return null;
            }
        }

        private async Task<string> GenerateUniqueUsernameAsync(string email)
        {
            var baseName = email.Split('@')[0];
            var candidate = baseName;
            var suffix = 0;
            while (await _userRepository.UsernameExistsAsync(candidate))
            {
                suffix++;
                candidate = $"{baseName}{suffix}";
            }
            return candidate;
        }

        private class GoogleUserInfo
        {
            [JsonPropertyName("email")]
            public string? Email { get; set; }
            [JsonPropertyName("name")]
            public string? Name { get; set; }
        }

        private class MicrosoftUserInfo
        {
            [JsonPropertyName("mail")]
            public string? Mail { get; set; }
            [JsonPropertyName("userPrincipalName")]
            public string? UserPrincipalName { get; set; }
            [JsonPropertyName("displayName")]
            public string? DisplayName { get; set; }
        }

        [HttpGet("test-jwt")]
        public ActionResult<ApiResponse<object>> TestJWT()
        {
            try
            {
                // Create a test user for JWT generation
                var testUser = new User
                {
                    Id = 1,
                    Username = "testuser",
                    Email = "test@example.com",
                    DisplayName = "Test User",
                    Role = UserRole.Member,
                    IsEmailVerified = true
                };

                var token = _jwtService.GenerateAccessToken(testUser);
                var parts = token.Split('.');
                
                return Ok(ApiResponse<object>.SuccessResponse(new
                {
                    Token = token,
                    TokenLength = token.Length,
                    Parts = parts.Length,
                    Header = parts.Length > 0 ? parts[0] : "missing",
                    Payload = parts.Length > 1 ? parts[1] : "missing",
                    Signature = parts.Length > 2 ? parts[2] : "missing",
                    IsValidFormat = parts.Length == 3
                }, "JWT test completed"));
            }
            catch (Exception ex)
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "JWT test failed",
                    new ApiError { Code = "JWT_TEST_ERROR", Message = ex.Message },
                    HttpStatusCode.BadRequest));
            }
        }

        [HttpGet("config-status")]
        public ActionResult<ApiResponse<object>> GetConfigurationStatus()
        {
            try
            {
                var config = HttpContext.RequestServices.GetRequiredService<IConfiguration>();
                var (isValid, missingKeys) = WanderlustApi.Configuration.EmbeddedConfiguration.ValidateConfiguration(config);
                
                return Ok(ApiResponse<object>.SuccessResponse(new
                {
                    IsValid = isValid,
                    MissingKeys = missingKeys,
                    HasJwtSecret = !string.IsNullOrEmpty(config["JWT:SecretKey"]),
                    JwtIssuer = config["JWT:Issuer"],
                    JwtAudience = config["JWT:Audience"],
                    FrontendUrl = config["FRONTEND_URL"],
                    CorsOrigins = config.GetSection("CORS:AllowedOrigins").Get<string[]>(),
                    HasConnectionString = !string.IsNullOrEmpty(config.GetConnectionString("DefaultConnection")),
                    Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT"),
                    ConfigurationSources = config.AsEnumerable()
                        .Where(kvp => !kvp.Key.Contains("Secret") && !kvp.Key.Contains("Password"))
                        .Take(10)
                        .ToDictionary(kvp => kvp.Key, kvp => kvp.Value)
                }, "Configuration status retrieved"));
            }
            catch (Exception ex)
            {
                return BadRequest(ApiResponse.ErrorResponse(
                    "Configuration status check failed",
                    new ApiError { Code = "CONFIG_CHECK_ERROR", Message = ex.Message },
                    HttpStatusCode.BadRequest));
            }
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
