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
        // 0-100. Default 100 keeps today's "always wins" behavior. Multiple
        // active rows for the same (AppId, Platform, Arch) can carry a lower
        // weight to run a staged rollout or an A/B experiment -- see
        // IReleaseRolloutSelector.
        public int RolloutWeight { get; set; } = 100;
        // Free-text label for admin/reporting use only -- not read by the
        // rollout selection logic itself.
        public string? ExperimentName { get; set; }
    }
}
