using WanderlustApi.Data;
using WanderlustApi.Models;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;
using System.Text.Json;

namespace WanderlustApi.Services
{
    public interface IArticleSyncService
    {
        Task SyncMarkdownFilesToDatabaseAsync(string contentRootPath);
        Task SyncDatabaseToMarkdownFilesAsync(string contentRootPath);
        Task<Article?> CreateArticleFromMarkdownAsync(string filePath, string contentRootPath);
        Task<bool> UpdateMarkdownFromArticleAsync(Article article, string contentRootPath);
        Task<SyncResult> PerformFullSyncAsync(string contentRootPath);
    }

    public class SyncResult
    {
        public int FilesProcessed { get; set; }
        public int ArticlesCreated { get; set; }
        public int ArticlesUpdated { get; set; }
        public int ArticlesSkipped { get; set; }
        public List<string> Errors { get; set; } = new();
        public DateTime SyncStartTime { get; set; }
        public DateTime SyncEndTime { get; set; }
        public TimeSpan Duration => SyncEndTime - SyncStartTime;
    }

    public class MarkdownMetadata
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public List<string> Tags { get; set; } = new();
        public string Category { get; set; } = string.Empty;
        public DateTime? LastModified { get; set; }
        public bool IsPublished { get; set; } = true;
        public int ReadingTimeMinutes { get; set; }
    }

    public class ArticleSyncService : IArticleSyncService
    {
        private readonly WanderlustDbContext _context;
        private readonly ILogger<ArticleSyncService> _logger;

        public ArticleSyncService(WanderlustDbContext context, ILogger<ArticleSyncService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<SyncResult> PerformFullSyncAsync(string contentRootPath)
        {
            var result = new SyncResult
            {
                SyncStartTime = DateTime.UtcNow
            };

            try
            {
                _logger.LogInformation("Starting full article sync from {ContentPath}", contentRootPath);

                // Get all markdown files
                var markdownFiles = Directory.GetFiles(contentRootPath, "*.md", SearchOption.AllDirectories);
                result.FilesProcessed = markdownFiles.Length;

                foreach (var filePath in markdownFiles)
                {
                    try
                    {
                        var article = await CreateArticleFromMarkdownAsync(filePath, contentRootPath);
                        if (article == null)
                        {
                            result.ArticlesSkipped++;
                            continue;
                        }

                        // Check if article already exists by path
                        var existingArticle = await _context.Articles
                            .FirstOrDefaultAsync(a => a.Path == article.Path);

                        if (existingArticle == null)
                        {
                            // Create new article
                            _context.Articles.Add(article);
                            result.ArticlesCreated++;
                            _logger.LogDebug("Creating new article: {Path}", article.Path);
                        }
                        else
                        {
                            // Update existing article if markdown is newer
                            var fileInfo = new FileInfo(filePath);
                            if (fileInfo.LastWriteTimeUtc > existingArticle.UpdatedAt)
                            {
                                existingArticle.Title = article.Title;
                                existingArticle.Content = article.Content;
                                existingArticle.Category = article.Category;
                                existingArticle.Tags = article.Tags;
                                existingArticle.Description = article.Description;
                                existingArticle.ReadingTimeMinutes = article.ReadingTimeMinutes;
                                existingArticle.IsPublished = article.IsPublished;
                                existingArticle.UpdatedAt = DateTime.UtcNow;

                                result.ArticlesUpdated++;
                                _logger.LogDebug("Updating existing article: {Path}", article.Path);
                            }
                            else
                            {
                                result.ArticlesSkipped++;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        var error = $"Error processing file {filePath}: {ex.Message}";
                        result.Errors.Add(error);
                        _logger.LogError(ex, "Error processing markdown file: {FilePath}", filePath);
                    }
                }

                await _context.SaveChangesAsync();
                _logger.LogInformation("Article sync completed. Created: {Created}, Updated: {Updated}, Skipped: {Skipped}, Errors: {Errors}",
                    result.ArticlesCreated, result.ArticlesUpdated, result.ArticlesSkipped, result.Errors.Count);
            }
            catch (Exception ex)
            {
                result.Errors.Add($"Full sync failed: {ex.Message}");
                _logger.LogError(ex, "Full article sync failed");
            }

            result.SyncEndTime = DateTime.UtcNow;
            return result;
        }

        public async Task SyncMarkdownFilesToDatabaseAsync(string contentRootPath)
        {
            await PerformFullSyncAsync(contentRootPath);
        }

        public async Task SyncDatabaseToMarkdownFilesAsync(string contentRootPath)
        {
            var articles = await _context.Articles.Where(a => a.IsPublished).ToListAsync();

            foreach (var article in articles)
            {
                await UpdateMarkdownFromArticleAsync(article, contentRootPath);
            }
        }

        public async Task<Article?> CreateArticleFromMarkdownAsync(string filePath, string contentRootPath)
        {
            try
            {
                var content = await File.ReadAllTextAsync(filePath);
                var metadata = ParseMarkdownMetadata(content);
                var fileInfo = new FileInfo(filePath);

                // Calculate relative path from content root
                var relativePath = Path.GetRelativePath(contentRootPath, filePath)
                    .Replace('\\', '/')
                    .Replace(".md", "");

                // Extract category from path (first directory)
                var pathParts = relativePath.Split('/');
                var category = pathParts.Length > 1 ? pathParts[0] : "general";

                var article = new Article
                {
                    Title = metadata.Title,
                    Content = content,
                    Category = category,
                    Path = relativePath,
                    Tags = metadata.Tags,
                    Description = metadata.Description,
                    ReadingTimeMinutes = metadata.ReadingTimeMinutes > 0 ? metadata.ReadingTimeMinutes : EstimateReadingTime(content),
                    IsPublished = metadata.IsPublished,
                    CreatedAt = fileInfo.CreationTimeUtc,
                    UpdatedAt = fileInfo.LastWriteTimeUtc
                };

                return article;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to create article from markdown file: {FilePath}", filePath);
                return null;
            }
        }

        public async Task<bool> UpdateMarkdownFromArticleAsync(Article article, string contentRootPath)
        {
            try
            {
                var filePath = Path.Combine(contentRootPath, $"{article.Path}.md");
                var directory = Path.GetDirectoryName(filePath);

                if (!string.IsNullOrEmpty(directory) && !Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }

                // Create markdown content with frontmatter
                var frontmatter = new
                {
                    title = article.Title,
                    description = article.Description,
                    category = article.Category,
                    tags = article.Tags,
                    published = article.IsPublished,
                    readingTime = article.ReadingTimeMinutes,
                    lastModified = article.UpdatedAt.ToString("yyyy-MM-ddTHH:mm:ssZ")
                };

                var frontmatterYaml = "---\n" + 
                    System.Text.Json.JsonSerializer.Serialize(frontmatter, new JsonSerializerOptions { WriteIndented = true }) + 
                    "\n---\n\n";

                var fullContent = frontmatterYaml + article.Content;
                await File.WriteAllTextAsync(filePath, fullContent);

                _logger.LogDebug("Updated markdown file: {FilePath}", filePath);
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to update markdown file for article: {ArticleId}", article.Id);
                return false;
            }
        }

        private MarkdownMetadata ParseMarkdownMetadata(string content)
        {
            var metadata = new MarkdownMetadata();

            // Try to parse frontmatter (YAML or JSON)
            var frontmatterMatch = Regex.Match(content, @"^---\s*\n(.*?)\n---\s*\n", RegexOptions.Singleline);
            if (frontmatterMatch.Success)
            {
                try
                {
                    var frontmatterContent = frontmatterMatch.Groups[1].Value;
                    // Try parsing as JSON first
                    if (frontmatterContent.TrimStart().StartsWith('{'))
                    {
                        var frontmatterData = JsonSerializer.Deserialize<Dictionary<string, JsonElement>>(frontmatterContent);
                        if (frontmatterData != null)
                        {
                            if (frontmatterData.TryGetValue("title", out var title))
                                metadata.Title = title.GetString() ?? "";
                            if (frontmatterData.TryGetValue("description", out var desc))
                                metadata.Description = desc.GetString() ?? "";
                            if (frontmatterData.TryGetValue("category", out var cat))
                                metadata.Category = cat.GetString() ?? "";
                            if (frontmatterData.TryGetValue("published", out var pub))
                                metadata.IsPublished = pub.GetBoolean();
                            if (frontmatterData.TryGetValue("readingTime", out var time))
                                metadata.ReadingTimeMinutes = time.GetInt32();
                            if (frontmatterData.TryGetValue("tags", out var tags) && tags.ValueKind == JsonValueKind.Array)
                            {
                                metadata.Tags = tags.EnumerateArray()
                                    .Select(t => t.GetString() ?? "")
                                    .Where(t => !string.IsNullOrEmpty(t))
                                    .ToList();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Failed to parse frontmatter, falling back to content parsing");
                }
            }

            // If no title from frontmatter, extract from first heading
            if (string.IsNullOrEmpty(metadata.Title))
            {
                var titleMatch = Regex.Match(content, @"^#\s+(.+)$", RegexOptions.Multiline);
                if (titleMatch.Success)
                {
                    metadata.Title = titleMatch.Groups[1].Value.Trim();
                }
            }

            // If still no title, use a default
            if (string.IsNullOrEmpty(metadata.Title))
            {
                metadata.Title = "Untitled Article";
            }

            return metadata;
        }

        private int EstimateReadingTime(string content)
        {
            // Remove markdown syntax for more accurate word count
            var plainText = Regex.Replace(content, @"[#*_`\[\]()]", "");
            var wordCount = plainText.Split(new[] { ' ', '\n', '\r', '\t' }, StringSplitOptions.RemoveEmptyEntries).Length;
            var wordsPerMinute = 200; // Average reading speed
            return Math.Max(1, (int)Math.Ceiling(wordCount / (double)wordsPerMinute));
        }
    }
}
