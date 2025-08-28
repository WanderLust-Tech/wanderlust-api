using System.ComponentModel.DataAnnotations;

namespace WanderlustApi.Models
{
    /// <summary>
    /// Code example model that matches the database schema for Dapper
    /// </summary>
    public class CodeExampleEntity
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string? Description { get; set; }
        public string Code { get; set; } = string.Empty;
        public string Language { get; set; } = string.Empty;
        public string? Framework { get; set; }
        public string? Tags { get; set; } // JSON string in database
        public string Difficulty { get; set; } = "Beginner";
        public string? Category { get; set; }
        public bool IsPublic { get; set; } = true;
        public int ViewCount { get; set; } = 0;
        public int LikeCount { get; set; } = 0;
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public int AuthorId { get; set; }
        public int? CollectionId { get; set; }
        public string? Dependencies { get; set; } // JSON string in database
        public string? RelatedExamples { get; set; } // JSON string in database
        
        // Navigation property (not mapped to database)
        public string? AuthorName { get; set; }
    }
}
