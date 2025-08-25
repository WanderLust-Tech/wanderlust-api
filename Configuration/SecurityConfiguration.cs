/**
 * Security Configuration Helper
 * Centralizes security-related configuration and validation
 */

namespace WanderlustApi.Configuration
{
    public class SecurityOptions
    {
        public const string SectionName = "Security";

        public bool RequireHttps { get; set; } = true;
        public bool EnableHsts { get; set; } = true;
        public int HstsMaxAge { get; set; } = 31536000; // 1 year
        public bool EnableRateLimiting { get; set; } = true;
        public string[] AllowedOrigins { get; set; } = Array.Empty<string>();
    }

    public static class SecurityConfigurationExtensions
    {
        public static IServiceCollection AddSecurityConfiguration(this IServiceCollection services, IConfiguration configuration)
        {
            var securityOptions = new SecurityOptions();
            configuration.GetSection(SecurityOptions.SectionName).Bind(securityOptions);
            
            // Validate security configuration
            ValidateSecurityOptions(securityOptions, configuration);
            
            services.Configure<SecurityOptions>(configuration.GetSection(SecurityOptions.SectionName));
            
            return services;
        }

        private static void ValidateSecurityOptions(SecurityOptions options, IConfiguration configuration)
        {
            var environment = configuration["ASPNETCORE_ENVIRONMENT"] ?? "Development";
            var isProduction = environment.Equals("Production", StringComparison.OrdinalIgnoreCase);

            // Production security validation
            if (isProduction)
            {
                if (!options.RequireHttps)
                {
                    throw new InvalidOperationException("HTTPS must be required in production environment");
                }

                if (!options.EnableHsts)
                {
                    throw new InvalidOperationException("HSTS must be enabled in production environment");
                }

                if (options.AllowedOrigins.Any(origin => origin.StartsWith("http://") && !origin.Contains("localhost")))
                {
                    throw new InvalidOperationException("HTTP origins (except localhost) are not allowed in production");
                }

                // Validate JWT secret key length
                var jwtSecretKey = configuration["JWT:SecretKey"];
                if (string.IsNullOrEmpty(jwtSecretKey) || jwtSecretKey.Length < 32)
                {
                    throw new InvalidOperationException("JWT SecretKey must be at least 256 bits (32 characters) in production");
                }

                // Check for default/weak secrets
                var weakSecrets = new[]
                {
                    "your-super-secret-key",
                    "your-production-secret-key",
                    "default-secret",
                    "change-me",
                    "password",
                    "secret"
                };

                if (weakSecrets.Any(weak => jwtSecretKey.ToLower().Contains(weak)))
                {
                    throw new InvalidOperationException("JWT SecretKey appears to be a default/weak value. Please use a strong, random secret key in production");
                }
            }

            // General validation
            if (options.HstsMaxAge < 300) // Minimum 5 minutes
            {
                throw new InvalidOperationException("HSTS MaxAge should be at least 300 seconds (5 minutes)");
            }

            if (options.AllowedOrigins.Length == 0)
            {
                throw new InvalidOperationException("At least one allowed origin must be specified");
            }
        }
    }

    public class SecurityValidationService
    {
        private readonly ILogger<SecurityValidationService> _logger;
        private readonly IConfiguration _configuration;

        public SecurityValidationService(ILogger<SecurityValidationService> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public void ValidateSecuritySettings()
        {
            var environment = _configuration["ASPNETCORE_ENVIRONMENT"] ?? "Development";
            _logger.LogInformation("Validating security settings for environment: {Environment}", environment);

            // Check for exposed development secrets in production
            if (environment.Equals("Production", StringComparison.OrdinalIgnoreCase))
            {
                ValidateProductionSecrets();
            }

            // Validate CORS settings
            ValidateCorsSettings();

            // Validate authentication settings
            ValidateAuthenticationSettings();

            _logger.LogInformation("Security validation completed successfully");
        }

        private void ValidateProductionSecrets()
        {
            var connectionString = _configuration.GetConnectionString("DefaultConnection");
            if (!string.IsNullOrEmpty(connectionString) && 
                (connectionString.Contains("localhost") || connectionString.Contains("127.0.0.1")))
            {
                _logger.LogWarning("Production environment is using localhost database connection");
            }

            var jwtSecret = _configuration["JWT:SecretKey"];
            if (!string.IsNullOrEmpty(jwtSecret) && jwtSecret.Length < 32)
            {
                throw new InvalidOperationException("JWT secret key is too short for production use");
            }
        }

        private void ValidateCorsSettings()
        {
            var allowedOrigins = _configuration.GetSection("Security:AllowedOrigins").Get<string[]>() ?? Array.Empty<string>();
            
            foreach (var origin in allowedOrigins)
            {
                if (!Uri.TryCreate(origin, UriKind.Absolute, out var uri))
                {
                    throw new InvalidOperationException($"Invalid CORS origin: {origin}");
                }

                if (uri.Scheme != "https" && !origin.Contains("localhost"))
                {
                    _logger.LogWarning("Non-HTTPS CORS origin detected: {Origin}", origin);
                }
            }
        }

        private void ValidateAuthenticationSettings()
        {
            var issuer = _configuration["JWT:Issuer"];
            var audience = _configuration["JWT:Audience"];

            if (string.IsNullOrEmpty(issuer))
            {
                throw new InvalidOperationException("JWT Issuer must be configured");
            }

            if (string.IsNullOrEmpty(audience))
            {
                throw new InvalidOperationException("JWT Audience must be configured");
            }
        }
    }
}
