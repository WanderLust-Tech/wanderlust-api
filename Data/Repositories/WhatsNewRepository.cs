using Dapper;
using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public class WhatsNewRepository : IWhatsNewRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public WhatsNewRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<WhatsNewEntry>> GetActiveEntriesAsync(string appId)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            return await conn.QueryAsync<WhatsNewEntry>(
                @"SELECT Id, AppId, Version, Title, Body, IsActive, PublishedAt
                  FROM WhatsNewEntries
                  WHERE AppId = @AppId AND IsActive = 1
                  ORDER BY PublishedAt DESC",
                new { AppId = appId });
        }

        public async Task<WhatsNewEntry> CreateEntryAsync(WhatsNewEntry entry)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var id = await conn.ExecuteScalarAsync<int>(
                @"INSERT INTO WhatsNewEntries
                    (AppId, Version, Title, Body, IsActive, PublishedAt)
                  OUTPUT INSERTED.Id
                  VALUES
                    (@AppId, @Version, @Title, @Body, 1, GETUTCDATE())",
                entry);
            entry.Id = id;
            entry.PublishedAt = DateTime.UtcNow;
            return entry;
        }

        public async Task<bool> DeactivateEntryAsync(int id)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.ExecuteAsync(
                "UPDATE WhatsNewEntries SET IsActive = 0 WHERE Id = @Id",
                new { Id = id });
            return rows > 0;
        }
    }
}
