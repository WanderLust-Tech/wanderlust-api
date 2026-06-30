using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface IBrowserReleaseRepository
    {
        Task<BrowserRelease?> GetLatestReleaseAsync(string appId, string platform, string arch);
        Task<IEnumerable<BrowserRelease>> GetAllReleasesAsync();
        Task<BrowserRelease> CreateReleaseAsync(BrowserRelease release);
        Task<bool> DeactivateReleaseAsync(int id);
    }
}
