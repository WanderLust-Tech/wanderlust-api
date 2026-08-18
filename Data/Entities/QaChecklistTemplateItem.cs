namespace WanderlustApi.Data.Entities
{
    public class QaChecklistTemplateItem
    {
        public int Id { get; set; }
        public string Category { get; set; } = "";    // "## " header, e.g. "Browser UI"
        public string FeatureName { get; set; } = ""; // "### " header, e.g. "Vertical Tabs"
        public string ItemText { get; set; } = "";
        public int SortOrder { get; set; }
        public bool IsActive { get; set; } = true;
        public DateTime CreatedAt { get; set; }
    }
}
