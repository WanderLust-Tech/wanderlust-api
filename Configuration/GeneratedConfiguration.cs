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
                // These values will be replaced during build by the PowerShell script
                ["ConnectionStrings:DefaultConnection"] = "Data Source=db1062671304.hosting-data.io,1433;Initial Catalog=db1062671304;User Id=dbo1062671304;Password=Milrendaria_1976#;",
                ["JWT:SecretKey"] = "wCDHSUPSjlP+LoqKrNiW6LQARIuFCXewRhZDVvDeYMM=",
                ["JWT:Issuer"] = "WanderlustApi",
                ["JWT:Audience"] = "WanderlustClient",
                ["JWT:ExpirationMinutes"] = "60",
                ["JWT:RefreshTokenExpirationDays"] = "7",
                ["CORS:AllowedOrigins:0"] = "https://kb.wander-lust.tech",
                ["FRONTEND_URL"] = "https://kb.wander-lust.tech",

                // Non-sensitive configuration - LOGGING DISABLED
                ["Logging:LogLevel:Default"] = "None",
                ["Logging:LogLevel:Microsoft.AspNetCore"] = "None",
                ["Logging:LogLevel:Microsoft.AspNetCore.Hosting.Internal.WebHost"] = "None",
                ["Logging:LogLevel:Microsoft.EntityFrameworkCore"] = "None",
                ["Logging:LogLevel:WanderlustApi"] = "None",
                ["Logging:LogLevel:WanderlustApi.Data"] = "None",
                ["Logging:LogLevel:System.Net.Http.HttpClient"] = "None",
                ["Logging:Console:IncludeScopes"] = "false",
                ["AllowedHosts"] = "*"
            };
        }
    }
}
