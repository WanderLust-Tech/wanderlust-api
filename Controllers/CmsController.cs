using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.Models;
using WanderlustApi.Services;
using System.Security.Claims;

namespace WanderlustApi.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin,Moderator")]
public class CmsController : ControllerBase
{
    private readonly WanderlustDbContext _context;
    private readonly IRealTimeNotificationService _notificationService;
    private readonly ILogger<CmsController> _logger;

    public CmsController(
        WanderlustDbContext context, 
        IRealTimeNotificationService notificationService,
        ILogger<CmsController> logger)
    {
        _context = context;
        _notificationService = notificationService;
        _logger = logger;
    }

    // CONTENT MANAGEMENT

    [HttpGet("content")]
    public async Task<ActionResult<IEnumerable<ContentItem>>> GetAllContent()
    {
        var articles = await _context.Articles
            .Select(a => new ContentItem
            {
                Id = a.Id.ToString(),
                Title = a.Title,
                Type = "article",
                Status = a.IsPublished ? "published" : "draft",
                Author = "System", // Article model doesn't have Author field
                CreatedAt = a.CreatedAt,
                UpdatedAt = a.UpdatedAt,
                Path = a.Path, // Using Path instead of FilePath
                Category = a.Category,
                Tags = a.Tags
            })
            .ToListAsync();

        var codeExamples = await _context.CodeExamples
            .Select(c => new ContentItem
            {
                Id = c.Id,
                Title = c.Title,
                Type = "code-example",
                Status = "published", // Code examples are always published
                Author = c.Author ?? "Unknown",
                CreatedAt = DateTime.UtcNow, // CodeExample doesn't have CreatedAt
                UpdatedAt = DateTime.UtcNow,
                Path = $"/code-examples/{c.Id}",
                Category = c.Category.ToString(), // Convert enum to string
                Tags = c.Tags
            })
            .ToListAsync();

        var allContent = articles.Concat(codeExamples)
            .OrderByDescending(c => c.UpdatedAt)
            .ToList();

        return Ok(allContent);
    }

    [HttpGet("content/{type}/{id}")]
    public async Task<ActionResult<ContentDetails>> GetContentDetails(string type, string id)
    {
        switch (type.ToLower())
        {
            case "article":
                if (int.TryParse(id, out int articleId))
                {
                    var article = await _context.Articles.FindAsync(articleId);
                    if (article == null) return NotFound();

                    return Ok(new ContentDetails
                    {
                        Id = article.Id.ToString(),
                        Title = article.Title,
                        Content = article.Content,
                        Type = "article",
                        Status = article.IsPublished ? "published" : "draft",
                        Author = "System", // Article model doesn't have Author field
                        CreatedAt = article.CreatedAt,
                        UpdatedAt = article.UpdatedAt,
                        Path = article.Path, // Using Path instead of FilePath
                        Category = article.Category,
                        Tags = article.Tags,
                        Metadata = new Dictionary<string, object>
                        {
                            ["wordCount"] = article.Content?.Split(' ').Length ?? 0,
                            ["readingTime"] = article.ReadingTimeMinutes,
                            ["description"] = article.Description ?? "",
                            ["path"] = article.Path
                        }
                    });
                }
                break;

            case "code-example":
                var codeExample = await _context.CodeExamples.FindAsync(id);
                if (codeExample == null) return NotFound();

                return Ok(new ContentDetails
                {
                    Id = codeExample.Id,
                    Title = codeExample.Title,
                    Content = codeExample.Code,
                    Type = "code-example",
                    Status = "published",
                    Author = codeExample.Author ?? "Unknown",
                    CreatedAt = DateTime.UtcNow,
                    UpdatedAt = DateTime.UtcNow,
                    Path = $"/code-examples/{codeExample.Id}",
                    Category = codeExample.Category.ToString(), // Convert enum to string
                    Tags = codeExample.Tags,
                    Metadata = new Dictionary<string, object>
                    {
                        ["language"] = codeExample.Language.ToString(),
                        ["difficulty"] = codeExample.Difficulty.ToString(),
                        ["description"] = codeExample.Description,
                        ["longDescription"] = codeExample.LongDescription ?? ""
                    }
                });
        }

        return NotFound();
    }

    // ANALYTICS & INSIGHTS

    [HttpGet("analytics/content")]
    public async Task<ActionResult<ContentAnalytics>> GetContentAnalytics()
    {
        var totalArticles = await _context.Articles.CountAsync();
        var publishedArticles = await _context.Articles.CountAsync(a => a.IsPublished);
        var draftArticles = totalArticles - publishedArticles;
        var totalCodeExamples = await _context.CodeExamples.CountAsync();

        var recentArticles = await _context.Articles
            .Where(a => a.UpdatedAt >= DateTime.UtcNow.AddDays(-30))
            .CountAsync();

        var topCategories = await _context.Articles
            .GroupBy(a => a.Category)
            .Select(g => new CategoryStats
            {
                Category = g.Key ?? "Uncategorized",
                Count = g.Count(),
                Published = g.Count(a => a.IsPublished),
                Drafts = g.Count(a => !a.IsPublished)
            })
            .OrderByDescending(c => c.Count)
            .Take(10)
            .ToListAsync();

        return Ok(new ContentAnalytics
        {
            TotalArticles = totalArticles,
            PublishedArticles = publishedArticles,
            DraftArticles = draftArticles,
            TotalCodeExamples = totalCodeExamples,
            RecentUpdates = recentArticles,
            TopCategories = topCategories,
            LastUpdated = DateTime.UtcNow
        });
    }

    // BASIC UPDATE OPERATIONS

    [HttpPut("content/article/{id}/publish")]
    public async Task<IActionResult> PublishArticle(int id)
    {
        var article = await _context.Articles.FindAsync(id);
        if (article == null) return NotFound();

        article.IsPublished = true;
        article.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        _logger.LogInformation("Article {ArticleId} published by {Username}", id, username);

        return NoContent();
    }

    [HttpPut("content/article/{id}/unpublish")]
    public async Task<IActionResult> UnpublishArticle(int id)
    {
        var article = await _context.Articles.FindAsync(id);
        if (article == null) return NotFound();

        article.IsPublished = false;
        article.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        _logger.LogInformation("Article {ArticleId} unpublished by {Username}", id, username);

        return NoContent();
    }

    [HttpDelete("content/article/{id}")]
    public async Task<IActionResult> DeleteArticle(int id)
    {
        var article = await _context.Articles.FindAsync(id);
        if (article == null) return NotFound();

        _context.Articles.Remove(article);
        await _context.SaveChangesAsync();

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        _logger.LogInformation("Article {ArticleId} deleted by {Username}", id, username);

        return NoContent();
    }

    [HttpDelete("content/code-example/{id}")]
    public async Task<IActionResult> DeleteCodeExample(string id)
    {
        var codeExample = await _context.CodeExamples.FindAsync(id);
        if (codeExample == null) return NotFound();

        _context.CodeExamples.Remove(codeExample);
        await _context.SaveChangesAsync();

        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        _logger.LogInformation("Code example {CodeExampleId} deleted by {Username}", id, username);

        return NoContent();
    }

    // BULK OPERATIONS

    [HttpPost("bulk/publish")]
    public async Task<IActionResult> BulkPublish([FromBody] BulkOperationRequest request)
    {
        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        var affectedCount = 0;

        foreach (var id in request.ContentIds)
        {
            if (int.TryParse(id, out int articleId))
            {
                var article = await _context.Articles.FindAsync(articleId);
                if (article != null && !article.IsPublished)
                {
                    article.IsPublished = true;
                    article.UpdatedAt = DateTime.UtcNow;
                    affectedCount++;
                }
            }
        }

        await _context.SaveChangesAsync();

        _logger.LogInformation("Bulk publish operation completed by {Username}. {Count} articles published", 
            username, affectedCount);

        return Ok(new { AffectedCount = affectedCount });
    }

    [HttpPost("bulk/unpublish")]
    public async Task<IActionResult> BulkUnpublish([FromBody] BulkOperationRequest request)
    {
        var username = User.FindFirst(ClaimTypes.Name)?.Value ?? "Admin";
        var affectedCount = 0;

        foreach (var id in request.ContentIds)
        {
            if (int.TryParse(id, out int articleId))
            {
                var article = await _context.Articles.FindAsync(articleId);
                if (article != null && article.IsPublished)
                {
                    article.IsPublished = false;
                    article.UpdatedAt = DateTime.UtcNow;
                    affectedCount++;
                }
            }
        }

        await _context.SaveChangesAsync();

        _logger.LogInformation("Bulk unpublish operation completed by {Username}. {Count} articles unpublished", 
            username, affectedCount);

        return Ok(new { AffectedCount = affectedCount });
    }
}
