namespace WanderlustApi.Configuration
{
    /// <summary>
    /// Embedded configuration for hosting environments that remove appsettings files
    /// </summary>
    public static class EmbeddedConfiguration
    {
        /// <summary>
        /// Gets the default configuration values as a dictionary
        /// Useful when appsettings files are removed by hosting provider
        /// </summary>
        public static Dictionary<string, string> GetDefaultConfiguration()
        {
            return new Dictionary<string, string>
            {
                // Database Configuration
                ["ConnectionStrings:DefaultConnection"] = 
                    "Data Source=db1062671304.hosting-data.io,1433;Initial Catalog=db1062671304;User Id=dbo1062671304;Password=Milrendaria_1976#;",
                
                // JWT Configuration
                ["JWT:SecretKey"] = "wCDHSUPSjlP+LoqKrNiW6LQARIuFCXewRhZDVvDeYMM=",
                ["JWT:Issuer"] = "WanderlustApi",
                ["JWT:Audience"] = "WanderlustClient",
                ["JWT:ExpirationMinutes"] = "60",
                ["JWT:RefreshTokenExpirationDays"] = "7",
                
                // CORS Configuration
                ["CORS:AllowedOrigins:0"] = "https://kb.wander-lust.tech",
                ["FRONTEND_URL"] = "https://kb.wander-lust.tech",
                
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
        /// Gets configuration with environment variable overrides
        /// </summary>
        public static Dictionary<string, string> GetConfigurationWithEnvironmentOverrides()
        {
            var config = GetDefaultConfiguration();
            
            // Override with environment variables if available
            var envOverrides = new Dictionary<string, string>
            {
                ["ConnectionStrings:DefaultConnection"] = Environment.GetEnvironmentVariable("CONNECTION_STRING"),
                ["JWT:SecretKey"] = Environment.GetEnvironmentVariable("JWT_SECRET_KEY"),
                ["JWT:Issuer"] = Environment.GetEnvironmentVariable("JWT_ISSUER"),
                ["JWT:Audience"] = Environment.GetEnvironmentVariable("JWT_AUDIENCE"),
                ["JWT:ExpirationMinutes"] = Environment.GetEnvironmentVariable("JWT_EXPIRATION_MINUTES"),
                ["JWT:RefreshTokenExpirationDays"] = Environment.GetEnvironmentVariable("JWT_REFRESH_EXPIRATION_DAYS"),
                ["CORS:AllowedOrigins:0"] = Environment.GetEnvironmentVariable("FRONTEND_URL"),
                ["FRONTEND_URL"] = Environment.GetEnvironmentVariable("FRONTEND_URL")
            };
            
            // Apply non-null environment overrides
            foreach (var kvp in envOverrides)
            {
                if (!string.IsNullOrEmpty(kvp.Value))
                {
                    config[kvp.Key] = kvp.Value;
                }
            }
            
            return config;
        }
        
        /// <summary>
        /// Validates that all required configuration is present
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
