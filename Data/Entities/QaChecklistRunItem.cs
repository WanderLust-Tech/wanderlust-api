namespace WanderlustApi.Data.Entities
{
    public class QaChecklistRunItem
    {
        public int Id { get; set; }
        public int RunId { get; set; }
        public int TemplateItemId { get; set; }
        public bool IsComplete { get; set; }
        public string? CompletedBy { get; set; }
        public DateTime? CompletedAt { get; set; }
        public string? Notes { get; set; }
        // Populated by GetRunItemsAsync's JOIN against QaChecklistTemplateItems
        // -- not persisted columns on this table.
        public string Category { get; set; } = "";
        public string FeatureName { get; set; } = "";
        public string ItemText { get; set; } = "";
        public int SortOrder { get; set; }
    }
}
