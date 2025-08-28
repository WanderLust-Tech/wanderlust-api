using Dapper;
using System.Data;
using WanderlustApi.Models;

namespace WanderlustApi.Data.Repositories
{
    /// <summary>
    /// Repository interface for User operations
    /// </summary>
    public interface IUserRepository
    {
        Task<User?> GetByIdAsync(int id);
        Task<User?> GetByEmailAsync(string email);
        Task<User?> GetByUsernameAsync(string username);
        Task<User?> GetByRefreshTokenAsync(string refreshToken);
        Task<IEnumerable<User>> GetAllAsync();
        Task<User> CreateAsync(User user);
        Task<User> UpdateAsync(User user);
        Task<bool> DeleteAsync(int id);
        Task<bool> ExistsAsync(int id);
        Task<bool> EmailExistsAsync(string email);
        Task<bool> UsernameExistsAsync(string username);
    }

    /// <summary>
    /// Dapper implementation of User repository
    /// </summary>
    public class UserRepository : IUserRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;
        private readonly ILogger<UserRepository> _logger;

        public UserRepository(IDbConnectionFactory connectionFactory, ILogger<UserRepository> logger)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
        }

        public async Task<User?> GetByIdAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT Id, Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, 
                           Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, 
                           RefreshToken, RefreshTokenExpiryTime
                    FROM Users 
                    WHERE Id = @Id";

                return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Id = id });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting user by ID {UserId}", id);
                throw;
            }
        }

        public async Task<User?> GetByEmailAsync(string email)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT Id, Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, 
                           Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, 
                           RefreshToken, RefreshTokenExpiryTime
                    FROM Users 
                    WHERE Email = @Email";

                return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Email = email });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting user by email {Email}", email);
                throw;
            }
        }

        public async Task<User?> GetByUsernameAsync(string username)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT Id, Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, 
                           Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, 
                           RefreshToken, RefreshTokenExpiryTime
                    FROM Users 
                    WHERE Username = @Username";

                return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Username = username });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting user by username {Username}", username);
                throw;
            }
        }

        public async Task<User?> GetByRefreshTokenAsync(string refreshToken)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT Id, Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, 
                           Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, 
                           RefreshToken, RefreshTokenExpiryTime
                    FROM Users 
                    WHERE RefreshToken = @RefreshToken";

                return await connection.QueryFirstOrDefaultAsync<User>(sql, new { RefreshToken = refreshToken });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting user by refresh token");
                throw;
            }
        }

        public async Task<IEnumerable<User>> GetAllAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT Id, Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, 
                           Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, 
                           RefreshToken, RefreshTokenExpiryTime
                    FROM Users 
                    ORDER BY CreatedAt DESC";

                return await connection.QueryAsync<User>(sql);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting all users");
                throw;
            }
        }

        public async Task<User> CreateAsync(User user)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    INSERT INTO Users (Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, 
                                     Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, 
                                     RefreshToken, RefreshTokenExpiryTime)
                    VALUES (@Username, @Email, @DisplayName, @PasswordHash, @Bio, @AvatarUrl, 
                            @Role, @IsEmailVerified, @IsActive, @CreatedAt, @LastLoginAt, 
                            @RefreshToken, @RefreshTokenExpiryTime);
                    
                    SELECT CAST(SCOPE_IDENTITY() AS INT);";

                var id = await connection.QuerySingleAsync<int>(sql, user);
                user.Id = id;
                
                _logger.LogInformation("Created user with ID {UserId}", id);
                return user;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error creating user {Email}", user.Email);
                throw;
            }
        }

        public async Task<User> UpdateAsync(User user)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    UPDATE Users 
                    SET Username = @Username, Email = @Email, DisplayName = @DisplayName, 
                        PasswordHash = @PasswordHash, Bio = @Bio, AvatarUrl = @AvatarUrl, 
                        Role = @Role, IsEmailVerified = @IsEmailVerified, IsActive = @IsActive, 
                        LastLoginAt = @LastLoginAt, RefreshToken = @RefreshToken, 
                        RefreshTokenExpiryTime = @RefreshTokenExpiryTime
                    WHERE Id = @Id";

                var rowsAffected = await connection.ExecuteAsync(sql, user);
                
                if (rowsAffected == 0)
                {
                    throw new InvalidOperationException($"User with ID {user.Id} not found");
                }
                
                _logger.LogInformation("Updated user with ID {UserId}", user.Id);
                return user;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating user {UserId}", user.Id);
                throw;
            }
        }

        public async Task<bool> DeleteAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "DELETE FROM Users WHERE Id = @Id";
                
                var rowsAffected = await connection.ExecuteAsync(sql, new { Id = id });
                
                _logger.LogInformation("Deleted user with ID {UserId}", id);
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting user {UserId}", id);
                throw;
            }
        }

        public async Task<bool> ExistsAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "SELECT COUNT(1) FROM Users WHERE Id = @Id";
                
                var count = await connection.QuerySingleAsync<int>(sql, new { Id = id });
                return count > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking if user exists {UserId}", id);
                throw;
            }
        }

        public async Task<bool> EmailExistsAsync(string email)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "SELECT COUNT(1) FROM Users WHERE Email = @Email";
                
                var count = await connection.QuerySingleAsync<int>(sql, new { Email = email });
                return count > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking if email exists {Email}", email);
                throw;
            }
        }

        public async Task<bool> UsernameExistsAsync(string username)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "SELECT COUNT(1) FROM Users WHERE Username = @Username";
                
                var count = await connection.QuerySingleAsync<int>(sql, new { Username = username });
                return count > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking if username exists {Username}", username);
                throw;
            }
        }
    }
}
