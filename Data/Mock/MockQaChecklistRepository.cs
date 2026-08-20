using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Data.Mock
{
    public class MockQaChecklistRepository : IQaChecklistRepository
    {
        public Task<IReadOnlyList<QaChecklistTemplateItem>> GetTemplateItemsAsync()
            => Task.FromResult<IReadOnlyList<QaChecklistTemplateItem>>(Array.Empty<QaChecklistTemplateItem>());

        public Task<IReadOnlyList<QaChecklistRun>> GetRunsAsync()
            => Task.FromResult<IReadOnlyList<QaChecklistRun>>(Array.Empty<QaChecklistRun>());

        public Task<QaChecklistRun?> GetRunAsync(int runId)
            => Task.FromResult<QaChecklistRun?>(null);

        public Task<IReadOnlyList<QaChecklistRunItem>> GetRunItemsAsync(int runId)
            => Task.FromResult<IReadOnlyList<QaChecklistRunItem>>(Array.Empty<QaChecklistRunItem>());

        public Task<QaChecklistRun> CreateRunAsync(string appId, string version, string? createdBy)
        {
            return Task.FromResult(new QaChecklistRun
            {
                Id = 1,
                AppId = appId,
                Version = version,
                CreatedBy = createdBy,
                CreatedAt = DateTime.UtcNow,
            });
        }

        public Task<bool> SetItemStatusAsync(int runId, int runItemId, bool isComplete, string? completedBy, string? notes)
            => Task.FromResult(false);

        public Task<bool> DeleteRunAsync(int runId)
            => Task.FromResult(false);
    }
}
