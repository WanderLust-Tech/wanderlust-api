using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Data.Mock
{
    public class MockWhatsNewRepository : IWhatsNewRepository
    {
        public Task<IEnumerable<WhatsNewEntry>> GetActiveEntriesAsync(string appId)
            => Task.FromResult<IEnumerable<WhatsNewEntry>>(Array.Empty<WhatsNewEntry>());

        public Task<WhatsNewEntry> CreateEntryAsync(WhatsNewEntry entry)
        {
            entry.Id = 1;
            entry.PublishedAt = DateTime.UtcNow;
            return Task.FromResult(entry);
        }

        public Task<bool> DeactivateEntryAsync(int id)
            => Task.FromResult(false);
    }
}
