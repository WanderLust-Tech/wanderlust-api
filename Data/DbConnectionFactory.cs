using Microsoft.Data.SqlClient;
using System.Data;
using Dapper;

namespace WanderlustApi.Data
{
    /// <summary>
    /// Database connection service for Dapper operations with SQL Server
    /// </summary>
    public interface IDbConnectionFactory
    {
        Task<IDbConnection> CreateConnectionAsync();
        IDbConnection CreateConnection();
    }

    public class SqlServerConnectionFactory : IDbConnectionFactory
    {
        private readonly string _connectionString;
        private readonly ILogger<SqlServerConnectionFactory> _logger;

        public SqlServerConnectionFactory(string connectionString, ILogger<SqlServerConnectionFactory> logger)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _logger = logger;
        }

        public async Task<IDbConnection> CreateConnectionAsync()
        {
            try
            {
                var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                _logger.LogDebug("Database connection opened successfully");
                return connection;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to create database connection");
                throw;
            }
        }

        public IDbConnection CreateConnection()
        {
            try
            {
                var connection = new SqlConnection(_connectionString);
                connection.Open();
                _logger.LogDebug("Database connection opened successfully");
                return connection;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to create database connection");
                throw;
            }
        }
    }

    /// <summary>
    /// Database initialization service
    /// </summary>
    public interface IDbInitializer
    {
        Task InitializeAsync();
        Task<bool> TestConnectionAsync();
    }

    public class DbInitializer : IDbInitializer
    {
        private readonly IDbConnectionFactory _connectionFactory;
        private readonly ILogger<DbInitializer> _logger;

        public DbInitializer(IDbConnectionFactory connectionFactory, ILogger<DbInitializer> logger)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
        }

        public async Task<bool> TestConnectionAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                _logger.LogInformation("Database connection test successful");
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Database connection test failed");
                return false;
            }
        }

        public async Task InitializeAsync()
        {
            try
            {
                _logger.LogInformation("Starting database initialization...");
                
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                // Test basic connection
                await connection.QueryFirstOrDefaultAsync<int>("SELECT 1");
                
                _logger.LogInformation("Database initialization completed successfully");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Database initialization failed");
                throw;
            }
        }
    }
}
