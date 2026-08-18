using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface IBrowserReleaseRepository
    {
        // Returns every active release for (appId, platform, arch), newest
        // first -- may be more than one row when a rollout/A-B experiment is
        // in progress. See IReleaseRolloutSelector for how one is chosen.
        Task<IReadOnlyList<BrowserRelease>> GetActiveReleasesAsync(string appId, string platform, string arch);
        // Returns every release regardless of IsActive -- for the admin
        // management UI, not the update-check path (see GetActiveReleasesAsync).
        Task<IEnumerable<BrowserRelease>> GetAllReleasesAsync();
        Task<BrowserRelease> CreateReleaseAsync(BrowserRelease release);
        Task<bool> DeactivateReleaseAsync(int id);
        Task<bool> ActivateReleaseAsync(int id);
    }
}
