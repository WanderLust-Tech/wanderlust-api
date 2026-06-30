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

        [JsonPropertyName("isMachine")]
        public bool IsMachine { get; set; }

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

        [JsonPropertyName("installSource")]
        public string InstallSource { get; set; } = "update";

        [JsonPropertyName("updateCheck")]
        public object? UpdateCheck { get; set; }
    }
}
