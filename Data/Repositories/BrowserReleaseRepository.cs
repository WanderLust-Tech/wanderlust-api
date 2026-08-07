using Dapper;
using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public class BrowserReleaseRepository : IBrowserReleaseRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public BrowserReleaseRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IReadOnlyList<BrowserRelease>> GetActiveReleasesAsync(string appId, string platform, string arch)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.QueryAsync<BrowserRelease>(
                @"SELECT Id, AppId, Version, Platform, Arch, InstallerName, InstallerUrl,
                         HashSha256, SizeBytes, IsActive, CreatedAt, RolloutWeight, ExperimentName
                  FROM BrowserReleases
                  WHERE AppId = @AppId AND Platform = @Platform AND Arch = @Arch AND IsActive = 1
                  ORDER BY CreatedAt DESC",
                new { AppId = appId, Platform = platform, Arch = arch });
            return rows.AsList();
        }

        public async Task<IEnumerable<BrowserRelease>> GetAllReleasesAsync()
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            return await conn.QueryAsync<BrowserRelease>(
                @"SELECT Id, AppId, Version, Platform, Arch, InstallerName, InstallerUrl,
                         HashSha256, SizeBytes, IsActive, CreatedAt, RolloutWeight, ExperimentName
                  FROM BrowserReleases
                  WHERE IsActive = 1
                  ORDER BY CreatedAt DESC");
        }

        public async Task<BrowserRelease> CreateReleaseAsync(BrowserRelease release)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var id = await conn.ExecuteScalarAsync<int>(
                @"INSERT INTO BrowserReleases
                    (AppId, Version, Platform, Arch, InstallerName, InstallerUrl, HashSha256, SizeBytes,
                     RolloutWeight, ExperimentName, IsActive, CreatedAt)
                  OUTPUT INSERTED.Id
                  VALUES
                    (@AppId, @Version, @Platform, @Arch, @InstallerName, @InstallerUrl, @HashSha256, @SizeBytes,
                     @RolloutWeight, @ExperimentName, 1, GETUTCDATE())",
                release);
            release.Id = id;
            release.CreatedAt = DateTime.UtcNow;
            return release;
        }

        public async Task<bool> DeactivateReleaseAsync(int id)
        {
            using var conn = await _connectionFactory.CreateConnectionAsync();
            var rows = await conn.ExecuteAsync(
                "UPDATE BrowserReleases SET IsActive = 0 WHERE Id = @Id",
                new { Id = id });
            return rows > 0;
        }
    }
}
