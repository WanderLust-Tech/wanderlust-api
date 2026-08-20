using Dapper;
using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public class QaChecklistRepository : IQaChecklistRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public QaChecklistRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IReadOnlyList<QaChecklistTemplateItem>> GetTemplateItemsAsync()
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.QueryAsync<QaChecklistTemplateItem>(
                @"SELECT Id, Category, FeatureName, ItemText, SortOrder, IsActive, CreatedAt
                  FROM QaChecklistTemplateItems
                  WHERE IsActive = 1
                  ORDER BY SortOrder");
            return rows.AsList();
        }

        public async Task<IReadOnlyList<QaChecklistRun>> GetRunsAsync()
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.QueryAsync<QaChecklistRun>(
                @"SELECT
                      r.Id, r.AppId, r.Version, r.CreatedAt, r.CreatedBy,
                      ISNULL(SUM(CASE WHEN ri.IsComplete = 1 THEN 1 ELSE 0 END), 0) AS CompletedCount,
                      COUNT(ri.Id) AS TotalCount
                  FROM QaChecklistRuns r
                  LEFT JOIN QaChecklistRunItems ri ON ri.RunId = r.Id
                  GROUP BY r.Id, r.AppId, r.Version, r.CreatedAt, r.CreatedBy
                  ORDER BY r.CreatedAt DESC");
            return rows.AsList();
        }

        public async Task<QaChecklistRun?> GetRunAsync(int runId)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            return await conn.QueryFirstOrDefaultAsync<QaChecklistRun>(
                @"SELECT Id, AppId, Version, CreatedAt, CreatedBy
                  FROM QaChecklistRuns
                  WHERE Id = @RunId",
                new { RunId = runId });
        }

        public async Task<IReadOnlyList<QaChecklistRunItem>> GetRunItemsAsync(int runId)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.QueryAsync<QaChecklistRunItem>(
                @"SELECT
                      ri.Id, ri.RunId, ri.TemplateItemId, ri.IsComplete, ri.CompletedBy, ri.CompletedAt, ri.Notes,
                      t.Category, t.FeatureName, t.ItemText, t.SortOrder
                  FROM QaChecklistRunItems ri
                  JOIN QaChecklistTemplateItems t ON t.Id = ri.TemplateItemId
                  WHERE ri.RunId = @RunId
                  ORDER BY t.SortOrder",
                new { RunId = runId });
            return rows.AsList();
        }

        public async Task<QaChecklistRun> CreateRunAsync(string appId, string version, string? createdBy)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();

            var id = await conn.ExecuteScalarAsync<int>(
                @"INSERT INTO QaChecklistRuns (AppId, Version, CreatedBy)
                  OUTPUT INSERTED.Id
                  VALUES (@AppId, @Version, @CreatedBy)",
                new { AppId = appId, Version = version, CreatedBy = createdBy });

            // Bulk-copy every active template item into this run in one
            // round trip, rather than one INSERT per item (~605 rows).
            await conn.ExecuteAsync(
                @"INSERT INTO QaChecklistRunItems (RunId, TemplateItemId, IsComplete)
                  SELECT @RunId, Id, 0
                  FROM QaChecklistTemplateItems
                  WHERE IsActive = 1",
                new { RunId = id });

            return new QaChecklistRun
            {
                Id = id,
                AppId = appId,
                Version = version,
                CreatedBy = createdBy,
                CreatedAt = DateTime.UtcNow,
            };
        }

        public async Task<bool> SetItemStatusAsync(int runId, int runItemId, bool isComplete, string? completedBy, string? notes)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.ExecuteAsync(
                @"UPDATE QaChecklistRunItems
                  SET IsComplete = @IsComplete,
                      CompletedBy = CASE WHEN @IsComplete = 1 THEN @CompletedBy ELSE NULL END,
                      CompletedAt = CASE WHEN @IsComplete = 1 THEN GETUTCDATE() ELSE NULL END,
                      Notes = @Notes
                  WHERE Id = @RunItemId AND RunId = @RunId",
                new { RunId = runId, RunItemId = runItemId, IsComplete = isComplete, CompletedBy = completedBy, Notes = notes });
            return rows > 0;
        }

        public async Task<bool> DeleteRunAsync(int runId)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            using var transaction = conn.BeginTransaction();

            // No FK cascade is defined between QaChecklistRunItems and
            // QaChecklistRuns -- child rows must go first or the second
            // delete violates the constraint.
            await conn.ExecuteAsync(
                @"DELETE FROM QaChecklistRunItems WHERE RunId = @RunId",
                new { RunId = runId }, transaction);

            var rows = await conn.ExecuteAsync(
                @"DELETE FROM QaChecklistRuns WHERE Id = @RunId",
                new { RunId = runId }, transaction);

            transaction.Commit();
            return rows > 0;
        }
    }
}
