namespace WanderlustApi.Data.Entities
{
    public class SharedAnnotation
    {
        public int Id { get; set; }
        public string Url { get; set; } = ""; // normalized host+path, matches PageNotesService::NormalizeUrl
        public string Text { get; set; } = "";
        public int UserId { get; set; }
        public string UserName { get; set; } = ""; // denormalized display name for fast reads
        public bool IsActive { get; set; } = true;
        public DateTime CreatedAt { get; set; }
    }
}
