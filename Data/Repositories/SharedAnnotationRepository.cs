using Dapper;
using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public class SharedAnnotationRepository : ISharedAnnotationRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public SharedAnnotationRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<SharedAnnotation>> GetActiveForUrlAsync(string url)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            return await conn.QueryAsync<SharedAnnotation>(
                @"SELECT Id, Url, Text, UserId, UserName, IsActive, CreatedAt
                  FROM SharedAnnotations
                  WHERE Url = @Url AND IsActive = 1
                  ORDER BY CreatedAt DESC",
                new { Url = url });
        }

        public async Task<SharedAnnotation> CreateAsync(SharedAnnotation annotation)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var id = await conn.ExecuteScalarAsync<int>(
                @"INSERT INTO SharedAnnotations
                    (Url, Text, UserId, UserName, IsActive, CreatedAt)
                  OUTPUT INSERTED.Id
                  VALUES
                    (@Url, @Text, @UserId, @UserName, 1, GETUTCDATE())",
                annotation);
            annotation.Id = id;
            annotation.CreatedAt = DateTime.UtcNow;
            return annotation;
        }

        public async Task<SharedAnnotation?> GetByIdAsync(int id)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            return await conn.QuerySingleOrDefaultAsync<SharedAnnotation>(
                @"SELECT Id, Url, Text, UserId, UserName, IsActive, CreatedAt
                  FROM SharedAnnotations WHERE Id = @Id",
                new { Id = id });
        }

        public async Task<bool> DeactivateAsync(int id)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.ExecuteAsync(
                "UPDATE SharedAnnotations SET IsActive = 0 WHERE Id = @Id",
                new { Id = id });
            return rows > 0;
        }
    }
}
