/**
 * Input Validation Middleware
 * Validates and sanitizes input to prevent injection attacks
 */

using Microsoft.AspNetCore.Http;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace WanderlustApi.Middleware
{
    public class InputValidationMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<InputValidationMiddleware> _logger;

        public InputValidationMiddleware(RequestDelegate next, ILogger<InputValidationMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            // Only validate POST, PUT, PATCH requests with JSON content
            if (ShouldValidateRequest(context.Request))
            {
                var originalBodyStream = context.Request.Body;

                try
                {
                    // Read the request body
                    using var reader = new StreamReader(context.Request.Body, Encoding.UTF8);
                    var body = await reader.ReadToEndAsync();

                    // Validate the request body
                    var validationResult = ValidateRequestBody(body, context.Request.Path);
                    
                    if (!validationResult.IsValid)
                    {
                        _logger.LogWarning("Invalid request detected from {RemoteIpAddress} to {Path}: {Reason}", 
                            context.Connection.RemoteIpAddress, context.Request.Path, validationResult.Reason);

                        context.Response.StatusCode = 400;
                        await context.Response.WriteAsync(JsonSerializer.Serialize(new 
                        { 
                            error = "Bad Request", 
                            message = "Invalid input detected"
                        }));
                        return;
                    }

                    // Reset the request body stream with the validated content
                    var validatedBodyBytes = Encoding.UTF8.GetBytes(body);
                    context.Request.Body = new MemoryStream(validatedBodyBytes);
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error validating request body");
                    context.Request.Body = originalBodyStream;
                }
            }

            // Validate query parameters and headers
            if (!ValidateQueryParameters(context.Request) || !ValidateHeaders(context.Request))
            {
                _logger.LogWarning("Invalid query parameters or headers detected from {RemoteIpAddress}", 
                    context.Connection.RemoteIpAddress);
                
                context.Response.StatusCode = 400;
                await context.Response.WriteAsync(JsonSerializer.Serialize(new 
                { 
                    error = "Bad Request", 
                    message = "Invalid request parameters" 
                }));
                return;
            }

            await _next(context);
        }

        private bool ShouldValidateRequest(HttpRequest request)
        {
            var method = request.Method.ToUpper();
            var hasJsonContent = request.ContentType?.Contains("application/json") == true;
            var isWriteOperation = method == "POST" || method == "PUT" || method == "PATCH";
            
            return isWriteOperation && hasJsonContent;
        }

        private ValidationResult ValidateRequestBody(string body, PathString path)
        {
            if (string.IsNullOrWhiteSpace(body))
            {
                return ValidationResult.Valid();
            }

            // Check for SQL injection patterns
            if (ContainsSqlInjectionPatterns(body))
            {
                return ValidationResult.Invalid("Potential SQL injection detected");
            }

            // Check for XSS patterns
            if (ContainsXssPatterns(body))
            {
                return ValidationResult.Invalid("Potential XSS attack detected");
            }

            // Check for command injection patterns
            if (ContainsCommandInjectionPatterns(body))
            {
                return ValidationResult.Invalid("Potential command injection detected");
            }

            // Validate JSON structure
            try
            {
                JsonDocument.Parse(body);
            }
            catch (JsonException)
            {
                return ValidationResult.Invalid("Invalid JSON format");
            }

            // Check for excessively large payloads
            if (body.Length > GetMaxPayloadSize(path))
            {
                return ValidationResult.Invalid("Payload too large");
            }

            return ValidationResult.Valid();
        }

        private bool ValidateQueryParameters(HttpRequest request)
        {
            foreach (var param in request.Query)
            {
                var key = param.Key;
                var values = param.Value;

                // Check key length and characters
                if (key.Length > 100 || ContainsSuspiciousPatterns(key))
                {
                    return false;
                }

                // Check each value
                foreach (var value in values)
                {
                    if (value != null && (value.Length > 1000 || ContainsSuspiciousPatterns(value)))
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        private bool ValidateHeaders(HttpRequest request)
        {
            var suspiciousHeaders = new[] { "X-Forwarded-Host", "X-Original-URL", "X-Rewrite-URL" };
            
            foreach (var header in request.Headers)
            {
                // Check for suspicious headers that could indicate header injection
                if (suspiciousHeaders.Contains(header.Key, StringComparer.OrdinalIgnoreCase))
                {
                    continue; // Skip validation for known proxy headers
                }

                foreach (var value in header.Value)
                {
                    if (value != null && ContainsSuspiciousPatterns(value))
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        private bool ContainsSqlInjectionPatterns(string input)
        {
            var sqlPatterns = new[]
            {
                @"(\b(SELECT|INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|EXEC|EXECUTE)\b)",
                @"(UNION\s+ALL\s+SELECT)",
                @"(;\s*--)",
                @"(\|\||\|)",
                @"(0x[0-9A-Fa-f]+)",
                @"(CHAR\s*\(\s*\d+\s*\))",
                @"(CONVERT\s*\(\s*.*\s*,\s*.*\s*\))"
            };

            return sqlPatterns.Any(pattern => 
                Regex.IsMatch(input, pattern, RegexOptions.IgnoreCase | RegexOptions.Multiline));
        }

        private bool ContainsXssPatterns(string input)
        {
            var xssPatterns = new[]
            {
                @"<script[^>]*>.*?</script>",
                @"javascript:",
                @"on\w+\s*=",
                @"<iframe[^>]*>",
                @"<object[^>]*>",
                @"<embed[^>]*>",
                @"<link[^>]*>",
                @"<meta[^>]*>",
                @"eval\s*\(",
                @"expression\s*\("
            };

            return xssPatterns.Any(pattern => 
                Regex.IsMatch(input, pattern, RegexOptions.IgnoreCase | RegexOptions.Multiline));
        }

        private bool ContainsCommandInjectionPatterns(string input)
        {
            var commandPatterns = new[]
            {
                @"[;&|`]",
                @"\$\([^)]*\)",
                @"`[^`]*`",
                @"\.\./",
                @"\\\.\.\\",
                @"(cmd|powershell|bash|sh)\s+",
                @"(wget|curl|nc|netcat)\s+"
            };

            return commandPatterns.Any(pattern => 
                Regex.IsMatch(input, pattern, RegexOptions.IgnoreCase));
        }

        private bool ContainsSuspiciousPatterns(string input)
        {
            return ContainsSqlInjectionPatterns(input) || 
                   ContainsXssPatterns(input) || 
                   ContainsCommandInjectionPatterns(input);
        }

        private int GetMaxPayloadSize(PathString path)
        {
            // Different endpoints may have different size limits
            if (path.StartsWithSegments("/api/auth"))
            {
                return 1024; // 1KB for auth requests
            }

            if (path.StartsWithSegments("/api/community"))
            {
                return 10240; // 10KB for community posts
            }

            return 5120; // 5KB default
        }
    }

    public class ValidationResult
    {
        public bool IsValid { get; private set; }
        public string? Reason { get; private set; }

        private ValidationResult(bool isValid, string? reason = null)
        {
            IsValid = isValid;
            Reason = reason;
        }

        public static ValidationResult Valid() => new(true);
        public static ValidationResult Invalid(string reason) => new(false, reason);
    }

    // Extension method
    public static class InputValidationMiddlewareExtensions
    {
        public static IApplicationBuilder UseInputValidation(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<InputValidationMiddleware>();
        }
    }
}
