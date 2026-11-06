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
        // "<16 hex key id>:<base64 ECDSA P-256 signature>" over the manifest fields
        // (app, platform, arch, version, hash, size), made offline with the release
        // key. Served to the client, which refuses a release it cannot verify. NULL =
        // unsigned (rows from before signing existed).
        public string? Signature { get; set; }
        // JSON array of extra https download URLs (mirrors) the client falls back
        // to after InstallerUrl. NULL = none. The signed hash and size pin the file,
        // so a mirror cannot serve different bytes. See add_release_mirror_urls.sql.
        public string? MirrorUrls { get; set; }
    }
}
