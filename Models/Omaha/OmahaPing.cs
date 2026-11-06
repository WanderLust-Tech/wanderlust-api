using System.Text.Json.Serialization;

namespace WanderlustApi.Models.Omaha
{
    // POST /v4/ping -- fire-and-forget reports about what an update session did.
    // Deliberately carries NO stable install identifier (no installId): only the
    // per-session sessionId and per-request requestId, so pings cannot be joined
    // into a long-lived per-install history. Unknown fields are ignored.
    public class OmahaPingRequest
    {
        [JsonPropertyName("request")]
        public OmahaPingRequestBody? Request { get; set; }
    }

    public class OmahaPingRequestBody
    {
        [JsonPropertyName("protocol")]
        public string? Protocol { get; set; }

        [JsonPropertyName("sessionId")]
        public string? SessionId { get; set; }

        [JsonPropertyName("requestId")]
        public string? RequestId { get; set; }

        [JsonPropertyName("clientVersion")]
        public string? ClientVersion { get; set; }

        [JsonPropertyName("os")]
        public OmahaOs? Os { get; set; }

        [JsonPropertyName("apps")]
        public List<OmahaPingApp>? Apps { get; set; }
    }

    public class OmahaPingApp
    {
        [JsonPropertyName("appId")]
        public string? AppId { get; set; }

        [JsonPropertyName("version")]
        public string? Version { get; set; }

        [JsonPropertyName("events")]
        public List<OmahaPingEvent>? Events { get; set; }
    }

    public class OmahaPingEvent
    {
        // 2 install session, 3 update session, 14 download.
        [JsonPropertyName("eventType")]
        public int EventType { get; set; }

        // 0 error, 1 success, 4 cancelled.
        [JsonPropertyName("eventResult")]
        public int EventResult { get; set; }

        // 0 none, 1 download, 3 client install, 4 updater itself,
        // 5 update check, 7 installer, 8 patch.
        [JsonPropertyName("errorCat")]
        public int ErrorCat { get; set; }

        [JsonPropertyName("errorCode")]
        public int ErrorCode { get; set; }

        [JsonPropertyName("extraCode1")]
        public int ExtraCode1 { get; set; }

        [JsonPropertyName("nextVersion")]
        public string? NextVersion { get; set; }

        [JsonPropertyName("previousVersion")]
        public string? PreviousVersion { get; set; }

        [JsonPropertyName("downloadTimeMs")]
        public long? DownloadTimeMs { get; set; }

        [JsonPropertyName("downloaded")]
        public long? Downloaded { get; set; }

        [JsonPropertyName("total")]
        public long? Total { get; set; }

        [JsonPropertyName("url")]
        public string? Url { get; set; }
    }

    public class OmahaPingResponse
    {
        [JsonPropertyName("response")]
        public OmahaPingResponseBody Response { get; set; } = new();
    }

    public class OmahaPingResponseBody
    {
        [JsonPropertyName("daystart")]
        public OmahaDayStart DayStart { get; set; } = OmahaDayStart.Now();

        [JsonPropertyName("apps")]
        public List<OmahaPingResponseApp> Apps { get; set; } = new();

        // Set only on a rejected request.
        [JsonPropertyName("error")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Error { get; set; }
    }

    public class OmahaPingResponseApp
    {
        [JsonPropertyName("appId")]
        public string AppId { get; set; } = "";

        [JsonPropertyName("events")]
        public List<OmahaPingEventAck> Events { get; set; } = new();
    }

    public class OmahaPingEventAck
    {
        // "ok" -- the server acknowledges receipt.
        [JsonPropertyName("status")]
        public string Status { get; set; } = "ok";
    }
}
