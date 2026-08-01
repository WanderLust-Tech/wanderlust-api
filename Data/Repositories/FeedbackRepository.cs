using Dapper;
using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public class FeedbackRepository : IFeedbackRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public FeedbackRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<FeedbackEntry> CreateAsync(FeedbackEntry entry)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var id = await conn.ExecuteScalarAsync<int>(
                @"INSERT INTO FeedbackEntries
                    (Description, Url, SystemInfo, ContactEmail, IsResolved, CreatedAt)
                  OUTPUT INSERTED.Id
                  VALUES
                    (@Description, @Url, @SystemInfo, @ContactEmail, 0, GETUTCDATE())",
                entry);
            entry.Id = id;
            entry.CreatedAt = DateTime.UtcNow;
            return entry;
        }

        public async Task<IEnumerable<FeedbackEntry>> GetAllAsync()
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            return await conn.QueryAsync<FeedbackEntry>(
                @"SELECT Id, Description, Url, SystemInfo, ContactEmail, IsResolved, CreatedAt
                  FROM FeedbackEntries
                  ORDER BY CreatedAt DESC");
        }

        public async Task<bool> MarkResolvedAsync(int id)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.ExecuteAsync(
                "UPDATE FeedbackEntries SET IsResolved = 1 WHERE Id = @Id",
                new { Id = id });
            return rows > 0;
        }
    }
}
