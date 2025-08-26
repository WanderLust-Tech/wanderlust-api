using System.ComponentModel.DataAnnotations;

namespace WanderlustApi.Models;

public class Reaction
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    
    [Required]
    public string Type { get; set; } = string.Empty; // "like", "love", "laugh", "angry", "sad", etc.
    
    [Required]
    public string Author { get; set; } = string.Empty;
    
    public string AuthorId { get; set; } = string.Empty;
    
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    
    // What is being reacted to
    public int? PostId { get; set; }
    public string? CommentId { get; set; }
    
    // Metadata
    public string? Content { get; set; } // Optional custom reaction content
    public bool IsActive { get; set; } = true; // For undo/redo reactions
}
