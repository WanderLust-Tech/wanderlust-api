using System.Net;

namespace WanderlustApi.Models
{
    /// <summary>
    /// Standard API response wrapper for all endpoints
    /// </summary>
    /// <typeparam name="T">The type of data being returned</typeparam>
    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public T? Data { get; set; }
        public ApiError? Error { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
        public string? RequestId { get; set; }
        public int StatusCode { get; set; }

        public static ApiResponse<T> SuccessResponse(T data, string message = "Operation completed successfully")
        {
            return new ApiResponse<T>
            {
                Success = true,
                Message = message,
                Data = data,
                StatusCode = (int)HttpStatusCode.OK
            };
        }

        public static ApiResponse<T> ErrorResponse(string message, ApiError error, HttpStatusCode statusCode = HttpStatusCode.InternalServerError)
        {
            return new ApiResponse<T>
            {
                Success = false,
                Message = message,
                Error = error,
                StatusCode = (int)statusCode
            };
        }
    }

    /// <summary>
    /// Detailed error information
    /// </summary>
    public class ApiError
    {
        public string Code { get; set; } = string.Empty;
        public string Message { get; set; } = string.Empty;
        public string? Details { get; set; }
        public string? StackTrace { get; set; }
        public string? InnerException { get; set; }
        public Dictionary<string, object>? ValidationErrors { get; set; }
        public string Source { get; set; } = string.Empty;
        public string? HelpLink { get; set; }
    }

    /// <summary>
    /// Standard error codes used throughout the API
    /// </summary>
    public static class ApiErrorCodes
    {
        // General errors
        public const string INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR";
        public const string INTERNAL_ERROR = "INTERNAL_ERROR";
        public const string BAD_REQUEST = "BAD_REQUEST";
        public const string UNAUTHORIZED = "UNAUTHORIZED";
        public const string FORBIDDEN = "FORBIDDEN";
        public const string NOT_FOUND = "NOT_FOUND";
        public const string CONFLICT = "CONFLICT";
        public const string VALIDATION_ERROR = "VALIDATION_ERROR";

        // Authentication errors
        public const string AUTHENTICATION_FAILED = "AUTHENTICATION_FAILED";
        public const string INVALID_CREDENTIALS = "INVALID_CREDENTIALS";
        public const string TOKEN_EXPIRED = "TOKEN_EXPIRED";
        public const string TOKEN_INVALID = "TOKEN_INVALID";
        public const string ACCOUNT_DISABLED = "ACCOUNT_DISABLED";
        public const string EMAIL_NOT_VERIFIED = "EMAIL_NOT_VERIFIED";

        // Database errors
        public const string DATABASE_ERROR = "DATABASE_ERROR";
        public const string ENTITY_NOT_FOUND = "ENTITY_NOT_FOUND";
        public const string DUPLICATE_ENTITY = "DUPLICATE_ENTITY";
        public const string FOREIGN_KEY_VIOLATION = "FOREIGN_KEY_VIOLATION";

        // File/Media errors
        public const string FILE_NOT_FOUND = "FILE_NOT_FOUND";
        public const string FILE_TOO_LARGE = "FILE_TOO_LARGE";
        public const string INVALID_FILE_TYPE = "INVALID_FILE_TYPE";
        public const string FILE_UPLOAD_FAILED = "FILE_UPLOAD_FAILED";
        public const string STORAGE_ERROR = "STORAGE_ERROR";

        // External service errors
        public const string EXTERNAL_SERVICE_ERROR = "EXTERNAL_SERVICE_ERROR";
        public const string EXTERNAL_API_ERROR = "EXTERNAL_API_ERROR";
        public const string RATE_LIMITED = "RATE_LIMITED";
        public const string SERVICE_UNAVAILABLE = "SERVICE_UNAVAILABLE";

        // Business logic errors
        public const string BUSINESS_RULE_VIOLATION = "BUSINESS_RULE_VIOLATION";
        public const string RESOURCE_LOCKED = "RESOURCE_LOCKED";
        public const string INSUFFICIENT_PERMISSIONS = "INSUFFICIENT_PERMISSIONS";
        public const string QUOTA_EXCEEDED = "QUOTA_EXCEEDED";
        public const string OPERATION_NOT_ALLOWED = "OPERATION_NOT_ALLOWED";

        // System errors
        public const string CONFIGURATION_ERROR = "CONFIGURATION_ERROR";
        public const string DEPENDENCY_ERROR = "DEPENDENCY_ERROR";
        public const string TIMEOUT_ERROR = "TIMEOUT_ERROR";
        public const string MAINTENANCE_MODE = "MAINTENANCE_MODE";
    }

    /// <summary>
    /// Non-generic version for responses without data
    /// </summary>
    public class ApiResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public object? Data { get; set; }
        public ApiError? Error { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
        public string? RequestId { get; set; }
        public int StatusCode { get; set; }

        public static ApiResponse CreateSuccess(string message = "Operation completed successfully")
        {
            return new ApiResponse
            {
                Success = true,
                Message = message,
                Data = null,
                StatusCode = (int)HttpStatusCode.OK,
                Timestamp = DateTime.UtcNow
            };
        }

        public static ApiResponse ErrorResponse(string message, ApiError error, HttpStatusCode statusCode = HttpStatusCode.InternalServerError)
        {
            return new ApiResponse
            {
                Success = false,
                Message = message,
                Data = null,
                Error = error,
                StatusCode = (int)statusCode,
                Timestamp = DateTime.UtcNow
            };
        }
    }
}
