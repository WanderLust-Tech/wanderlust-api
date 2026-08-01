using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WhatsNewController : ControllerBase
    {
        private readonly IWhatsNewRepository _entries;

        public WhatsNewController(IWhatsNewRepository entries)
        {
            _entries = entries;
        }

        // Anonymous by design: a chrome://whats-new page has no wanderlust-api
        // login session and shouldn't need one just to read changelog entries
        // (mirrors OmahaController's public /v4/update endpoint, not
        // ReleasesController's [Authorize]-gated admin read).
        [AllowAnonymous]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WhatsNewEntry>>> GetActive([FromQuery] string appId)
        {
            return Ok(await _entries.GetActiveEntriesAsync(appId));
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<WhatsNewEntry>> Create([FromBody] CreateWhatsNewEntryRequest req)
        {
            var entry = new WhatsNewEntry
            {
                AppId   = req.AppId,
                Version = req.Version,
                Title   = req.Title,
                Body    = req.Body,
            };

            var created = await _entries.CreateEntryAsync(entry);
            return CreatedAtAction(nameof(GetActive), created);
        }

        // IONOS does not support PUT/DELETE verbs; use POST-based deactivation instead
        [Authorize]
        [HttpPost("{id}/deactivate")]
        public async Task<IActionResult> Deactivate(int id)
        {
            var ok = await _entries.DeactivateEntryAsync(id);
            if (!ok) return NotFound();
            return NoContent();
        }
    }

    public record CreateWhatsNewEntryRequest(
        string AppId,
        string Version,
        string Title,
        string Body
    );
}
