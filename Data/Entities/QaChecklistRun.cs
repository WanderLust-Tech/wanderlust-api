namespace WanderlustApi.Data.Entities
{
    public class QaChecklistRun
    {
        public int Id { get; set; }
        public string AppId { get; set; } = "";
        public string Version { get; set; } = "";
        public DateTime CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        // Populated by GetRunsAsync's joined query for the list view's
        // progress display -- not persisted columns on this table.
        public int CompletedCount { get; set; }
        public int TotalCount { get; set; }
    }
}
