using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.Models;
using System.Security.Claims;

namespace WanderlustApi.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin,Moderator")]
public class MediaController : ControllerBase
{
    private readonly WanderlustDbContext _context;
    private readonly IWebHostEnvironment _environment;
    private readonly ILogger<MediaController> _logger;

    private readonly string[] AllowedImageTypes = { "image/jpeg", "image/png", "image/gif", "image/webp", "image/svg+xml" };
    private readonly string[] AllowedDocumentTypes = { "application/pdf", "text/plain", "application/json" };
    private readonly long MaxFileSize = 10 * 1024 * 1024; // 10MB

    public MediaController(
        WanderlustDbContext context,
        IWebHostEnvironment environment,
        ILogger<MediaController> logger)
    {
        _context = context;
        _environment = environment;
        _logger = logger;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<MediaItem>>> GetMedia(
        [FromQuery] string? type = null,
        [FromQuery] string? tag = null,
        [FromQuery] int page = 1,
        [FromQuery] int limit = 20)
    {
        var query = _context.MediaItems.AsQueryable();

        if (!string.IsNullOrEmpty(type))
        {
            query = query.Where(m => m.MimeType.StartsWith(type));
        }

        if (!string.IsNullOrEmpty(tag))
        {
            query = query.Where(m => m.Tags.Contains(tag));
        }

        var media = await query
            .OrderByDescending(m => m.UploadedAt)
            .Skip((page - 1) * limit)
            .Take(limit)
            .ToListAsync();

        return Ok(media);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<MediaItem>> GetMediaItem(string id)
    {
        var media = await _context.MediaItems.FindAsync(id);
        if (media == null) return NotFound();

        return Ok(media);
    }

    [HttpPost("upload")]
    public async Task<ActionResult<MediaItem>> UploadMedia([FromForm] UploadMediaRequest request)
    {
        if (request.File == null || request.File.Length == 0)
            return BadRequest("No file provided");

        if (request.File.Length > MaxFileSize)
            return BadRequest($"File size exceeds maximum allowed size of {MaxFileSize / 1024 / 1024}MB");

        var allowedTypes = AllowedImageTypes.Concat(AllowedDocumentTypes);
        if (!allowedTypes.Contains(request.File.ContentType))
            return BadRequest("File type not allowed");

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        var uploadsPath = Path.Combine(_environment.WebRootPath ?? "wwwroot", "uploads");
        Directory.CreateDirectory(uploadsPath);

        var fileExtension = Path.GetExtension(request.File.FileName);
        var fileName = $"{Guid.NewGuid()}{fileExtension}";
        var filePath = Path.Combine(uploadsPath, fileName);

        try
        {
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await request.File.CopyToAsync(stream);
            }

            var mediaItem = new MediaItem
            {
                FileName = fileName,
                OriginalName = request.File.FileName,
                MimeType = request.File.ContentType,
                Size = request.File.Length,
                Url = $"/uploads/{fileName}",
                Alt = request.Alt,
                Description = request.Description,
                UploadedBy = username,
                Tags = request.Tags,
                Metadata = new Dictionary<string, object>
                {
                    ["originalSize"] = request.File.Length,
                    ["uploadedAt"] = DateTime.UtcNow,
                    ["fileExtension"] = fileExtension
                }
            };

            // Add image-specific metadata
            if (request.File.ContentType.StartsWith("image/"))
            {
                // You could add image processing here to get dimensions
                mediaItem.Metadata["isImage"] = true;
            }

            _context.MediaItems.Add(mediaItem);
            await _context.SaveChangesAsync();

            _logger.LogInformation("Media file {FileName} uploaded by {Username}", fileName, username);

            return CreatedAtAction(nameof(GetMediaItem), new { id = mediaItem.Id }, mediaItem);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error uploading file {FileName}", request.File.FileName);
            
            // Clean up file if database save failed
            if (System.IO.File.Exists(filePath))
                System.IO.File.Delete(filePath);

            return StatusCode(500, "Error uploading file");
        }
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateMedia(string id, [FromBody] UpdateMediaRequest request)
    {
        var media = await _context.MediaItems.FindAsync(id);
        if (media == null) return NotFound();

        media.Alt = request.Alt;
        media.Description = request.Description;
        media.Tags = request.Tags;

        await _context.SaveChangesAsync();

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        _logger.LogInformation("Media item {MediaId} updated by {Username}", id, username);

        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteMedia(string id)
    {
        var media = await _context.MediaItems.FindAsync(id);
        if (media == null) return NotFound();

        // Delete physical file
        var filePath = Path.Combine(_environment.WebRootPath ?? "wwwroot", "uploads", media.FileName);
        if (System.IO.File.Exists(filePath))
        {
            System.IO.File.Delete(filePath);
        }

        _context.MediaItems.Remove(media);
        await _context.SaveChangesAsync();

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        _logger.LogInformation("Media item {MediaId} deleted by {Username}", id, username);

        return NoContent();
    }

    [HttpGet("stats")]
    public async Task<ActionResult<MediaStats>> GetMediaStats()
    {
        var totalFiles = await _context.MediaItems.CountAsync();
        var totalSize = await _context.MediaItems.SumAsync(m => m.Size);
        var imageCount = await _context.MediaItems.CountAsync(m => m.MimeType.StartsWith("image/"));
        var documentCount = totalFiles - imageCount;

        var recentUploads = await _context.MediaItems
            .Where(m => m.UploadedAt >= DateTime.UtcNow.AddDays(-7))
            .CountAsync();

        var topUploaders = await _context.MediaItems
            .GroupBy(m => m.UploadedBy)
            .Select(g => new { User = g.Key, Count = g.Count() })
            .OrderByDescending(x => x.Count)
            .Take(5)
            .ToListAsync();

        return Ok(new MediaStats
        {
            TotalFiles = totalFiles,
            TotalSize = totalSize,
            ImageCount = imageCount,
            DocumentCount = documentCount,
            RecentUploads = recentUploads,
            TopUploaders = topUploaders.ToDictionary(x => x.User, x => x.Count)
        });
    }
}

public class UpdateMediaRequest
{
    public string? Alt { get; set; }
    public string? Description { get; set; }
    public List<string> Tags { get; set; } = new();
}

public class MediaStats
{
    public int TotalFiles { get; set; }
    public long TotalSize { get; set; }
    public int ImageCount { get; set; }
    public int DocumentCount { get; set; }
    public int RecentUploads { get; set; }
    public Dictionary<string, int> TopUploaders { get; set; } = new();
}
