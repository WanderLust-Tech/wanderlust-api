using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class QaChecklistController : ControllerBase
    {
        private readonly IQaChecklistRepository _checklist;

        public QaChecklistController(IQaChecklistRepository checklist)
        {
            _checklist = checklist;
        }

        [HttpGet("template")]
        public async Task<ActionResult<IEnumerable<QaChecklistTemplateItem>>> GetTemplate()
        {
            return Ok(await _checklist.GetTemplateItemsAsync());
        }

        [HttpGet("runs")]
        public async Task<ActionResult<IEnumerable<QaChecklistRun>>> GetRuns()
        {
            return Ok(await _checklist.GetRunsAsync());
        }

        [HttpPost("runs")]
        public async Task<ActionResult<QaChecklistRun>> CreateRun([FromBody] CreateRunRequest req)
        {
            var run = await _checklist.CreateRunAsync(req.AppId, req.Version, GetCurrentDisplayName());
            return CreatedAtAction(nameof(GetRun), new { id = run.Id }, run);
        }

        [HttpGet("runs/{id}")]
        public async Task<ActionResult<RunDetailResponse>> GetRun(int id)
        {
            var run = await _checklist.GetRunAsync(id);
            if (run == null) return NotFound();

            var items = await _checklist.GetRunItemsAsync(id);
            return Ok(new RunDetailResponse(run, items));
        }

        // IONOS does not support PUT/DELETE verbs; use POST-based updates instead
        [HttpPost("runs/{runId}/items/{itemId}")]
        public async Task<IActionResult> SetItemStatus(int runId, int itemId, [FromBody] SetItemStatusRequest req)
        {
            var ok = await _checklist.SetItemStatusAsync(runId, itemId, req.IsComplete, GetCurrentDisplayName(), req.Notes);
            if (!ok) return NotFound();
            return NoContent();
        }

        private string GetCurrentDisplayName()
        {
            return User.FindFirst("DisplayName")?.Value
                ?? User.FindFirst(ClaimTypes.Name)?.Value
                ?? "Unknown";
        }
    }

    public record CreateRunRequest(string AppId, string Version);

    public record SetItemStatusRequest(bool IsComplete, string? Notes);

    public record RunDetailResponse(QaChecklistRun Run, IReadOnlyList<QaChecklistRunItem> Items);
}
