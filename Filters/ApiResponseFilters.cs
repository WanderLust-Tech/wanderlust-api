using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;
using WanderlustApi.Models;

namespace WanderlustApi.Filters
{
    /// <summary>
    /// Action filter that automatically handles validation errors and formats them consistently
    /// </summary>
    public class ValidationFilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.ModelState.IsValid)
            {
                var validationErrors = new Dictionary<string, object>();
                
                foreach (var key in context.ModelState.Keys)
                {
                    var errors = context.ModelState[key]?.Errors
                        .Select(e => e.ErrorMessage)
                        .Where(e => !string.IsNullOrEmpty(e))
                        .ToList();
                    
                    if (errors?.Any() == true)
                    {
                        validationErrors[key] = errors.Count == 1 ? errors.First() : errors;
                    }
                }

                var apiError = new ApiError
                {
                    Code = ApiErrorCodes.VALIDATION_ERROR,
                    Message = "One or more validation errors occurred",
                    ValidationErrors = validationErrors,
                    Details = "Please check the provided data and try again"
                };

                var response = ApiResponse.ErrorResponse(
                    "Validation failed", 
                    apiError, 
                    HttpStatusCode.BadRequest);
                
                response.RequestId = context.HttpContext.Items["RequestId"]?.ToString() ?? Guid.NewGuid().ToString();

                context.Result = new BadRequestObjectResult(response);
            }
        }
    }

    /// <summary>
    /// Custom result wrapper that ensures all controller actions return ApiResponse format
    /// </summary>
    public class ApiResponseWrapperAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuted(ActionExecutedContext context)
        {
            // Skip if there's an exception (handled by global exception middleware)
            if (context.Exception != null)
                return;

            // Skip if already wrapped or is a file result
            if (context.Result is ObjectResult objectResult && 
                objectResult.Value?.GetType().IsGenericType == true &&
                objectResult.Value.GetType().GetGenericTypeDefinition() == typeof(ApiResponse<>))
                return;

            if (context.Result is FileResult || context.Result is RedirectResult)
                return;

            var requestId = context.HttpContext.Items["RequestId"]?.ToString() ?? Guid.NewGuid().ToString();

            switch (context.Result)
            {
                case CreatedResult createdResult:
                    var createdResponse = ApiResponse<object>.SuccessResponse(
                        createdResult.Value ?? new object(), 
                        "Resource created successfully");
                    createdResponse.RequestId = requestId;
                    context.Result = new ObjectResult(createdResponse) { StatusCode = 201 };
                    break;

                case AcceptedResult acceptedResult:
                    var acceptedResponse = ApiResponse<object>.SuccessResponse(
                        acceptedResult.Value ?? new object(), 
                        "Request accepted for processing");
                    acceptedResponse.RequestId = requestId;
                    context.Result = new ObjectResult(acceptedResponse) { StatusCode = 202 };
                    break;

                case ObjectResult objResult:
                    var wrappedResponse = ApiResponse<object>.SuccessResponse(
                        objResult.Value ?? new object(), 
                        "Operation completed successfully");
                    wrappedResponse.RequestId = requestId;
                    context.Result = new ObjectResult(wrappedResponse) { StatusCode = objResult.StatusCode };
                    break;

                case EmptyResult:
                case NoContentResult:
                    var noContentResponse = ApiResponse.CreateSuccess("Operation completed successfully");
                    noContentResponse.RequestId = requestId;
                    context.Result = new ObjectResult(noContentResponse) { StatusCode = 200 };
                    break;
            }
        }
    }
}
