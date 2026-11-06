using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using System.Text.Json;
using WanderlustApi.Data.Repositories;
using WanderlustApi.Filters;
using WanderlustApi.Models.Omaha;
using WanderlustApi.Services;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("v4")]
    [AllowAnonymous]
    [SkipResponseWrapper]
    public class OmahaController : ControllerBase
    {
        // Sent by a brand-new install with no prior version -- there's
        // nothing to compare against, so it always gets whatever the
        // rollout selector picked, skipping the version-comparison guard.
        private const string FreshInstallVersionSentinel = "0.0.0.0";

        // Upper bound for the optional X-Retry-After header (24 hours).
        private const int MaxRetryAfterSeconds = 86400;

        // Ping limits -- the endpoint is anonymous, so bound what one request can make us log.
        private const int MaxPingApps = 5;
        private const int MaxPingEventsPerApp = 20;
        private const int MaxPingStringLength = 256;

        private readonly IBrowserReleaseRepository _releases;
        private readonly IReleaseRolloutSelector _selector;
        private readonly IConfiguration _configuration;
        private readonly ILogger<OmahaController> _logger;

        public OmahaController(
            IBrowserReleaseRepository releases,
            IReleaseRolloutSelector selector,
            IConfiguration configuration,
            ILogger<OmahaController> logger)
        {
            _releases = releases;
            _selector = selector;
            _configuration = configuration;
            _logger = logger;
        }

        [HttpPost("update")]
        [Consumes("application/json")]
        [Produces("application/json")]
        public async Task<IActionResult> Update([FromBody] OmahaRequest request)
        {
            ApplyRetryAfterHeader();

            if (request?.Request?.Apps == null || request.Request.Apps.Count == 0)
                return BadJsonResponse("Invalid request: no apps specified");

            _logger.LogInformation(
                "Omaha update check: clientVersion={ClientVersion} installId={InstallId} sessionId={SessionId} requestId={RequestId} appCount={AppCount} installSource={InstallSource} installDate={InstallDate}",
                request.Request.ClientVersion == null ? "(unknown)" : SanitizeForLog(request.Request.ClientVersion),
                request.Request.InstallId == null ? "(none)" : SanitizeForLog(request.Request.InstallId),
                SanitizeForLog(request.Request.SessionId),
                request.Request.RequestId == null ? "(none)" : SanitizeForLog(request.Request.RequestId),
                request.Request.Apps.Count,
                SanitizeForLog(request.Request.Apps[0].InstallSource),
                request.Request.Apps[0].InstallDate?.ToString() ?? "(none)");

            var os = request.Request.Os;
            var responseApps = new List<OmahaResponseApp>();

            foreach (var app in request.Request.Apps)
            {
                if (string.IsNullOrWhiteSpace(app.AppId))
                {
                    responseApps.Add(ErrorApp(app.AppId, "appId is required"));
                    continue;
                }

                try
                {
                    var candidates = await _releases.GetActiveReleasesAsync(
                        app.AppId,
                        os.Platform,
                        os.Arch);

                    var selected = _selector.SelectRelease(candidates, app.AppId, request.Request.InstallId);
                    if (selected == null)
                    {
                        responseApps.Add(NoUpdateApp(app.AppId));
                        continue;
                    }

                    bool isFreshInstall = string.IsNullOrWhiteSpace(app.Version) ||
                                          app.Version == FreshInstallVersionSentinel;

                    if (!isFreshInstall)
                    {
                        // Parse both versions; fall back to no-update if parsing fails
                        if (!System.Version.TryParse(selected.Version, out var selectedVer) ||
                            !System.Version.TryParse(app.Version, out var clientVer))
                        {
                            responseApps.Add(NoUpdateApp(app.AppId));
                            continue;
                        }

                        if (selectedVer <= clientVer)
                        {
                            responseApps.Add(NoUpdateApp(app.AppId));
                            continue;
                        }
                    }

                    responseApps.Add(new OmahaResponseApp
                    {
                        AppId = app.AppId,
                        UpdateCheck = new OmahaUpdateCheck
                        {
                            Status = "ok",
                            Manifest = new OmahaManifest
                            {
                                Version = selected.Version,
                                Packages = new List<OmahaPackage>
                                {
                                    new OmahaPackage
                                    {
                                        Name     = selected.InstallerName,
                                        HashSha256 = selected.HashSha256,
                                        Url      = selected.InstallerUrl,
                                        Urls     = BuildUrls(selected.InstallerUrl, selected.MirrorUrls),
                                        Size     = selected.SizeBytes,
                                        Signature = selected.Signature,
                                    }
                                }
                            }
                        }
                    });
                }
                catch
                {
                    responseApps.Add(ErrorApp(app.AppId, "Internal server error"));
                }
            }

            var json = JsonSerializer.Serialize(new OmahaResponse
            {
                Response = new OmahaResponseBody { Apps = responseApps }
            });

            return Content(json, "application/json");
        }

        // Fire-and-forget report of what an update/install session did (see
        // UPDATE_PROTOCOL.md, "Ping-backs"). Logged only -- no persistence yet. By
        // design it carries no installId, so it is never logged or joined to one.
        [HttpPost("ping")]
        [Consumes("application/json")]
        [Produces("application/json")]
        public IActionResult Ping([FromBody] OmahaPingRequest? request)
        {
            var body = request?.Request;
            if (body == null)
                return BadRequest(new OmahaPingResponse
                {
                    Response = new OmahaPingResponseBody { Error = "Invalid request: missing 'request'" }
                });

            var sessionId     = SanitizeForLog(body.SessionId);
            var requestId     = SanitizeForLog(body.RequestId);
            var clientVersion = SanitizeForLog(body.ClientVersion);

            var responseApps = new List<OmahaPingResponseApp>();

            foreach (var app in (body.Apps ?? new List<OmahaPingApp>()).Take(MaxPingApps))
            {
                var appId = SanitizeForLog(app.AppId);
                var appVersion = SanitizeForLog(app.Version);
                var acks = new List<OmahaPingEventAck>();

                foreach (var ev in (app.Events ?? new List<OmahaPingEvent>()).Take(MaxPingEventsPerApp))
                {
                    _logger.LogInformation(
                        "Omaha ping: appId={AppId} version={Version} eventType={EventType} eventResult={EventResult} " +
                        "errorCat={ErrorCat} errorCode={ErrorCode} extraCode1={ExtraCode1} " +
                        "nextVersion={NextVersion} previousVersion={PreviousVersion} " +
                        "downloadTimeMs={DownloadTimeMs} downloaded={Downloaded} total={Total} url={Url} " +
                        "clientVersion={ClientVersion} sessionId={SessionId} requestId={RequestId}",
                        appId, appVersion, ev.EventType, ev.EventResult,
                        ev.ErrorCat, ev.ErrorCode, ev.ExtraCode1,
                        SanitizeForLog(ev.NextVersion), SanitizeForLog(ev.PreviousVersion),
                        ev.DownloadTimeMs?.ToString() ?? "(none)",
                        ev.Downloaded?.ToString() ?? "(none)",
                        ev.Total?.ToString() ?? "(none)",
                        SanitizeForLog(ev.Url),
                        clientVersion, sessionId, requestId);
                    acks.Add(new OmahaPingEventAck());
                }

                responseApps.Add(new OmahaPingResponseApp { AppId = appId, Events = acks });
            }

            var json = JsonSerializer.Serialize(new OmahaPingResponse
            {
                Response = new OmahaPingResponseBody { Apps = responseApps }
            });
            return Content(json, "application/json");
        }

        // Optional load-shedding switch: Omaha:RetryAfterSeconds > 0 makes every
        // update response carry X-Retry-After, which clients honour by not contacting
        // the server for that many seconds. 0 / absent = not sent.
        private void ApplyRetryAfterHeader()
        {
            var seconds = _configuration.GetValue("Omaha:RetryAfterSeconds", 0);
            if (seconds <= 0) return;
            Response.Headers["X-Retry-After"] =
                Math.Min(seconds, MaxRetryAfterSeconds).ToString(System.Globalization.CultureInfo.InvariantCulture);
        }

        // [InstallerUrl, ...mirrors]; the first element always equals the legacy "url".
        private List<string> BuildUrls(string installerUrl, string? mirrorUrlsJson)
        {
            var urls = new List<string> { installerUrl };
            if (string.IsNullOrWhiteSpace(mirrorUrlsJson)) return urls;

            try
            {
                var mirrors = JsonSerializer.Deserialize<string[]>(mirrorUrlsJson);
                if (mirrors != null)
                    urls.AddRange(mirrors.Where(m => !string.IsNullOrWhiteSpace(m) && !urls.Contains(m)));
            }
            catch (JsonException ex)
            {
                // A bad MirrorUrls value must never break updates: serve the primary URL alone.
                _logger.LogWarning(ex, "Ignoring unparseable MirrorUrls on a release");
            }
            return urls;
        }

        // Anonymous, client-supplied text goes into log lines: drop control characters
        // (stops forged log lines via CR/LF) and cap the length.
        private static string SanitizeForLog(string? value)
        {
            if (string.IsNullOrEmpty(value)) return "";
            var sb = new StringBuilder(Math.Min(value.Length, MaxPingStringLength));
            foreach (var c in value)
            {
                if (sb.Length >= MaxPingStringLength) break;
                if (!char.IsControl(c)) sb.Append(c);
            }
            return sb.ToString();
        }

        private static OmahaResponseApp NoUpdateApp(string? appId) => new()
        {
            AppId = appId ?? "",
            UpdateCheck = new OmahaUpdateCheck { Status = "noupdate" }
        };

        private static OmahaResponseApp ErrorApp(string? appId, string message) => new()
        {
            AppId = appId ?? "",
            UpdateCheck = new OmahaUpdateCheck { Status = "error", ErrorMessage = message }
        };

        private IActionResult BadJsonResponse(string message)
        {
            var json = JsonSerializer.Serialize(new OmahaResponse
            {
                Response = new OmahaResponseBody
                {
                    Apps = new List<OmahaResponseApp> { ErrorApp(null, message) }
                }
            });
            return Content(json, "application/json");
        }
    }
}
