using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface IBrowserReleaseRepository
    {
        // Returns every active release for (appId, platform, arch), newest
        // first -- may be more than one row when a rollout/A-B experiment is
        // in progress. See IReleaseRolloutSelector for how one is chosen.
        Task<IReadOnlyList<BrowserRelease>> GetActiveReleasesAsync(string appId, string platform, string arch);
        Task<IEnumerable<BrowserRelease>> GetAllReleasesAsync();
        Task<BrowserRelease> CreateReleaseAsync(BrowserRelease release);
        Task<bool> DeactivateReleaseAsync(int id);
    }
}
