using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Data.Mock
{
    public class MockFeedbackRepository : IFeedbackRepository
    {
        public Task<FeedbackEntry> CreateAsync(FeedbackEntry entry)
        {
            entry.Id = 1;
            entry.CreatedAt = DateTime.UtcNow;
            return Task.FromResult(entry);
        }

        public Task<IEnumerable<FeedbackEntry>> GetAllAsync()
            => Task.FromResult<IEnumerable<FeedbackEntry>>(Array.Empty<FeedbackEntry>());

        public Task<bool> MarkResolvedAsync(int id)
            => Task.FromResult(false);
    }
}
