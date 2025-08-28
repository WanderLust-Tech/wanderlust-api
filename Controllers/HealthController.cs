using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Services;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HealthController : ControllerBase
    {
        private readonly IDatabaseHealthService _databaseHealth;
        private readonly ILogger<HealthController> _logger;

        public HealthController(IDatabaseHealthService databaseHealth, ILogger<HealthController> logger)
        {
            _databaseHealth = databaseHealth;
            _logger = logger;
        }

        [HttpGet]
        public async Task<ActionResult<object>> GetHealth()
        {
            try
            {
                var isDatabaseHealthy = await _databaseHealth.IsHealthyAsync();
                var isUsingMockData = _databaseHealth.IsUsingMockData;

                var healthStatus = new
                {
                    Status = "Healthy",
                    Timestamp = DateTime.UtcNow,
                    Database = new
                    {
                        IsConnected = isDatabaseHealthy,
                        IsUsingMockData = isUsingMockData,
                        Status = isDatabaseHealthy ? "Connected" : "Disconnected - Using Mock Data"
                    },
                    Application = new
                    {
                        Version = "4.0.0",
                        Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Unknown",
                        DataMode = isUsingMockData ? "Mock Data" : "Database"
                    }
                };

                _logger.LogInformation("Health check requested - Database: {DatabaseStatus}, Mock: {MockStatus}", 
                    isDatabaseHealthy ? "Connected" : "Disconnected", isUsingMockData);

                return Ok(ApiResponse<object>.SuccessResponse(healthStatus, "Application health status"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Health check failed");
                
                var errorStatus = new
                {
                    Status = "Unhealthy",
                    Timestamp = DateTime.UtcNow,
                    Error = "Health check failed",
                    Database = new
                    {
                        IsConnected = false,
                        IsUsingMockData = true,
                        Status = "Error - Using Mock Data"
                    }
                };

                return StatusCode(503, ApiResponse.ErrorResponse("Service temporarily unavailable", new ApiError { Code = "SERVICE_UNAVAILABLE", Message = "Health check failed" }, System.Net.HttpStatusCode.ServiceUnavailable));
            }
        }

        [HttpGet("database")]
        public async Task<ActionResult<object>> GetDatabaseHealth()
        {
            try
            {
                var isDatabaseHealthy = await _databaseHealth.IsHealthyAsync();
                var isUsingMockData = _databaseHealth.IsUsingMockData;

                var databaseStatus = new
                {
                    IsConnected = isDatabaseHealthy,
                    IsUsingMockData = isUsingMockData,
                    Status = isDatabaseHealthy ? "Connected" : "Disconnected",
                    Message = isUsingMockData ? "Using mock data due to database connection failure" : "Connected to database",
                    Timestamp = DateTime.UtcNow
                };

                return Ok(ApiResponse<object>.SuccessResponse(databaseStatus, "Database health status"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Database health check failed");
                return StatusCode(503, ApiResponse.ErrorResponse("Database health check failed", new ApiError { Code = "DATABASE_UNAVAILABLE", Message = ex.Message }, System.Net.HttpStatusCode.ServiceUnavailable));
            }
        }
    }
}
