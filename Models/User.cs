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
        
        // Additional properties to match frontend
        public int Reputation { get; set; } = 0;
        
        public List<UserBadge> Badges { get; set; } = new List<UserBadge>();
        
        public UserPreferences Preferences { get; set; } = new UserPreferences();
        
        // Navigation properties
        public List<Article> Articles { get; set; } = new List<Article>();
        public List<CodeExample> CodeExamples { get; set; } = new List<CodeExample>();
        public List<CommunityPost> CommunityPosts { get; set; } = new List<CommunityPost>();
    }

    public class UserBadge
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        
        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;
        
        [MaxLength(500)]
        public string Description { get; set; } = string.Empty;
        
        [MaxLength(100)]
        public string Icon { get; set; } = string.Empty;
        
        [MaxLength(20)]
        public string Color { get; set; } = string.Empty;
        
        public DateTime EarnedDate { get; set; }
        
        public BadgeCategory Category { get; set; }
        
        // Foreign key
        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }

    public class UserPreferences
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        
        public bool EmailNotifications { get; set; } = true;
        public bool PushNotifications { get; set; } = true;
        public string ThemePreference { get; set; } = "system"; // light, dark, system
        public string Language { get; set; } = "en";
        public string Timezone { get; set; } = "UTC";
        public string DiscussionSort { get; set; } = "newest"; // newest, oldest, popular, relevance
        public bool AutoSubscribe { get; set; } = false;
        
        // Foreign key
        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }

    public enum UserRole
    {
        Member,
        Contributor,
        Moderator,
        Admin
    }

    public enum BadgeCategory
    {
        Contribution,
        Learning,
        Community,
        Achievement
    }
}
