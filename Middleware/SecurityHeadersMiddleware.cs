/**
 * Security Headers Middleware
 * Adds comprehensive security headers to protect against common attacks
 */

using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;

namespace WanderlustApi.Middleware
{
    public class SecurityHeadersMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<SecurityHeadersMiddleware> _logger;

        public SecurityHeadersMiddleware(RequestDelegate next, ILogger<SecurityHeadersMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            // Remove server information disclosure
            context.Response.Headers.Remove("Server");
            context.Response.Headers.Remove("X-Powered-By");
            context.Response.Headers.Remove("X-AspNet-Version");
            context.Response.Headers.Remove("X-AspNetMvc-Version");

            // Add security headers
            AddSecurityHeaders(context);

            // Continue to next middleware
            await _next(context);
        }

        private void AddSecurityHeaders(HttpContext context)
        {
            var headers = context.Response.Headers;

            // Prevent clickjacking attacks
            headers["X-Frame-Options"] = "DENY";

            // Prevent MIME type sniffing
            headers["X-Content-Type-Options"] = "nosniff";

            // Enable XSS protection in browsers
            headers["X-XSS-Protection"] = "1; mode=block";

            // Referrer policy - control referrer information
            headers["Referrer-Policy"] = "strict-origin-when-cross-origin";

            // Permissions policy - control browser features
            headers["Permissions-Policy"] = 
                "camera=(), microphone=(), geolocation=(), payment=(), usb=(), magnetometer=(), gyroscope=(), speaker=()";

            // Content Security Policy (CSP)
            var cspPolicy = BuildContentSecurityPolicy(context);
            headers["Content-Security-Policy"] = cspPolicy;

            // HTTP Strict Transport Security (HSTS) - only add for HTTPS requests
            if (context.Request.IsHttps)
            {
                headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains; preload";
            }

            // Cross-Origin policies
            headers["Cross-Origin-Embedder-Policy"] = "require-corp";
            headers["Cross-Origin-Opener-Policy"] = "same-origin";
            headers["Cross-Origin-Resource-Policy"] = "cross-origin";

            // Additional security headers
            headers["X-Permitted-Cross-Domain-Policies"] = "none";
            headers["Cache-Control"] = "no-store, no-cache, must-revalidate, proxy-revalidate";
            headers["Pragma"] = "no-cache";
            headers["Expires"] = "0";
        }

        private string BuildContentSecurityPolicy(HttpContext context)
        {
            var isDevelopment = context.RequestServices.GetRequiredService<IWebHostEnvironment>().IsDevelopment();

            var csp = new List<string>
            {
                "default-src 'self'",
                "script-src 'self'",
                "style-src 'self' 'unsafe-inline'", // Allow inline styles for some UI frameworks
                "img-src 'self' data: https:",
                "font-src 'self' https:",
                "connect-src 'self'",
                "media-src 'self'",
                "object-src 'none'",
                "child-src 'none'",
                "frame-src 'none'",
                "worker-src 'none'",
                "frame-ancestors 'none'",
                "form-action 'self'",
                "base-uri 'self'",
                "manifest-src 'self'"
            };

            // In development, allow additional sources for hot reload, etc.
            if (isDevelopment)
            {
                csp[1] = "script-src 'self' 'unsafe-eval'"; // Allow eval for development tools
                csp[4] = "connect-src 'self' ws: wss: http://localhost:* https://localhost:*"; // Allow websockets and localhost
            }

            return string.Join("; ", csp);
        }
    }

    // Extension method for easy registration
    public static class SecurityHeadersMiddlewareExtensions
    {
        public static IApplicationBuilder UseSecurityHeaders(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<SecurityHeadersMiddleware>();
        }
    }
}
