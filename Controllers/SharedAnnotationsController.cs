using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using WanderlustApi.Data.Entities;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Controllers
{
    // Backs custom-browser's Page Notes "shared annotations" feature
    // (PageNotesBackendClient). Anonymous read (mirrors WhatsNewController --
    // a chrome://sidebar/notes panel has no login prompt of its own),
    // authenticated write via a wanderlust-api JWT obtained through either
    // normal login or AuthController's external-login (Google/Microsoft)
    // exchange.
    [ApiController]
    [Route("api/[controller]")]
    public class SharedAnnotationsController : ControllerBase
    {
        private readonly ISharedAnnotationRepository _annotations;

        public SharedAnnotationsController(ISharedAnnotationRepository annotations)
        {
            _annotations = annotations;
        }

        [AllowAnonymous]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SharedAnnotationDto>>> GetForUrl([FromQuery] string url)
        {
            var annotations = await _annotations.GetActiveForUrlAsync(url);
            return Ok(annotations.Select(MapToDto));
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<SharedAnnotationDto>> Create([FromBody] CreateSharedAnnotationRequest request)
        {
            var annotation = new SharedAnnotation
            {
                Url = request.Url,
                Text = request.Text,
                UserId = GetCurrentUserId(),
                UserName = GetCurrentDisplayName(),
            };

            var created = await _annotations.CreateAsync(annotation);
            return CreatedAtAction(nameof(GetForUrl), new { url = created.Url }, MapToDto(created));
        }

        // IONOS does not support the DELETE verb; use POST-based deactivation.
        [Authorize]
        [HttpPost("{id}/delete")]
        public async Task<IActionResult> Delete(int id)
        {
            var annotation = await _annotations.GetByIdAsync(id);
            if (annotation == null) return NotFound();

            // Only the author (or a moderator/admin) may remove an annotation.
            var role = User.FindFirst(ClaimTypes.Role)?.Value;
            if (annotation.UserId != GetCurrentUserId() && role != "Moderator" && role != "Admin")
            {
                return Forbid();
            }

            var ok = await _annotations.DeactivateAsync(id);
            if (!ok) return NotFound();
            return NoContent();
        }

        private int GetCurrentUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            return int.Parse(userIdClaim ?? "0");
        }

        private string GetCurrentDisplayName()
        {
            return User.FindFirst("DisplayName")?.Value
                ?? User.FindFirst(ClaimTypes.Name)?.Value
                ?? "Anonymous";
        }

        // Wire shape matches custom-browser's SharedAnnotation struct
        // (page_notes_backend_client.h) exactly -- id as a string, a plain
        // Unix-seconds timestamp instead of a serialized DateTime, so the
        // C++ client needs no date-format parsing.
        private static SharedAnnotationDto MapToDto(SharedAnnotation a) => new(
            a.Id.ToString(),
            a.Url,
            a.Text,
            a.UserName,
            new DateTimeOffset(DateTime.SpecifyKind(a.CreatedAt, DateTimeKind.Utc)).ToUnixTimeSeconds());
    }

    public record CreateSharedAnnotationRequest(string Url, string Text);

    public record SharedAnnotationDto(string Id, string Url, string Text, string UserName, long Timestamp);
}
