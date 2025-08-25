/**
 * Error Controller
 * Handles global exceptions and provides secure error responses
 */

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Diagnostics;
using System.Net;
using System.Diagnostics;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ErrorController : ControllerBase
    {
        private readonly ILogger<ErrorController> _logger;

        public ErrorController(ILogger<ErrorController> logger)
        {
            _logger = logger;
        }

        [Route("")]
        [ApiExplorerSettings(IgnoreApi = true)]
        public IActionResult Error()
        {
            var exceptionHandlerFeature = HttpContext.Features.Get<IExceptionHandlerFeature>();
            var exception = exceptionHandlerFeature?.Error;

            var requestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier;

            if (exception != null)
            {
                _logger.LogError(exception, "Unhandled exception occurred. RequestId: {RequestId}", requestId);
            }

            // Don't expose internal error details in production
            var response = new
            {
                error = "Internal Server Error",
                message = "An unexpected error occurred. Please try again later.",
                requestId = requestId,
                timestamp = DateTimeOffset.UtcNow
            };

            return StatusCode((int)HttpStatusCode.InternalServerError, response);
        }
    }
}
