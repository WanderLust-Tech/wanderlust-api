using Microsoft.Data.SqlClient;
using System.Data;
using WanderlustApi.Data;

namespace WanderlustApi.Services
{
    public interface IDatabaseHealthService
    {
        Task<bool> IsHealthyAsync();
        bool IsUsingMockData { get; }
    }

    public class DatabaseHealthService : IDatabaseHealthService
    {
        private readonly IDbConnectionFactory? _connectionFactory;
        private readonly ILogger<DatabaseHealthService> _logger;
        private bool _isUsingMockData = false;

        public bool IsUsingMockData => _isUsingMockData;

        public DatabaseHealthService(IDbConnectionFactory? connectionFactory, ILogger<DatabaseHealthService> logger)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
            _isUsingMockData = connectionFactory == null;
        }

        public async Task<bool> IsHealthyAsync()
        {
            // If no connection factory, we're in mock mode
            if (_connectionFactory == null)
            {
                _logger.LogWarning("No database connection factory - using mock data");
                _isUsingMockData = true;
                return false;
            }

            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                // Simple health check query
                if (connection is SqlConnection sqlConnection)
                {
                    using var command = new SqlCommand("SELECT 1", sqlConnection);
                    command.CommandTimeout = 5; // 5 second timeout
                    
                    var result = await command.ExecuteScalarAsync();
                    var isHealthy = result?.ToString() == "1";
                    
                    if (isHealthy)
                    {
                        _logger.LogInformation("Database health check passed");
                        _isUsingMockData = false;
                    }
                    else
                    {
                        _logger.LogWarning("Database health check failed - unexpected result");
                        _isUsingMockData = true;
                    }
                    
                    return isHealthy;
                }
                else
                {
                    _logger.LogError("Database connection is not a SqlConnection");
                    _isUsingMockData = true;
                    return false;
                }
            }
            catch (SqlException ex)
            {
                _logger.LogError(ex, "Database health check failed - SQL Exception: {Message}", ex.Message);
                _isUsingMockData = true;
                return false;
            }
            catch (TimeoutException ex)
            {
                _logger.LogError(ex, "Database health check failed - Timeout: {Message}", ex.Message);
                _isUsingMockData = true;
                return false;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Database health check failed - General Exception: {Message}", ex.Message);
                _isUsingMockData = true;
                return false;
            }
        }

        public void SetMockDataMode()
        {
            _isUsingMockData = true;
            _logger.LogWarning("Forcing mock data mode");
        }
    }
}
