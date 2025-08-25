/**
 * Rate Limiting Middleware
 * Protects API endpoints from abuse and DDoS attacks
 */

using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using System.Collections.Concurrent;
using System.Net;
using System.Threading.Tasks;

namespace WanderlustApi.Middleware
{
    public class RateLimitingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IMemoryCache _cache;
        private readonly ILogger<RateLimitingMiddleware> _logger;
        private readonly RateLimitOptions _options;

        public RateLimitingMiddleware(
            RequestDelegate next, 
            IMemoryCache cache, 
            ILogger<RateLimitingMiddleware> logger,
            RateLimitOptions options)
        {
            _next = next;
            _cache = cache;
            _logger = logger;
            _options = options;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            var clientId = GetClientIdentifier(context);
            var endpoint = GetEndpointKey(context);
            
            var rateLimitKey = $"rate_limit_{clientId}_{endpoint}";
            var requestCount = _cache.Get<int?>(rateLimitKey) ?? 0;

            // Get rate limit for this endpoint
            var limit = GetRateLimitForEndpoint(context.Request.Path);

            if (requestCount >= limit.RequestCount)
            {
                _logger.LogWarning("Rate limit exceeded for client {ClientId} on endpoint {Endpoint}. Count: {RequestCount}", 
                    clientId, endpoint, requestCount);

                context.Response.StatusCode = (int)HttpStatusCode.TooManyRequests;
                context.Response.Headers["Retry-After"] = limit.WindowMinutes.ToString();
                context.Response.Headers["X-RateLimit-Limit"] = limit.RequestCount.ToString();
                context.Response.Headers["X-RateLimit-Remaining"] = "0";
                context.Response.Headers["X-RateLimit-Reset"] = DateTimeOffset.UtcNow.AddMinutes(limit.WindowMinutes).ToUnixTimeSeconds().ToString();

                await context.Response.WriteAsync("Rate limit exceeded. Please try again later.");
                return;
            }

            // Increment request count
            var newCount = requestCount + 1;
            var cacheOptions = new MemoryCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(limit.WindowMinutes)
            };
            _cache.Set(rateLimitKey, newCount, cacheOptions);

            // Add rate limit headers
            context.Response.Headers["X-RateLimit-Limit"] = limit.RequestCount.ToString();
            context.Response.Headers["X-RateLimit-Remaining"] = (limit.RequestCount - newCount).ToString();
            context.Response.Headers["X-RateLimit-Reset"] = DateTimeOffset.UtcNow.AddMinutes(limit.WindowMinutes).ToUnixTimeSeconds().ToString();

            await _next(context);
        }

        private string GetClientIdentifier(HttpContext context)
        {
            // Try to get user ID from JWT claims first
            var userId = context.User?.FindFirst("sub")?.Value ?? 
                        context.User?.FindFirst("userId")?.Value;
            
            if (!string.IsNullOrEmpty(userId))
            {
                return $"user_{userId}";
            }

            // Fall back to IP address
            var ipAddress = context.Connection.RemoteIpAddress?.ToString() ?? "unknown";
            
            // Handle forwarded headers (for load balancers/proxies)
            if (context.Request.Headers.ContainsKey("X-Forwarded-For"))
            {
                ipAddress = context.Request.Headers["X-Forwarded-For"].FirstOrDefault()?.Split(',')[0].Trim() ?? ipAddress;
            }
            else if (context.Request.Headers.ContainsKey("X-Real-IP"))
            {
                ipAddress = context.Request.Headers["X-Real-IP"].FirstOrDefault() ?? ipAddress;
            }

            return $"ip_{ipAddress}";
        }

        private string GetEndpointKey(HttpContext context)
        {
            return $"{context.Request.Method}_{context.Request.Path}";
        }

        private RateLimit GetRateLimitForEndpoint(PathString path)
        {
            // Authentication endpoints - stricter limits
            if (path.StartsWithSegments("/api/auth/login") || path.StartsWithSegments("/api/auth/register"))
            {
                return new RateLimit(5, 15); // 5 requests per 15 minutes
            }

            // Password change - very strict
            if (path.StartsWithSegments("/api/auth/change-password"))
            {
                return new RateLimit(3, 60); // 3 requests per hour
            }

            // General API endpoints
            if (path.StartsWithSegments("/api/"))
            {
                return new RateLimit(100, 15); // 100 requests per 15 minutes
            }

            // Default rate limit
            return new RateLimit(200, 15); // 200 requests per 15 minutes
        }
    }

    public class RateLimit
    {
        public int RequestCount { get; }
        public int WindowMinutes { get; }

        public RateLimit(int requestCount, int windowMinutes)
        {
            RequestCount = requestCount;
            WindowMinutes = windowMinutes;
        }
    }

    public class RateLimitOptions
    {
        public bool EnableRateLimiting { get; set; } = true;
        public int DefaultRequestLimit { get; set; } = 100;
        public int DefaultWindowMinutes { get; set; } = 15;
    }

    // Extension methods
    public static class RateLimitingMiddlewareExtensions
    {
        public static IServiceCollection AddRateLimiting(this IServiceCollection services, Action<RateLimitOptions>? configure = null)
        {
            var options = new RateLimitOptions();
            configure?.Invoke(options);
            services.AddSingleton(options);
            services.AddMemoryCache();
            return services;
        }

        public static IApplicationBuilder UseRateLimiting(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<RateLimitingMiddleware>();
        }
    }
}
