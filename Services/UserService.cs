using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;
using WanderlustApi.Models;

namespace WanderlustApi.Services
{
    public interface IUserService
    {
        Task<User?> GetUserByIdAsync(int id);
        Task<User?> GetUserByEmailAsync(string email);
        Task<User?> GetUserByUsernameAsync(string username);
        Task<User> CreateUserAsync(User user);
        Task<User> UpdateUserAsync(User user);
        Task<bool> DeleteUserAsync(int id);
        Task<IEnumerable<User>> GetUsersAsync(int page = 1, int pageSize = 20);
        Task<IEnumerable<UserBadge>> GetUserBadgesAsync(int userId);
        Task<UserPreferences?> GetUserPreferencesAsync(int userId);
        Task<UserPreferences> UpdateUserPreferencesAsync(UserPreferences preferences);
        Task<UserBadge> AddUserBadgeAsync(UserBadge badge);
    }

    public class UserService : IUserService
    {
        private readonly string _connectionString;

        public UserService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection")!;
        }

        public async Task<User?> GetUserByIdAsync(int id)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT u.*, up.* FROM Users u
                LEFT JOIN UserPreferences up ON u.Id = up.UserId
                WHERE u.Id = @Id";

            var result = await connection.QueryAsync<User, UserPreferences, User>(
                sql,
                (user, preferences) =>
                {
                    user.Preferences = preferences ?? new UserPreferences { UserId = user.Id };
                    return user;
                },
                new { Id = id },
                splitOn: "Id"
            );

            var user = result.FirstOrDefault();
            if (user != null)
            {
                user.Badges = (await GetUserBadgesAsync(user.Id)).ToList();
            }

            return user;
        }

        public async Task<User?> GetUserByEmailAsync(string email)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT u.*, up.* FROM Users u
                LEFT JOIN UserPreferences up ON u.Id = up.UserId
                WHERE u.Email = @Email";

            var result = await connection.QueryAsync<User, UserPreferences, User>(
                sql,
                (user, preferences) =>
                {
                    user.Preferences = preferences ?? new UserPreferences { UserId = user.Id };
                    return user;
                },
                new { Email = email },
                splitOn: "Id"
            );

            return result.FirstOrDefault();
        }

        public async Task<User?> GetUserByUsernameAsync(string username)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT u.*, up.* FROM Users u
                LEFT JOIN UserPreferences up ON u.Id = up.UserId
                WHERE u.Username = @Username";

            var result = await connection.QueryAsync<User, UserPreferences, User>(
                sql,
                (user, preferences) =>
                {
                    user.Preferences = preferences ?? new UserPreferences { UserId = user.Id };
                    return user;
                },
                new { Username = username },
                splitOn: "Id"
            );

            return result.FirstOrDefault();
        }

        public async Task<User> CreateUserAsync(User user)
        {
            using var connection = new SqlConnection(_connectionString);
            using var transaction = connection.BeginTransaction();

            try
            {
                const string userSql = @"
                    INSERT INTO Users (Username, Email, DisplayName, PasswordHash, Bio, AvatarUrl, Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt, Reputation)
                    OUTPUT INSERTED.Id
                    VALUES (@Username, @Email, @DisplayName, @PasswordHash, @Bio, @AvatarUrl, @Role, @IsEmailVerified, @IsActive, @CreatedAt, @LastLoginAt, @Reputation)";

                user.CreatedAt = DateTime.UtcNow;
                user.LastLoginAt = DateTime.UtcNow;

                var userId = await connection.QuerySingleAsync<int>(userSql, user, transaction);
                user.Id = userId;

                // Create default preferences
                var preferences = new UserPreferences { UserId = userId };
                const string preferencesSql = @"
                    INSERT INTO UserPreferences (UserId, EmailNotifications, PushNotifications, ThemePreference, Language, Timezone, DiscussionSort, AutoSubscribe)
                    OUTPUT INSERTED.Id
                    VALUES (@UserId, @EmailNotifications, @PushNotifications, @ThemePreference, @Language, @Timezone, @DiscussionSort, @AutoSubscribe)";

                var preferencesId = await connection.QuerySingleAsync<string>(preferencesSql, preferences, transaction);
                preferences.Id = preferencesId;
                user.Preferences = preferences;

                transaction.Commit();
                return user;
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
        }

        public async Task<User> UpdateUserAsync(User user)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                UPDATE Users SET 
                    Username = @Username,
                    Email = @Email,
                    DisplayName = @DisplayName,
                    Bio = @Bio,
                    AvatarUrl = @AvatarUrl,
                    Role = @Role,
                    IsEmailVerified = @IsEmailVerified,
                    IsActive = @IsActive,
                    Reputation = @Reputation
                WHERE Id = @Id";

            await connection.ExecuteAsync(sql, user);
            return user;
        }

        public async Task<bool> DeleteUserAsync(int id)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = "UPDATE Users SET IsActive = 0 WHERE Id = @Id"; // Soft delete

            var affected = await connection.ExecuteAsync(sql, new { Id = id });
            return affected > 0;
        }

        public async Task<IEnumerable<User>> GetUsersAsync(int page = 1, int pageSize = 20)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT * FROM Users 
                WHERE IsActive = 1
                ORDER BY CreatedAt DESC
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            var offset = (page - 1) * pageSize;
            return await connection.QueryAsync<User>(sql, new { Offset = offset, PageSize = pageSize });
        }

        public async Task<IEnumerable<UserBadge>> GetUserBadgesAsync(int userId)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = "SELECT * FROM UserBadges WHERE UserId = @UserId ORDER BY EarnedDate DESC";

            return await connection.QueryAsync<UserBadge>(sql, new { UserId = userId });
        }

        public async Task<UserPreferences?> GetUserPreferencesAsync(int userId)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = "SELECT * FROM UserPreferences WHERE UserId = @UserId";

            return await connection.QueryFirstOrDefaultAsync<UserPreferences>(sql, new { UserId = userId });
        }

        public async Task<UserPreferences> UpdateUserPreferencesAsync(UserPreferences preferences)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                UPDATE UserPreferences SET 
                    EmailNotifications = @EmailNotifications,
                    PushNotifications = @PushNotifications,
                    ThemePreference = @ThemePreference,
                    Language = @Language,
                    Timezone = @Timezone,
                    DiscussionSort = @DiscussionSort,
                    AutoSubscribe = @AutoSubscribe
                WHERE UserId = @UserId";

            await connection.ExecuteAsync(sql, preferences);
            return preferences;
        }

        public async Task<UserBadge> AddUserBadgeAsync(UserBadge badge)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                INSERT INTO UserBadges (Name, Description, Icon, Color, EarnedDate, Category, UserId)
                OUTPUT INSERTED.Id
                VALUES (@Name, @Description, @Icon, @Color, @EarnedDate, @Category, @UserId)";

            badge.EarnedDate = DateTime.UtcNow;
            var badgeId = await connection.QuerySingleAsync<string>(sql, badge);
            badge.Id = badgeId;

            return badge;
        }
    }
}
