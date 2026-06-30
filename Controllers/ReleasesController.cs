using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ReleasesController : ControllerBase
    {
        private readonly IBrowserReleaseRepository _releases;

        public ReleasesController(IBrowserReleaseRepository releases)
        {
            _releases = releases;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<BrowserRelease>>> GetAll()
        {
            return Ok(await _releases.GetAllReleasesAsync());
        }

        [HttpPost]
        public async Task<ActionResult<BrowserRelease>> Create([FromBody] CreateReleaseRequest req)
        {
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
            };

            var created = await _releases.CreateReleaseAsync(release);
            return CreatedAtAction(nameof(GetAll), created);
        }

        // IONOS does not support PUT/DELETE verbs; use POST-based deactivation instead
        [HttpPost("{id}/deactivate")]
        public async Task<IActionResult> Deactivate(int id)
        {
            var ok = await _releases.DeactivateReleaseAsync(id);
            if (!ok) return NotFound();
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
        long   SizeBytes
    );
}
