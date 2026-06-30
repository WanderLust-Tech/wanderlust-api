using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using WanderlustApi.Data.Repositories;
using WanderlustApi.Filters;
using WanderlustApi.Models.Omaha;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("v4")]
    [AllowAnonymous]
    [SkipResponseWrapper]
    public class OmahaController : ControllerBase
    {
        private readonly IBrowserReleaseRepository _releases;

        public OmahaController(IBrowserReleaseRepository releases)
        {
            _releases = releases;
        }

        [HttpPost("update")]
        [Consumes("application/json")]
        [Produces("application/json")]
        public async Task<IActionResult> Update([FromBody] OmahaRequest request)
        {
            if (request?.Request?.Apps == null || request.Request.Apps.Count == 0)
                return BadJsonResponse("Invalid request: no apps specified");

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
                    var latest = await _releases.GetLatestReleaseAsync(
                        app.AppId,
                        os.Platform,
                        os.Arch);

                    if (latest == null)
                    {
                        responseApps.Add(NoUpdateApp());
                        continue;
                    }

                    // Parse both versions; fall back to no-update if parsing fails
                    if (!System.Version.TryParse(latest.Version, out var latestVer) ||
                        !System.Version.TryParse(app.Version, out var clientVer))
                    {
                        responseApps.Add(NoUpdateApp());
                        continue;
                    }

                    if (latestVer <= clientVer)
                    {
                        responseApps.Add(NoUpdateApp());
                        continue;
                    }

                    responseApps.Add(new OmahaResponseApp
                    {
                        UpdateCheck = new OmahaUpdateCheck
                        {
                            Status = "ok",
                            Manifest = new OmahaManifest
                            {
                                Version = latest.Version,
                                Packages = new List<OmahaPackage>
                                {
                                    new OmahaPackage
                                    {
                                        Name     = latest.InstallerName,
                                        HashSha256 = latest.HashSha256,
                                        Url      = latest.InstallerUrl,
                                        Size     = latest.SizeBytes,
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
