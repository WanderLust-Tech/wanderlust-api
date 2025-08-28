using System.Net;
using System.Text.Json;
using WanderlustApi.Models;

namespace WanderlustApi.Middleware
{
    /// <summary>
    /// Global exception handling middleware that catches all unhandled exceptions
    /// and returns them in a consistent ApiResponse format
    /// </summary>
    public class GlobalExceptionHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<GlobalExceptionHandlingMiddleware> _logger;
        private readonly IWebHostEnvironment _environment;

        public GlobalExceptionHandlingMiddleware(
            RequestDelegate next, 
            ILogger<GlobalExceptionHandlingMiddleware> logger,
            IWebHostEnvironment environment)
        {
            _next = next;
            _logger = logger;
            _environment = environment;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                // Add request ID for tracking
                if (!context.Items.ContainsKey("RequestId"))
                {
                    context.Items["RequestId"] = Guid.NewGuid().ToString();
                }

                await _next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unhandled exception occurred. RequestId: {RequestId}", 
                    context.Items["RequestId"]);
                
                await HandleExceptionAsync(context, ex);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            var requestId = context.Items["RequestId"]?.ToString() ?? Guid.NewGuid().ToString();
            
            var (statusCode, errorCode, message) = GetErrorDetails(exception);
            
            var apiError = new ApiError
            {
                Code = errorCode,
                Message = exception.Message,
                Details = GetErrorDetails(exception, _environment.IsDevelopment()),
                Source = exception.Source ?? "Unknown",
                StackTrace = _environment.IsDevelopment() ? exception.StackTrace : null,
                InnerException = _environment.IsDevelopment() ? exception.InnerException?.Message : null
            };

            var response = ApiResponse.ErrorResponse(message, apiError, statusCode);
            response.RequestId = requestId;

            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)statusCode;

            var jsonOptions = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                WriteIndented = true
            };

            var jsonResponse = JsonSerializer.Serialize(response, jsonOptions);
            await context.Response.WriteAsync(jsonResponse);
        }

        private static (HttpStatusCode statusCode, string errorCode, string message) GetErrorDetails(Exception exception)
        {
            return exception switch
            {
                ArgumentNullException => (HttpStatusCode.BadRequest, ApiErrorCodes.BAD_REQUEST, "A required parameter was not provided"),
                ArgumentException => (HttpStatusCode.BadRequest, ApiErrorCodes.BAD_REQUEST, "Invalid argument provided"),
                UnauthorizedAccessException => (HttpStatusCode.Unauthorized, ApiErrorCodes.UNAUTHORIZED, "Access denied"),
                DirectoryNotFoundException => (HttpStatusCode.NotFound, ApiErrorCodes.NOT_FOUND, "Resource not found"),
                FileNotFoundException => (HttpStatusCode.NotFound, ApiErrorCodes.FILE_NOT_FOUND, "File not found"),
                KeyNotFoundException => (HttpStatusCode.NotFound, ApiErrorCodes.ENTITY_NOT_FOUND, "Requested entity not found"),
                InvalidOperationException => (HttpStatusCode.Conflict, ApiErrorCodes.OPERATION_NOT_ALLOWED, "Operation not allowed in current state"),
                NotSupportedException => (HttpStatusCode.BadRequest, ApiErrorCodes.OPERATION_NOT_ALLOWED, "Operation not supported"),
                TimeoutException => (HttpStatusCode.RequestTimeout, "REQUEST_TIMEOUT", "The request timed out"),
                
                // Database specific exceptions (MySQL/generic)
                System.Data.Common.DbException when exception.Message.Contains("foreign key") || exception.Message.Contains("FOREIGN KEY") => 
                    (HttpStatusCode.BadRequest, ApiErrorCodes.FOREIGN_KEY_VIOLATION, "Related entity not found"),
                System.Data.Common.DbException when exception.Message.Contains("unique") || exception.Message.Contains("UNIQUE") || exception.Message.Contains("duplicate") => 
                    (HttpStatusCode.Conflict, ApiErrorCodes.DUPLICATE_ENTITY, "Entity already exists"),
                System.Data.Common.DbException => (HttpStatusCode.InternalServerError, ApiErrorCodes.DATABASE_ERROR, "Database operation failed"),
                
                // Default case
                _ => (HttpStatusCode.InternalServerError, ApiErrorCodes.INTERNAL_SERVER_ERROR, "An unexpected error occurred")
            };
        }

        private static string GetErrorDetails(Exception exception, bool includeDetails)
        {
            if (!includeDetails)
                return "An error occurred while processing your request.";

            var details = $"Exception Type: {exception.GetType().Name}\n";
            details += $"Message: {exception.Message}\n";
            
            if (exception.InnerException != null)
            {
                details += $"Inner Exception: {exception.InnerException.GetType().Name}: {exception.InnerException.Message}\n";
            }

            return details;
        }
    }

    /// <summary>
    /// Extension method to register the global exception handling middleware
    /// </summary>
    public static class GlobalExceptionHandlingMiddlewareExtensions
    {
        public static IApplicationBuilder UseGlobalExceptionHandling(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<GlobalExceptionHandlingMiddleware>();
        }
    }
}
