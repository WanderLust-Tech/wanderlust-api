using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
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

        private readonly IBrowserReleaseRepository _releases;
        private readonly IReleaseRolloutSelector _selector;
        private readonly ILogger<OmahaController> _logger;

        public OmahaController(
            IBrowserReleaseRepository releases,
            IReleaseRolloutSelector selector,
            ILogger<OmahaController> logger)
        {
            _releases = releases;
            _selector = selector;
            _logger = logger;
        }

        [HttpPost("update")]
        [Consumes("application/json")]
        [Produces("application/json")]
        public async Task<IActionResult> Update([FromBody] OmahaRequest request)
        {
            if (request?.Request?.Apps == null || request.Request.Apps.Count == 0)
                return BadJsonResponse("Invalid request: no apps specified");

            _logger.LogInformation(
                "Omaha update check: clientVersion={ClientVersion} installId={InstallId} sessionId={SessionId} appCount={AppCount}",
                request.Request.ClientVersion ?? "(unknown)",
                request.Request.InstallId ?? "(none)",
                request.Request.SessionId,
                request.Request.Apps.Count);

            var os = request.Request.Os;
            var responseApps = new List<OmahaResponseApp>();

            foreach (var app in request.Request.Apps)
            {
                if (string.IsNullOrWhiteSpace(app.AppId))
                {
                    responseApps.Add(ErrorApp("appId is required"));
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
                        responseApps.Add(NoUpdateApp());
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
                            responseApps.Add(NoUpdateApp());
                            continue;
                        }

                        if (selectedVer <= clientVer)
                        {
                            responseApps.Add(NoUpdateApp());
                            continue;
                        }
                    }

                    responseApps.Add(new OmahaResponseApp
                    {
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
                                        Size     = selected.SizeBytes,
                                    }
                                }
                            }
                        }
                    });
                }
                catch
                {
                    responseApps.Add(ErrorApp("Internal server error"));
                }
            }

            var json = JsonSerializer.Serialize(new OmahaResponse
            {
                Response = new OmahaResponseBody { Apps = responseApps }
            });

            return Content(json, "application/json");
        }

        private static OmahaResponseApp NoUpdateApp() => new()
        {
            UpdateCheck = new OmahaUpdateCheck { Status = "noupdate" }
        };

        private static OmahaResponseApp ErrorApp(string message) => new()
        {
            UpdateCheck = new OmahaUpdateCheck { Status = "error", ErrorMessage = message }
        };

        private IActionResult BadJsonResponse(string message)
        {
            var json = JsonSerializer.Serialize(new OmahaResponse
            {
                Response = new OmahaResponseBody
                {
                    Apps = new List<OmahaResponseApp> { ErrorApp(message) }
                }
            });
            return Content(json, "application/json");
        }
    }
}
