using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Controllers
{
    // Backs custom-browser's chrome://feedback page. Submission is
    // deliberately anonymous (no sign-in prompt for a bug report) --
    // ContactEmail is an optional, user-typed field, not tied to any
    // OAuth identity. Admin triage (list/resolve) requires a
    // wanderlust-api Admin account.
    [ApiController]
    [Route("api/[controller]")]
    public class FeedbackController : ControllerBase
    {
        private readonly IFeedbackRepository _feedback;

        public FeedbackController(IFeedbackRepository feedback)
        {
            _feedback = feedback;
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult<FeedbackEntry>> Submit([FromBody] SubmitFeedbackRequest request)
        {
            var entry = new FeedbackEntry
            {
                Description = request.Description,
                Url = request.Url ?? "",
                SystemInfo = request.SystemInfo ?? "",
                ContactEmail = string.IsNullOrWhiteSpace(request.ContactEmail) ? null : request.ContactEmail,
            };

            var created = await _feedback.CreateAsync(entry);
            return CreatedAtAction(nameof(Submit), created);
        }

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FeedbackEntry>>> GetAll()
        {
            return Ok(await _feedback.GetAllAsync());
        }

        // IONOS does not support the DELETE/PUT verbs; use POST-based mutation.
        [Authorize(Roles = "Admin")]
        [HttpPost("{id}/resolve")]
        public async Task<IActionResult> Resolve(int id)
        {
            var ok = await _feedback.MarkResolvedAsync(id);
            if (!ok) return NotFound();
            return NoContent();
        }
    }

    public record SubmitFeedbackRequest(string Description, string? Url, string? SystemInfo, string? ContactEmail);
}
