using System.ComponentModel.DataAnnotations;

namespace WanderlustApi.Models;

public class Comment
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    
    [Required]
    public string Content { get; set; } = string.Empty;
    
    [Required]
    public string Author { get; set; } = string.Empty;
    
    public string AuthorId { get; set; } = string.Empty;
    
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    
    public DateTime? UpdatedAt { get; set; }
    
    [Required]
    public int PostId { get; set; }
    
    // For threaded comments/replies
    public string? ParentCommentId { get; set; }
    
    // Metadata
    public int LikesCount { get; set; } = 0;
    public int RepliesCount { get; set; } = 0;
    public bool IsEdited { get; set; } = false;
    public bool IsHidden { get; set; } = false;
    public bool IsDeleted { get; set; } = false;
    
    // Moderation
    public string? ModerationReason { get; set; }
    public string? ModeratedBy { get; set; }
    public DateTime? ModeratedAt { get; set; }
    
    // Content metadata
    public string[]? Mentions { get; set; } // Users mentioned in the comment
    public string[]? Attachments { get; set; } // File attachments
}
