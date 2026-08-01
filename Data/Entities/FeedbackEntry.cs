namespace WanderlustApi.Data.Entities
{
    public class FeedbackEntry
    {
        public int Id { get; set; }
        public string Description { get; set; } = "";
        public string Url { get; set; } = ""; // page the report was filed from
        public string SystemInfo { get; set; } = ""; // browser version / OS, client-supplied
        public string? ContactEmail { get; set; } // optional, user-typed -- not tied to any sign-in
        public bool IsResolved { get; set; } = false;
        public DateTime CreatedAt { get; set; }
    }
}
