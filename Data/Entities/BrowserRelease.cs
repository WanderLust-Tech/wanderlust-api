namespace WanderlustApi.Data.Entities
{
    public class BrowserRelease
    {
        public int Id { get; set; }
        public string AppId { get; set; } = "";
        public string Version { get; set; } = "";
        public string Platform { get; set; } = ""; // win | linux | mac
        public string Arch { get; set; } = "";     // x64 | x86 | arm64
        public string InstallerName { get; set; } = "";
        public string InstallerUrl { get; set; } = "";
        public string HashSha256 { get; set; } = "";
        public long SizeBytes { get; set; }
        public bool IsActive { get; set; } = true;
        public DateTime CreatedAt { get; set; }
    }
}
