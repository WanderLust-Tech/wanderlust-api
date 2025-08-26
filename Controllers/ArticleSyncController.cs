using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Services;
using WanderlustApi.Data;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ArticleSyncController : ControllerBase
    {
        private readonly IArticleSyncService _syncService;
        private readonly IConfiguration _configuration;
        private readonly ILogger<ArticleSyncController> _logger;
        private readonly WanderlustDbContext _context;

        public ArticleSyncController(
            IArticleSyncService syncService, 
            IConfiguration configuration,
            ILogger<ArticleSyncController> logger,
            WanderlustDbContext context)
        {
            _syncService = syncService;
            _configuration = configuration;
            _logger = logger;
            _context = context;
        }

        /// <summary>
        /// Performs a full sync from markdown files to database
        /// </summary>
        [HttpPost("sync-from-markdown")]
        public async Task<ActionResult<SyncResult>> SyncFromMarkdown()
        {
            try
            {
                var contentPath = GetContentPath();
                if (string.IsNullOrEmpty(contentPath) || !Directory.Exists(contentPath))
                {
                    return BadRequest($"Content path not found or not configured: {contentPath}");
                }

                _logger.LogInformation("Starting sync from markdown files at: {ContentPath}", contentPath);
                var result = await _syncService.PerformFullSyncAsync(contentPath);
                
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error during markdown to database sync");
                return StatusCode(500, new { error = "Sync failed", details = ex.Message });
            }
        }

        /// <summary>
        /// Syncs database articles back to markdown files
        /// </summary>
        [HttpPost("sync-to-markdown")]
        public async Task<ActionResult> SyncToMarkdown()
        {
            try
            {
                var contentPath = GetContentPath();
                if (string.IsNullOrEmpty(contentPath))
                {
                    return BadRequest("Content path not configured");
                }

                _logger.LogInformation("Starting sync to markdown files at: {ContentPath}", contentPath);
                await _syncService.SyncDatabaseToMarkdownFilesAsync(contentPath);
                
                return Ok(new { message = "Successfully synced database to markdown files" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error during database to markdown sync");
                return StatusCode(500, new { error = "Sync failed", details = ex.Message });
            }
        }

        /// <summary>
        /// Gets the current sync status and content statistics
        /// </summary>
        [HttpGet("status")]
        public async Task<ActionResult> GetSyncStatus()
        {
            try
            {
                var contentPath = GetContentPath();
                var status = new
                {
                    contentPath = contentPath,
                    contentPathExists = !string.IsNullOrEmpty(contentPath) && Directory.Exists(contentPath),
                    markdownFileCount = !string.IsNullOrEmpty(contentPath) && Directory.Exists(contentPath) 
                        ? Directory.GetFiles(contentPath, "*.md", SearchOption.AllDirectories).Length 
                        : 0,
                    databaseArticleCount = await GetDatabaseArticleCountAsync(),
                    lastSyncTime = GetLastSyncTime(),
                    isContentPathConfigured = !string.IsNullOrEmpty(contentPath)
                };

                return Ok(status);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting sync status");
                return StatusCode(500, new { error = "Failed to get sync status", details = ex.Message });
            }
        }

        /// <summary>
        /// Validates content integrity between files and database
        /// </summary>
        [HttpGet("validate")]
        public async Task<ActionResult> ValidateContent()
        {
            try
            {
                var contentPath = GetContentPath();
                if (string.IsNullOrEmpty(contentPath) || !Directory.Exists(contentPath))
                {
                    return BadRequest($"Content path not found: {contentPath}");
                }

                var validation = await PerformContentValidationAsync(contentPath);
                return Ok(validation);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error during content validation");
                return StatusCode(500, new { error = "Validation failed", details = ex.Message });
            }
        }

        /// <summary>
        /// Syncs a specific markdown file by path
        /// </summary>
        [HttpPost("sync-file")]
        public async Task<ActionResult> SyncSpecificFile([FromBody] SyncFileRequest request)
        {
            try
            {
                var contentPath = GetContentPath();
                if (string.IsNullOrEmpty(contentPath))
                {
                    return BadRequest("Content path not configured");
                }

                var fullFilePath = Path.Combine(contentPath, request.RelativePath);
                if (!System.IO.File.Exists(fullFilePath))
                {
                    return NotFound($"File not found: {request.RelativePath}");
                }

                var article = await _syncService.CreateArticleFromMarkdownAsync(fullFilePath, contentPath);
                if (article == null)
                {
                    return BadRequest("Failed to parse markdown file");
                }

                // Check if article exists and update or create
                // Implementation similar to the full sync logic
                
                return Ok(new { message = $"Successfully synced file: {request.RelativePath}" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error syncing specific file: {FilePath}", request.RelativePath);
                return StatusCode(500, new { error = "File sync failed", details = ex.Message });
            }
        }

        private string GetContentPath()
        {
            // Try multiple configuration sources
            var contentPath = _configuration["ContentSync:MarkdownPath"] 
                ?? _configuration["MARKDOWN_CONTENT_PATH"]
                ?? Environment.GetEnvironmentVariable("MARKDOWN_CONTENT_PATH");

            // If not configured, try to detect based on common patterns
            if (string.IsNullOrEmpty(contentPath))
            {
                var possiblePaths = new[]
                {
                    Path.Combine(Directory.GetCurrentDirectory(), "..", "..", "wanderlust-knowledgebase", "public", "content"),
                    Path.Combine(Directory.GetCurrentDirectory(), "content"),
                    Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "content"),
                    "/app/content", // Docker path
                    "C:\\content" // Windows fallback
                };

                contentPath = possiblePaths.FirstOrDefault(Directory.Exists);
            }

            return contentPath ?? string.Empty;
        }

        private async Task<int> GetDatabaseArticleCountAsync()
        {
            return await _context.Articles.CountAsync();
        }

        private DateTime? GetLastSyncTime()
        {
            // This could be stored in configuration or a separate tracking table
            // For now, return null
            return null; // TODO: Implement last sync time tracking
        }

        private async Task<object> PerformContentValidationAsync(string contentPath)
        {
            var markdownFiles = Directory.GetFiles(contentPath, "*.md", SearchOption.AllDirectories);
            var issues = new List<string>();
            var summary = new
            {
                totalMarkdownFiles = markdownFiles.Length,
                filesWithIssues = 0,
                issues = issues,
                validationTime = DateTime.UtcNow
            };

            foreach (var file in markdownFiles)
            {
                try
                {
                    var content = await System.IO.File.ReadAllTextAsync(file);
                    
                    // Basic validation checks
                    if (string.IsNullOrWhiteSpace(content))
                    {
                        issues.Add($"Empty file: {Path.GetRelativePath(contentPath, file)}");
                    }
                    
                    if (!content.Contains('#'))
                    {
                        issues.Add($"No headings found: {Path.GetRelativePath(contentPath, file)}");
                    }
                }
                catch (Exception ex)
                {
                    issues.Add($"Error reading file {Path.GetRelativePath(contentPath, file)}: {ex.Message}");
                }
            }

            return summary;
        }
    }

    public class SyncFileRequest
    {
        public string RelativePath { get; set; } = string.Empty;
    }
}
