namespace WanderlustApi.Configuration
{
    /// <summary>
    /// Embedded configuration for hosting environments that remove appsettings files
    /// IONOS-compatible: No environment variable access, no unmanaged code
    /// </summary>
    public static class EmbeddedConfiguration
    {
        /// <summary>
        /// Gets the default configuration values as a dictionary
        /// Uses build-time generated values to avoid environment variable restrictions
        /// </summary>
        public static Dictionary<string, string?> GetDefaultConfiguration()
        {
            // First try to get build-time generated configuration
            var buildTimeConfig = GeneratedConfiguration.GetBuildTimeConfiguration();
            
            // Check if placeholders were replaced during build
            var hasBuildTimeValues = !buildTimeConfig["JWT:SecretKey"].Contains("PLACEHOLDER");
            
            if (hasBuildTimeValues)
            {
                return buildTimeConfig;
            }
            
            // Fallback to safe default values (for local development)
            return new Dictionary<string, string?>
            {
                // Database Configuration - safe development fallback
                ["ConnectionStrings:DefaultConnection"] = 
                    "Data Source=localhost;Initial Catalog=WanderlustDb;Integrated Security=true;",
                
                // JWT Configuration - generates secure random key for development
                ["JWT:SecretKey"] = GenerateFallbackJwtSecret(),
                ["JWT:Issuer"] = "WanderlustApi",
                ["JWT:Audience"] = "WanderlustClient",
                ["JWT:ExpirationMinutes"] = "60",
                ["JWT:RefreshTokenExpirationDays"] = "7",
                
                // CORS Configuration - development fallback
                ["CORS:AllowedOrigins:0"] = "http://localhost:3000",
                ["FRONTEND_URL"] = "http://localhost:3000",
                
                // Logging Configuration
                ["Logging:LogLevel:Default"] = "Information",
                ["Logging:LogLevel:Microsoft.AspNetCore"] = "Warning",
                ["Logging:LogLevel:Microsoft.AspNetCore.Hosting.Internal.WebHost"] = "Information",
                ["Logging:LogLevel:Microsoft.EntityFrameworkCore"] = "Warning",
                ["Logging:LogLevel:WanderlustApi"] = "Information",
                ["Logging:LogLevel:WanderlustApi.Data"] = "Information",
                ["Logging:LogLevel:System.Net.Http.HttpClient"] = "Warning",
                ["Logging:Console:IncludeScopes"] = "true",
                
                // General Configuration
                ["AllowedHosts"] = "*"
            };
        }
        
        /// <summary>
        /// Generates a fallback JWT secret if none is provided
        /// Should only be used in development - production should always have a secret
        /// </summary>
        private static string GenerateFallbackJwtSecret()
        {
            // Generate a random 256-bit key for development fallback
            var key = new byte[32];
            using (var rng = System.Security.Cryptography.RandomNumberGenerator.Create())
            {
                rng.GetBytes(key);
            }
            return Convert.ToBase64String(key);
        }
        
        /// <summary>
        /// Validates that all required configuration is present
        /// IONOS-compatible: No environment variable access
        /// </summary>
        public static (bool IsValid, List<string> MissingKeys) ValidateConfiguration(IConfiguration configuration)
        {
            var requiredKeys = new[]
            {
                "ConnectionStrings:DefaultConnection",
                "JWT:SecretKey",
                "JWT:Issuer",
                "JWT:Audience",
                "CORS:AllowedOrigins:0"
            };
            
            var missingKeys = new List<string>();
            
            foreach (var key in requiredKeys)
            {
                var value = configuration[key];
                if (string.IsNullOrEmpty(value))
                {
                    missingKeys.Add(key);
                }
            }
            
            return (missingKeys.Count == 0, missingKeys);
        }
    }
}
