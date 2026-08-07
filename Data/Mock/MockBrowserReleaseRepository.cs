using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Data.Mock
{
    public class MockBrowserReleaseRepository : IBrowserReleaseRepository
    {
        public Task<IReadOnlyList<BrowserRelease>> GetActiveReleasesAsync(string appId, string platform, string arch)
            => Task.FromResult<IReadOnlyList<BrowserRelease>>(Array.Empty<BrowserRelease>());

        public Task<IEnumerable<BrowserRelease>> GetAllReleasesAsync()
            => Task.FromResult<IEnumerable<BrowserRelease>>(Array.Empty<BrowserRelease>());

        public Task<BrowserRelease> CreateReleaseAsync(BrowserRelease release)
        {
            release.Id = 1;
            release.CreatedAt = DateTime.UtcNow;
            return Task.FromResult(release);
        }

        public Task<bool> DeactivateReleaseAsync(int id)
            => Task.FromResult(false);
    }
}
