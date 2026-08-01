using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface IFeedbackRepository
    {
        Task<FeedbackEntry> CreateAsync(FeedbackEntry entry);
        Task<IEnumerable<FeedbackEntry>> GetAllAsync();
        Task<bool> MarkResolvedAsync(int id);
    }
}
