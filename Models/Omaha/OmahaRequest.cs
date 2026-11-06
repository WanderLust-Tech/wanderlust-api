using System.Text.Json.Serialization;

namespace WanderlustApi.Models.Omaha
{
    public class OmahaRequest
    {
        [JsonPropertyName("request")]
        public OmahaRequestBody Request { get; set; } = new();
    }

    public class OmahaRequestBody
    {
        [JsonPropertyName("protocol")]
        public string Protocol { get; set; } = "4.0";

        [JsonPropertyName("sessionId")]
        public string SessionId { get; set; } = "";

        // Random per-request id (unique to this POST, unlike sessionId which
        // spans a whole check/download/ping session). Lets the server
        // de-duplicate client/proxy retries. Optional.
        [JsonPropertyName("requestId")]
        public string? RequestId { get; set; }

        [JsonPropertyName("isMachine")]
        public bool IsMachine { get; set; }

        // The omaha_client updater tool's own release version (distinct from
        // the browser version reported per-app below) -- optional since
        // older clients won't send it.
        [JsonPropertyName("clientVersion")]
        public string? ClientVersion { get; set; }

        // Stable per-install GUID (NOT the same as sessionId, which
        // regenerates every check) used to deterministically bucket this
        // install for staged rollouts/A-B experiments -- see
        // IReleaseRolloutSelector. Optional; older clients that don't send
        // it only ever get releases with RolloutWeight=100.
        [JsonPropertyName("installId")]
        public string? InstallId { get; set; }

        [JsonPropertyName("os")]
        public OmahaOs Os { get; set; } = new();

        [JsonPropertyName("apps")]
        public List<OmahaApp> Apps { get; set; } = new();
    }

    public class OmahaOs
    {
        [JsonPropertyName("platform")]
        public string Platform { get; set; } = "";

        [JsonPropertyName("version")]
        public string Version { get; set; } = "";

        [JsonPropertyName("arch")]
        public string Arch { get; set; } = "";
    }

    public class OmahaApp
    {
        [JsonPropertyName("appId")]
        public string AppId { get; set; } = "";

        [JsonPropertyName("version")]
        public string Version { get; set; } = "";

        [JsonPropertyName("lang")]
        public string Lang { get; set; } = "en";

        // "install" (first run of the installer), "update" (background check;
        // the default and what older clients send) or "ondemand" (a
        // user-initiated check).
        [JsonPropertyName("installSource")]
        public string InstallSource { get; set; } = "update";

        // True when the updater runs system-wide (service), false for a
        // per-user install. Optional.
        [JsonPropertyName("isMachine")]
        public bool? IsMachine { get; set; }

        // Approximate install date as a server elapsedDays value (see
        // response.daystart), fuzzed to week granularity by the client.
        // -1 = this request is the install itself, -2 = unknown / not
        // applicable (also the default when omitted).
        [JsonPropertyName("installDate")]
        public long? InstallDate { get; set; }

        [JsonPropertyName("updateCheck")]
        public object? UpdateCheck { get; set; }
    }
}
