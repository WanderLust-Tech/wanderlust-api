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
        // Server clock, so the client can store a date for installDate.
        [JsonPropertyName("daystart")]
        public OmahaDayStart DayStart { get; set; } = OmahaDayStart.Now();

        [JsonPropertyName("apps")]
        public List<OmahaResponseApp> Apps { get; set; } = new();
    }

    public class OmahaDayStart
    {
        // Counted from 2007-01-01 UTC, the epoch Omaha uses.
        private static readonly DateTime Epoch = new(2007, 1, 1, 0, 0, 0, DateTimeKind.Utc);

        // Whole days elapsed since 2007-01-01 (UTC) when the request was received.
        [JsonPropertyName("elapsedDays")]
        public int ElapsedDays { get; set; }

        public static OmahaDayStart Now() =>
            new() { ElapsedDays = (int)(DateTime.UtcNow.Date - Epoch).TotalDays };
    }

    public class OmahaResponseApp
    {
        // Echo of the request app's appId, on every response app.
        [JsonPropertyName("appId")]
        public string AppId { get; set; } = "";

        // Optional app-level state: "ok" | "restricted" | "error-unknownApplication".
        // Omitted when null (= "ok"). Not emitted by the server yet; documented
        // so the client can already act on it.
        [JsonPropertyName("status")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? AppStatus { get; set; }

        [JsonPropertyName("updateCheck")]
        public OmahaUpdateCheck UpdateCheck { get; set; } = new();
    }

    public class OmahaUpdateCheck
    {
        // "ok" | "noupdate" | "error", plus (understood by the client, not yet
        // emitted by this server): "error-osnotsupported" | "error-hwnotsupported" |
        // "error-unsupportedprotocol".
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

        // Ordered download URLs: the first is always identical to "url"; the rest
        // are mirrors the client falls back to if a URL fails. The signed hash and
        // size pin the file, so a mirror cannot serve different bytes.
        [JsonPropertyName("urls")]
        public List<string> Urls { get; set; } = new();

        [JsonPropertyName("size")]
        public long Size { get; set; }

        // "<key id>:<base64>" -- see ReleaseSignature. Omitted for an unsigned
        // release; a client that requires signatures then refuses it.
        [JsonPropertyName("signature")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Signature { get; set; }
    }
}
