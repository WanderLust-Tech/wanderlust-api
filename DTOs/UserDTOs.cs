using WanderlustApi.Models;

namespace WanderlustApi.DTOs
{
    public class UserDto
    {
        public int Id { get; set; }
        public string Username { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string DisplayName { get; set; } = string.Empty;
        public string? Bio { get; set; }
        public string? AvatarUrl { get; set; }
        public UserRole Role { get; set; }
        public bool IsEmailVerified { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime LastLoginAt { get; set; }
    }

    public class UpdateProfileRequest
    {
        [System.ComponentModel.DataAnnotations.MaxLength(100)]
        public string? DisplayName { get; set; }
        
        [System.ComponentModel.DataAnnotations.MaxLength(500)]
        public string? Bio { get; set; }
        
        [System.ComponentModel.DataAnnotations.Url]
        public string? AvatarUrl { get; set; }
    }

    public class UserStatsDto
    {
        public int ArticlesCreated { get; set; }
        public int CodeExamplesCreated { get; set; }
        public int CommunityPostsCreated { get; set; }
        public int TotalContributions { get; set; }
        public DateTime JoinedAt { get; set; }
        public DateTime LastActiveAt { get; set; }
    }
}
