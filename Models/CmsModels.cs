// CMS Models for the Wanderlust Platform Content Management System

namespace WanderlustApi.Models;

public class ContentItem
{
    public string Id { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty; // "article", "code-example", "collection"
    public string Status { get; set; } = string.Empty; // "published", "draft", "archived"
    public string Author { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public string Path { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public List<string> Tags { get; set; } = new();
}

public class ContentDetails
{
    public string Id { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public string Author { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public string Path { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public List<string> Tags { get; set; } = new();
    public Dictionary<string, object> Metadata { get; set; } = new();
}

public class CreateContentRequest
{
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public List<string> Tags { get; set; } = new();
    public Dictionary<string, object>? Metadata { get; set; }
}

public class UpdateContentRequest
{
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public List<string> Tags { get; set; } = new();
    public Dictionary<string, object>? Metadata { get; set; }
}

public class BulkOperationRequest
{
    public List<string> ContentIds { get; set; } = new();
    public string Operation { get; set; } = string.Empty; // "publish", "unpublish", "delete", "archive"
}

public class ContentAnalytics
{
    public int TotalArticles { get; set; }
    public int PublishedArticles { get; set; }
    public int DraftArticles { get; set; }
    public int TotalCodeExamples { get; set; }
    public int RecentUpdates { get; set; }
    public List<CategoryStats> TopCategories { get; set; } = new();
    public DateTime LastUpdated { get; set; }
}

public class CategoryStats
{
    public string Category { get; set; } = string.Empty;
    public int Count { get; set; }
    public int Published { get; set; }
    public int Drafts { get; set; }
}

// Media Management Models
public class MediaItem
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string FileName { get; set; } = string.Empty;
    public string OriginalName { get; set; } = string.Empty;
    public string MimeType { get; set; } = string.Empty;
    public long Size { get; set; }
    public string Url { get; set; } = string.Empty;
    public string? Alt { get; set; }
    public string? Description { get; set; }
    public string UploadedBy { get; set; } = string.Empty;
    public DateTime UploadedAt { get; set; } = DateTime.UtcNow;
    public List<string> Tags { get; set; } = new();
    public Dictionary<string, object> Metadata { get; set; } = new();
}

public class UploadMediaRequest
{
    public IFormFile File { get; set; } = null!;
    public string? Alt { get; set; }
    public string? Description { get; set; }
    public List<string> Tags { get; set; } = new();
}

// Workflow and Publishing Models
public class ContentWorkflow
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string ContentId { get; set; } = string.Empty;
    public string ContentType { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty; // "draft", "review", "approved", "published", "archived"
    public string? AssignedTo { get; set; }
    public string? ReviewedBy { get; set; }
    public DateTime? ReviewedAt { get; set; }
    public string? ReviewComments { get; set; }
    public List<WorkflowStep> Steps { get; set; } = new();
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}

public class WorkflowStep
{
    public string Action { get; set; } = string.Empty; // "created", "submitted", "reviewed", "approved", "published", "rejected"
    public string PerformedBy { get; set; } = string.Empty;
    public DateTime PerformedAt { get; set; } = DateTime.UtcNow;
    public string? Comments { get; set; }
}

// Content Templates
public class ContentTemplate
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string ContentType { get; set; } = string.Empty; // "article", "code-example", "tutorial"
    public string Template { get; set; } = string.Empty; // The actual template content
    public Dictionary<string, object> DefaultValues { get; set; } = new();
    public List<TemplateField> Fields { get; set; } = new();
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public bool IsActive { get; set; } = true;
}

public class TemplateField
{
    public string Name { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty; // "text", "textarea", "select", "multiselect", "date", "boolean"
    public string Label { get; set; } = string.Empty;
    public bool Required { get; set; }
    public string? DefaultValue { get; set; }
    public List<string> Options { get; set; } = new(); // For select fields
    public Dictionary<string, object> Validation { get; set; } = new();
}
