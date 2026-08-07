using System.Security.Cryptography;
using System.Text;
using WanderlustApi.Data.Entities;

namespace WanderlustApi.Services
{
    public interface IReleaseRolloutSelector
    {
        // |candidates| must already be ordered newest-first (as returned by
        // IBrowserReleaseRepository.GetActiveReleasesAsync). Returns null if
        // no candidate covers the client's bucket (or the list is empty).
        BrowserRelease? SelectRelease(IReadOnlyList<BrowserRelease> candidates, string appId, string? installId);
    }

    // Deterministic weighted waterfall: candidates are tried newest-first,
    // each covering a slice of 100 buckets sized by its RolloutWeight. A
    // client's bucket is derived from a stable per-install ID so it always
    // lands in the same slice across repeated checks -- this is what makes
    // staged rollouts/A-B experiments behave consistently for a given
    // install instead of flapping between variants every request.
    public class ReleaseRolloutSelector : IReleaseRolloutSelector
    {
        public BrowserRelease? SelectRelease(IReadOnlyList<BrowserRelease> candidates, string appId, string? installId)
        {
            if (candidates.Count == 0)
                return null;

            // No stable ID to bucket on (older clients that don't send one
            // yet) -- never opt an unbucketable client into a partial-weight
            // experiment, only ever offer a release that covers everyone.
            var eligible = string.IsNullOrWhiteSpace(installId)
                ? candidates.Where(c => c.RolloutWeight >= 100).ToList()
                : candidates;

            if (eligible.Count == 0)
                return null;

            int bucket = StableBucket(installId ?? "", appId);
            int cumulative = 0;
            foreach (var candidate in eligible)
            {
                cumulative = Math.Min(100, cumulative + candidate.RolloutWeight);
                if (bucket < cumulative)
                    return candidate;
            }

            return null;
        }

        // 0-99, stable across process restarts. Deliberately NOT
        // string.GetHashCode() -- .NET randomizes that per-process by
        // default, which would make bucketing non-deterministic.
        private static int StableBucket(string installId, string appId)
        {
            var bytes = Encoding.UTF8.GetBytes($"{installId}:{appId}");
            var hash = SHA256.HashData(bytes);
            uint value = BitConverter.ToUInt32(hash, 0);
            return (int)(value % 100);
        }
    }
}
