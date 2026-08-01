namespace WanderlustApi.Data.Entities
{
    public class WhatsNewEntry
    {
        public int Id { get; set; }
        public string AppId { get; set; } = "";
        public string Version { get; set; } = ""; // the release this entry announces
        public string Title { get; set; } = "";
        public string Body { get; set; } = "";
        public bool IsActive { get; set; } = true;
        public DateTime PublishedAt { get; set; }
    }
}
