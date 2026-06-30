using System.Text.Json.Serialization;

namespace WanderlustApi.Models.Omaha
{
    public class OmahaResponse
    {
        [JsonPropertyName("response")]
        public OmahaResponseBody Response { get; set; } = new();
    }

    public class OmahaResponseBody
    {
        [JsonPropertyName("apps")]
        public List<OmahaResponseApp> Apps { get; set; } = new();
    }

    public class OmahaResponseApp
    {
        [JsonPropertyName("updateCheck")]
        public OmahaUpdateCheck UpdateCheck { get; set; } = new();
    }

    public class OmahaUpdateCheck
    {
        // "ok" | "noupdate" | "error"
        [JsonPropertyName("status")]
        public string Status { get; set; } = "noupdate";

        [JsonPropertyName("errorMessage")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? ErrorMessage { get; set; }

        [JsonPropertyName("manifest")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public OmahaManifest? Manifest { get; set; }
    }

    public class OmahaManifest
    {
        [JsonPropertyName("version")]
        public string Version { get; set; } = "";

        [JsonPropertyName("packages")]
        public List<OmahaPackage> Packages { get; set; } = new();
    }

    public class OmahaPackage
    {
        [JsonPropertyName("name")]
        public string Name { get; set; } = "";

        [JsonPropertyName("hash_sha256")]
        public string HashSha256 { get; set; } = "";

        [JsonPropertyName("url")]
        public string Url { get; set; } = "";

        [JsonPropertyName("size")]
        public long Size { get; set; }
    }
}
