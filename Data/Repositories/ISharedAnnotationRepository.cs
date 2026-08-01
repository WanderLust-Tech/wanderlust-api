using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface ISharedAnnotationRepository
    {
        Task<IEnumerable<SharedAnnotation>> GetActiveForUrlAsync(string url);
        Task<SharedAnnotation> CreateAsync(SharedAnnotation annotation);
        Task<SharedAnnotation?> GetByIdAsync(int id);
        Task<bool> DeactivateAsync(int id);
    }
}
