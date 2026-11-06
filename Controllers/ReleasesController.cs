using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;
using WanderlustApi.Services;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    // Admin only. What this controller writes is what every install's updater is
    // told to download and run, so "any logged-in user" is not enough: sign-up
    // is open and new accounts are Members. (Same convention as
    // FeedbackController's admin endpoints.)
    [Authorize(Roles = "Admin")]
    public class ReleasesController : ControllerBase
    {
        private readonly IBrowserReleaseRepository _releases;
        private readonly ILogger<ReleasesController> _logger;
        private readonly IReadOnlyCollection<string> _allowedInstallerHosts;
        private readonly ReleaseRequestValidator.SigningPolicy _signing;

        public ReleasesController(
            IBrowserReleaseRepository releases,
            IConfiguration configuration,
            ILogger<ReleasesController> logger)
        {
            _releases = releases;
            _logger = logger;
            _allowedInstallerHosts =
                configuration.GetSection("Releases:AllowedInstallerHosts").Get<string[]>() is { Length: > 0 } hosts
                    ? hosts
                    : ReleaseRequestValidator.DefaultAllowedInstallerHosts;

            // Releases:SigningPublicKeys -- the same PUBLIC key(s) built into the client. Optional
            // here (the client is the enforcer); when set, a bad signature is rejected at publish.
            // Releases:RequireSignature defaults to true: an unsigned release is useless.
            var keys = configuration.GetSection("Releases:SigningPublicKeys").Get<string[]>() ?? Array.Empty<string>();
            _signing = new ReleaseRequestValidator.SigningPolicy(
                configuration.GetValue("Releases:RequireSignature", true), keys);
            if (keys.Length == 0)
                _logger.LogWarning("Releases:SigningPublicKeys is not configured: release signatures are checked "
                    + "for format only; the update client is what enforces them.");
        }

        // Who did it, for the audit trail in the log. The database has no
        // "published by" column yet.
        private string Actor =>
            $"{User.FindFirstValue(ClaimTypes.Name) ?? "?"} (id {User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "?"})";

        [HttpGet]
        public async Task<ActionResult<IEnumerable<BrowserRelease>>> GetAll()
        {
            return Ok(await _releases.GetAllReleasesAsync());
        }

        [HttpPost]
        public async Task<ActionResult<BrowserRelease>> Create([FromBody] CreateReleaseRequest req)
        {
            var problems = ReleaseRequestValidator.Validate(req, _allowedInstallerHosts, _signing);
            if (problems.Count > 0)
            {
                _logger.LogWarning("Release publish by {Actor} rejected: {Problems}", Actor, string.Join(" ", problems));
                return BadRequest(new { errors = problems });
            }

            var release = new BrowserRelease
            {
                AppId         = req.AppId,
                Version       = req.Version,
                Platform      = req.Platform,
                Arch          = req.Arch,
                InstallerName = req.InstallerName,
                InstallerUrl  = req.InstallerUrl,
                HashSha256    = req.HashSha256,
                SizeBytes     = req.SizeBytes,
                RolloutWeight = req.RolloutWeight,
                ExperimentName = req.ExperimentName,
                Signature     = req.Signature,
                MirrorUrls    = req.MirrorUrls is { Length: > 0 }
                                    ? System.Text.Json.JsonSerializer.Serialize(req.MirrorUrls)
                                    : null,
            };

            var created = await _releases.CreateReleaseAsync(release);
            _logger.LogWarning(
                "Release published by {Actor}: id {Id}, app {AppId}, version {Version}, {Platform}/{Arch}, weight {Weight}, url {Url}",
                Actor, created.Id, created.AppId, created.Version, created.Platform, created.Arch,
                created.RolloutWeight, created.InstallerUrl);
            return CreatedAtAction(nameof(GetAll), created);
        }

        // IONOS does not support PUT/DELETE verbs; use POST-based deactivation instead
        [HttpPost("{id}/deactivate")]
        public async Task<IActionResult> Deactivate(int id)
        {
            var ok = await _releases.DeactivateReleaseAsync(id);
            if (!ok) return NotFound();
            _logger.LogWarning("Release {Id} deactivated by {Actor}", id, Actor);
            return NoContent();
        }

        [HttpPost("{id}/activate")]
        public async Task<IActionResult> Activate(int id)
        {
            var ok = await _releases.ActivateReleaseAsync(id);
            if (!ok) return NotFound();
            _logger.LogWarning("Release {Id} activated by {Actor}", id, Actor);
            return NoContent();
        }
    }

    public record CreateReleaseRequest(
        string AppId,
        string Version,
        string Platform,
        string Arch,
        string InstallerName,
        string InstallerUrl,
        string HashSha256,
        long   SizeBytes,
        // 0-100. Omit (or 100) for normal releases -- every client gets it.
        // Set lower to stage a rollout or run an A/B experiment alongside
        // other active releases for the same AppId/Platform/Arch.
        int    RolloutWeight = 100,
        string? ExperimentName = null,
        // "<16 hex key id>:<base64>" from ReleaseSigner.cs; see ReleaseSignature.
        string? Signature = null,
        // Optional extra https download URLs, tried in order after InstallerUrl if it
        // fails. At most 5; the signed hash/size pin the file, so mirrors are safe.
        string[]? MirrorUrls = null
    );
}
