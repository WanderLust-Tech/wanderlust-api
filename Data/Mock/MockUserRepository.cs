using WanderlustApi.Data.Repositories;
using WanderlustApi.Models;
using WanderlustApi.Data.Mock;

namespace WanderlustApi.Data.Mock
{
    public class MockUserRepository : IUserRepository
    {
        private readonly ILogger<MockUserRepository> _logger;

        public MockUserRepository(ILogger<MockUserRepository> logger)
        {
            _logger = logger;
            _logger.LogWarning("Using MOCK UserRepository - Database connection failed");
        }

        public async Task<User?> GetByIdAsync(int id)
        {
            await Task.Delay(10); // Simulate async operation
            return MockData.Users.FirstOrDefault(u => u.Id == id);
        }

        public async Task<User?> GetByEmailAsync(string email)
        {
            await Task.Delay(10);
            return MockData.Users.FirstOrDefault(u => u.Email.Equals(email, StringComparison.OrdinalIgnoreCase));
        }

        public async Task<User?> GetByUsernameAsync(string username)
        {
            await Task.Delay(10);
            return MockData.Users.FirstOrDefault(u => u.Username.Equals(username, StringComparison.OrdinalIgnoreCase));
        }

        public async Task<IEnumerable<User>> GetAllAsync()
        {
            await Task.Delay(10);
            return MockData.Users.ToList();
        }

        public async Task<User> CreateAsync(User user)
        {
            await Task.Delay(10);
            user.Id = MockData.GetNextUserId();
            user.CreatedAt = DateTime.UtcNow;
            MockData.Users.Add(user);
            _logger.LogInformation("Created mock user with ID {UserId}", user.Id);
            return user;
        }

        public async Task<User> UpdateAsync(User user)
        {
            await Task.Delay(10);
            var existingUser = MockData.Users.FirstOrDefault(u => u.Id == user.Id);
            if (existingUser != null)
            {
                var index = MockData.Users.IndexOf(existingUser);
                MockData.Users[index] = user;
                _logger.LogInformation("Updated mock user with ID {UserId}", user.Id);
            }
            return user;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            await Task.Delay(10);
            var user = MockData.Users.FirstOrDefault(u => u.Id == id);
            if (user != null)
            {
                MockData.Users.Remove(user);
                _logger.LogInformation("Deleted mock user with ID {UserId}", id);
                return true;
            }
            return false;
        }

        public async Task<bool> ExistsAsync(int id)
        {
            await Task.Delay(10);
            return MockData.Users.Any(u => u.Id == id);
        }

        public async Task<bool> EmailExistsAsync(string email)
        {
            await Task.Delay(10);
            return MockData.Users.Any(u => u.Email.Equals(email, StringComparison.OrdinalIgnoreCase));
        }

        public async Task<bool> UsernameExistsAsync(string username)
        {
            await Task.Delay(10);
            return MockData.Users.Any(u => u.Username.Equals(username, StringComparison.OrdinalIgnoreCase));
        }

        public async Task<int> GetTotalCountAsync()
        {
            await Task.Delay(10);
            return MockData.Users.Count;
        }

        public async Task UpdateLastLoginAsync(int userId)
        {
            await Task.Delay(10);
            var user = MockData.Users.FirstOrDefault(u => u.Id == userId);
            if (user != null)
            {
                user.LastLoginAt = DateTime.UtcNow;
                _logger.LogInformation("Updated last login for mock user ID {UserId}", userId);
            }
        }

        public async Task<bool> UpdateRefreshTokenAsync(int userId, string refreshToken, DateTime expiryTime)
        {
            await Task.Delay(10);
            var user = MockData.Users.FirstOrDefault(u => u.Id == userId);
            if (user != null)
            {
                user.RefreshToken = refreshToken;
                user.RefreshTokenExpiryTime = expiryTime;
                _logger.LogInformation("Updated refresh token for mock user ID {UserId}", userId);
                return true;
            }
            return false;
        }

        public async Task<User?> GetByRefreshTokenAsync(string refreshToken)
        {
            await Task.Delay(10);
            return MockData.Users.FirstOrDefault(u => u.RefreshToken == refreshToken);
        }
    }
}
