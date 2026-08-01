using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface IWhatsNewRepository
    {
        Task<IEnumerable<WhatsNewEntry>> GetActiveEntriesAsync(string appId);
        Task<WhatsNewEntry> CreateEntryAsync(WhatsNewEntry entry);
        Task<bool> DeactivateEntryAsync(int id);
    }
}
