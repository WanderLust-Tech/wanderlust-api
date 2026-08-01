using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Data.Mock
{
    public class MockSharedAnnotationRepository : ISharedAnnotationRepository
    {
        public Task<IEnumerable<SharedAnnotation>> GetActiveForUrlAsync(string url)
            => Task.FromResult<IEnumerable<SharedAnnotation>>(Array.Empty<SharedAnnotation>());

        public Task<SharedAnnotation> CreateAsync(SharedAnnotation annotation)
        {
            annotation.Id = 1;
            annotation.CreatedAt = DateTime.UtcNow;
            return Task.FromResult(annotation);
        }

        public Task<SharedAnnotation?> GetByIdAsync(int id)
            => Task.FromResult<SharedAnnotation?>(null);

        public Task<bool> DeactivateAsync(int id)
            => Task.FromResult(false);
    }
}
