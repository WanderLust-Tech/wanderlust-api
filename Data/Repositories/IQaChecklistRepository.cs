using WanderlustApi.Data.Entities;

namespace WanderlustApi.Data.Repositories
{
    public interface IQaChecklistRepository
    {
        // Active master-list items, ordered by SortOrder -- "what to check."
        Task<IReadOnlyList<QaChecklistTemplateItem>> GetTemplateItemsAsync();

        // All runs, newest first, with CompletedCount/TotalCount populated
        // for the admin list view's progress display.
        Task<IReadOnlyList<QaChecklistRun>> GetRunsAsync();

        Task<QaChecklistRun?> GetRunAsync(int runId);

        // A run's items, joined with template Category/FeatureName/ItemText,
        // ordered by SortOrder -- for the run detail/checklist-taking page.
        Task<IReadOnlyList<QaChecklistRunItem>> GetRunItemsAsync(int runId);

        // Creates the run row, then bulk-copies every active template item
        // into QaChecklistRunItems in one round trip (not N individual inserts).
        Task<QaChecklistRun> CreateRunAsync(string appId, string version, string? createdBy);

        Task<bool> SetItemStatusAsync(int runId, int runItemId, bool isComplete, string? completedBy, string? notes);

        // Hard delete -- removes the run and all of its QaChecklistRunItems
        // rows (no FK cascade is defined, so run items must be deleted
        // first). Unlike template items' soft-delete (IsActive), a run has
        // no ongoing reason to be preserved once removed -- it's just a
        // completed/abandoned checklist pass, not shared reference data.
        Task<bool> DeleteRunAsync(int runId);
    }
}
