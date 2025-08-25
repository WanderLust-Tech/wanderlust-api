using System.ComponentModel.DataAnnotations;

namespace WanderlustApi.Models
{
    public class User
    {
        public int Id { get; set; }
        
        [Required]
        [MaxLength(50)]
        public string Username { get; set; } = string.Empty;
        
        [Required]
        [EmailAddress]
        [MaxLength(100)]
        public string Email { get; set; } = string.Empty;
        
        [Required]
        [MaxLength(100)]
        public string DisplayName { get; set; } = string.Empty;
        
        [Required]
        public string PasswordHash { get; set; } = string.Empty;
        
        public string? Bio { get; set; }
        
        public string? AvatarUrl { get; set; }
        
        public UserRole Role { get; set; } = UserRole.Member;
        
        public bool IsEmailVerified { get; set; } = false;
        
        public bool IsActive { get; set; } = true;
        
        public DateTime CreatedAt { get; set; }
        
        public DateTime LastLoginAt { get; set; }
        
        public string? RefreshToken { get; set; }
        
        public DateTime? RefreshTokenExpiryTime { get; set; }
        
        // Navigation properties
        public List<Article> Articles { get; set; } = new List<Article>();
        public List<CodeExample> CodeExamples { get; set; } = new List<CodeExample>();
        public List<CommunityPost> CommunityPosts { get; set; } = new List<CommunityPost>();
    }

    public enum UserRole
    {
        Member,
        Contributor,
        Moderator,
        Admin
    }
}
