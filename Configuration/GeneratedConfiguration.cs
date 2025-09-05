using System.CodeDom.Compiler;

namespace WanderlustApi.Configuration
{
    /// <summary>
    /// Generated configuration class - DO NOT EDIT MANUALLY
    /// This file is generated during build from GitHub Secrets
    /// </summary>
    [GeneratedCode("ConfigurationGenerator", "1.0")]
    public static class GeneratedConfiguration
    {
        /// <summary>
        /// Gets the configuration values injected during build process
        /// Values are embedded as constants to avoid environment variable access
        /// </summary>
        public static Dictionary<string, string?> GetBuildTimeConfiguration()
        {
            return new Dictionary<string, string?>
            {
                // These values will be replaced during build by the MSBuild target
                ["ConnectionStrings:DefaultConnection"] = "Data Source=localhost;Initial Catalog=WanderlustDb;Integrated Security=true;",
                ["JWT:SecretKey"] = "DEFAULT_DEVELOPMENT_JWT_SECRET_REPLACE_IN_PRODUCTION",
                ["JWT:Issuer"] = "WanderlustApi",
                ["JWT:Audience"] = "WanderlustClient", 
                ["JWT:ExpirationMinutes"] = "60",
                ["JWT:RefreshTokenExpirationDays"] = "7",
                ["CORS:AllowedOrigins:0"] = "http://localhost:3000",
                ["FRONTEND_URL"] = "http://localhost:3000",
                
                // Non-sensitive configuration
                ["Logging:LogLevel:Default"] = "Information",
                ["Logging:LogLevel:Microsoft.AspNetCore"] = "Warning",
                ["Logging:LogLevel:Microsoft.AspNetCore.Hosting.Internal.WebHost"] = "Information",
                ["Logging:LogLevel:Microsoft.EntityFrameworkCore"] = "Warning",
                ["Logging:LogLevel:WanderlustApi"] = "Information",
                ["Logging:LogLevel:WanderlustApi.Data"] = "Information",
                ["Logging:LogLevel:System.Net.Http.HttpClient"] = "Warning",
                ["Logging:Console:IncludeScopes"] = "true",
                ["AllowedHosts"] = "*"
            };
        }
    }
}
