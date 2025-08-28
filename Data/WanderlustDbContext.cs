using Microsoft.EntityFrameworkCore;
using WanderlustApi.Models;
using System.Text.Json;

namespace WanderlustApi.Data
{
    public class WanderlustDbContext : DbContext
    {
        public WanderlustDbContext(DbContextOptions<WanderlustDbContext> options) : base(options)
        {
        }

        public DbSet<CodeExample> CodeExamples { get; set; }
        public DbSet<Article> Articles { get; set; }
        public DbSet<Collection> Collections { get; set; }
        public DbSet<CommunityPost> CommunityPosts { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Reaction> Reactions { get; set; }
        public DbSet<UserBadge> UserBadges { get; set; }
        public DbSet<UserPreferences> UserPreferences { get; set; }
        public DbSet<DiscussionCategory> DiscussionCategories { get; set; }
        
        // CMS Models
        public DbSet<MediaItem> MediaItems { get; set; }
        public DbSet<ContentWorkflow> ContentWorkflows { get; set; }
        public DbSet<ContentTemplate> ContentTemplates { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure CodeExample
            modelBuilder.Entity<CodeExample>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.Title).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Description).IsRequired().HasMaxLength(500);
                entity.Property(e => e.LongDescription).HasMaxLength(2000);
                entity.Property(e => e.Code).IsRequired().HasColumnType("LONGTEXT");
                entity.Property(e => e.Author).HasMaxLength(100);
                entity.Property(e => e.Source).HasMaxLength(500);
                entity.Property(e => e.License).HasMaxLength(100);
                entity.Property(e => e.Subcategory).HasMaxLength(100);
                entity.Property(e => e.SetupInstructions).HasColumnType("TEXT");
                entity.Property(e => e.ExpectedOutput).HasColumnType("TEXT");

                // Configure enum properties
                entity.Property(e => e.Language).HasConversion<string>();
                entity.Property(e => e.Category).HasConversion<string>();
                entity.Property(e => e.Difficulty).HasConversion<string>();
                entity.Property(e => e.Environment).HasConversion<string>();

                // Configure list properties as JSON
                entity.Property(e => e.Tags)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.Dependencies)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.RelatedArticles)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.RelatedExamples)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.LearningObjectives)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.Prerequisites)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.Property(e => e.Comments)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.Property(e => e.Bookmarks)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                // Configure complex object properties as JSON
                entity.Property(e => e.Ratings)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<CodeExampleRatings>(v, (JsonSerializerOptions?)null) ?? new CodeExampleRatings())
                    .HasColumnType("JSON");

                entity.Property(e => e.Usage)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<CodeExampleUsageStats>(v, (JsonSerializerOptions?)null) ?? new CodeExampleUsageStats())
                    .HasColumnType("JSON");

                // Indexes for performance
                entity.HasIndex(e => e.Language);
                entity.HasIndex(e => e.Category);
                entity.HasIndex(e => e.Difficulty);
                entity.HasIndex(e => e.DateCreated);
                entity.HasIndex(e => e.Author);
            });

            // Configure Article
            modelBuilder.Entity<Article>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Title).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Content).IsRequired().HasColumnType("LONGTEXT");
                entity.Property(e => e.Category).IsRequired().HasMaxLength(100);
                entity.Property(e => e.Path).IsRequired().HasMaxLength(500);
                entity.Property(e => e.Description).HasMaxLength(1000);
                entity.Property(e => e.Author).HasMaxLength(100);
                entity.Property(e => e.MetaDescription).HasMaxLength(500);
                entity.Property(e => e.MetaKeywords).HasMaxLength(500);
                entity.Property(e => e.FeaturedImage).HasMaxLength(500);
                entity.Property(e => e.Version).HasMaxLength(20);

                // Configure Tags as JSON
                entity.Property(e => e.Tags)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                // Foreign key relationship
                entity.HasOne(e => e.AuthorUser)
                    .WithMany(u => u.Articles)
                    .HasForeignKey(e => e.AuthorId)
                    .OnDelete(DeleteBehavior.SetNull);

                // Indexes
                entity.HasIndex(e => e.Category);
                entity.HasIndex(e => e.Path);
                entity.HasIndex(e => e.CreatedAt);
                entity.HasIndex(e => e.IsPublished);
                entity.HasIndex(e => e.AuthorId);
            });

            // Configure Collection
            modelBuilder.Entity<Collection>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Description).IsRequired().HasColumnType("TEXT");

                // Indexes
                entity.HasIndex(e => e.CreatedAt);
                entity.HasIndex(e => e.Name);
            });

            // Configure CommunityPost
            modelBuilder.Entity<CommunityPost>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Title).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Content).IsRequired().HasColumnType("LONGTEXT");
                entity.Property(e => e.AuthorName).IsRequired().HasMaxLength(100);
                entity.Property(e => e.AuthorAvatar).HasMaxLength(500);
                entity.Property(e => e.Type).IsRequired().HasMaxLength(50);
                entity.Property(e => e.Category).HasMaxLength(100);
                entity.Property(e => e.LastReplyByName).HasMaxLength(100);
                entity.Property(e => e.ModerationReason).HasMaxLength(500);
                entity.Property(e => e.ModeratedBy).HasMaxLength(100);

                // Configure list properties as JSON
                entity.Property(e => e.Tags)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.RelatedArticles)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.Attachments)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.Property(e => e.Subscribers)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                // Foreign key relationships
                entity.HasOne(e => e.Author)
                    .WithMany(u => u.CommunityPosts)
                    .HasForeignKey(e => e.AuthorId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.LastReplyBy)
                    .WithMany()
                    .HasForeignKey(e => e.LastReplyById)
                    .OnDelete(DeleteBehavior.SetNull);

                // Indexes
                entity.HasIndex(e => e.Type);
                entity.HasIndex(e => e.CreatedAt);
                entity.HasIndex(e => e.AuthorName);
                entity.HasIndex(e => e.AuthorId);
                entity.HasIndex(e => e.Category);
                entity.HasIndex(e => e.IsPinned);
                entity.HasIndex(e => e.LastActivity);
            });

            // Configure User
            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Username).IsRequired().HasMaxLength(50);
                entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
                entity.Property(e => e.DisplayName).IsRequired().HasMaxLength(100);
                entity.Property(e => e.PasswordHash).IsRequired();
                entity.Property(e => e.Bio).HasMaxLength(500);
                entity.Property(e => e.AvatarUrl).HasMaxLength(500);
                entity.Property(e => e.Role).HasConversion<string>();

                // Configure complex object properties as JSON
                entity.Property(e => e.Badges)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<UserBadge>>(v, (JsonSerializerOptions?)null) ?? new List<UserBadge>())
                    .HasColumnType("JSON");

                entity.Property(e => e.Preferences)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<UserPreferences>(v, (JsonSerializerOptions?)null) ?? new UserPreferences())
                    .HasColumnType("JSON");

                // Indexes
                entity.HasIndex(e => e.Username).IsUnique();
                entity.HasIndex(e => e.Email).IsUnique();
                entity.HasIndex(e => e.CreatedAt);
                entity.HasIndex(e => e.Role);
                entity.HasIndex(e => e.IsActive);
                entity.HasIndex(e => e.Reputation);
            });

            // Configure Comment
            modelBuilder.Entity<Comment>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.Content).IsRequired().HasColumnType("TEXT");
                entity.Property(e => e.Author).IsRequired().HasMaxLength(100);
                entity.Property(e => e.AuthorId).HasMaxLength(50);
                entity.Property(e => e.ParentCommentId).HasMaxLength(50);
                entity.Property(e => e.ModerationReason).HasMaxLength(500);
                entity.Property(e => e.ModeratedBy).HasMaxLength(100);

                // Convert arrays to JSON
                entity.Property(e => e.Mentions)
                    .HasConversion(
                        v => v == null ? null : JsonSerializer.Serialize(v, new JsonSerializerOptions()),
                        v => v == null ? null : JsonSerializer.Deserialize<string[]>(v, new JsonSerializerOptions()));

                entity.Property(e => e.Attachments)
                    .HasConversion(
                        v => v == null ? null : JsonSerializer.Serialize(v, new JsonSerializerOptions()),
                        v => v == null ? null : JsonSerializer.Deserialize<string[]>(v, new JsonSerializerOptions()));

                // Indexes
                entity.HasIndex(e => e.PostId);
                entity.HasIndex(e => e.AuthorId);
                entity.HasIndex(e => e.CreatedAt);
                entity.HasIndex(e => e.ParentCommentId);
                entity.HasIndex(e => e.IsDeleted);
            });

            // Configure Reaction
            modelBuilder.Entity<Reaction>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.Type).IsRequired().HasMaxLength(20);
                entity.Property(e => e.Author).IsRequired().HasMaxLength(100);
                entity.Property(e => e.AuthorId).HasMaxLength(50);
                entity.Property(e => e.CommentId).HasMaxLength(50);
                entity.Property(e => e.Content).HasMaxLength(200);

                // Indexes
                entity.HasIndex(e => e.PostId);
                entity.HasIndex(e => e.CommentId);
                entity.HasIndex(e => e.AuthorId);
                entity.HasIndex(e => e.Type);
                entity.HasIndex(e => e.CreatedAt);
                entity.HasIndex(e => e.IsActive);

                                // Unique constraint to prevent duplicate reactions
                entity.HasIndex(e => new { e.AuthorId, e.PostId, e.CommentId, e.Type }).IsUnique();
            });

            // Configure MediaItem
            modelBuilder.Entity<MediaItem>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.FileName).IsRequired().HasMaxLength(255);
                entity.Property(e => e.OriginalName).IsRequired().HasMaxLength(255);
                entity.Property(e => e.MimeType).IsRequired().HasMaxLength(100);
                entity.Property(e => e.Url).IsRequired().HasMaxLength(500);
                entity.Property(e => e.Alt).HasMaxLength(200);
                entity.Property(e => e.Description).HasMaxLength(1000);
                entity.Property(e => e.UploadedBy).IsRequired().HasMaxLength(100);

                entity.Property(e => e.Tags)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.Property(e => e.Metadata)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<Dictionary<string, object>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.HasIndex(e => e.UploadedBy);
                entity.HasIndex(e => e.MimeType);
                entity.HasIndex(e => e.UploadedAt);
            });

            // Configure ContentWorkflow
            modelBuilder.Entity<ContentWorkflow>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.ContentId).IsRequired().HasMaxLength(50);
                entity.Property(e => e.ContentType).IsRequired().HasMaxLength(50);
                entity.Property(e => e.Status).IsRequired().HasMaxLength(50);
                entity.Property(e => e.AssignedTo).HasMaxLength(100);
                entity.Property(e => e.ReviewedBy).HasMaxLength(100);
                entity.Property(e => e.ReviewComments).HasMaxLength(2000);

                entity.Property(e => e.Steps)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<WorkflowStep>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.HasIndex(e => e.ContentId);
                entity.HasIndex(e => e.Status);
                entity.HasIndex(e => e.AssignedTo);
                entity.HasIndex(e => e.CreatedAt);
            });

            // Configure ContentTemplate
            modelBuilder.Entity<ContentTemplate>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(200);
                entity.Property(e => e.Description).HasMaxLength(1000);
                entity.Property(e => e.ContentType).IsRequired().HasMaxLength(50);
                entity.Property(e => e.Template).IsRequired().HasColumnType("LONGTEXT");
                entity.Property(e => e.CreatedBy).IsRequired().HasMaxLength(100);

                entity.Property(e => e.DefaultValues)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<Dictionary<string, object>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.Property(e => e.Fields)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<TemplateField>>(v, (JsonSerializerOptions?)null))
                    .HasColumnType("JSON");

                entity.HasIndex(e => e.ContentType);
                entity.HasIndex(e => e.CreatedBy);
                entity.HasIndex(e => e.IsActive);
            });

            // Configure UserBadge
            modelBuilder.Entity<UserBadge>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(100);
                entity.Property(e => e.Description).HasMaxLength(500);
                entity.Property(e => e.Icon).HasMaxLength(100);
                entity.Property(e => e.Color).HasMaxLength(20);
                entity.Property(e => e.Category).HasConversion<string>();

                entity.HasOne(e => e.User)
                    .WithMany(u => u.Badges)
                    .HasForeignKey(e => e.UserId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasIndex(e => e.UserId);
                entity.HasIndex(e => e.Category);
                entity.HasIndex(e => e.EarnedDate);
            });

            // Configure UserPreferences
            modelBuilder.Entity<UserPreferences>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.ThemePreference).HasMaxLength(20);
                entity.Property(e => e.Language).HasMaxLength(10);
                entity.Property(e => e.Timezone).HasMaxLength(50);
                entity.Property(e => e.DiscussionSort).HasMaxLength(20);

                entity.HasOne(e => e.User)
                    .WithOne(u => u.Preferences)
                    .HasForeignKey<UserPreferences>(e => e.UserId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasIndex(e => e.UserId).IsUnique();
            });

            // Configure DiscussionCategory
            modelBuilder.Entity<DiscussionCategory>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasMaxLength(50);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(100);
                entity.Property(e => e.Description).HasMaxLength(500);
                entity.Property(e => e.Color).HasMaxLength(20);
                entity.Property(e => e.Icon).HasMaxLength(50);
                entity.Property(e => e.ParentId).HasMaxLength(50);

                entity.Property(e => e.Moderators)
                    .HasConversion(
                        v => JsonSerializer.Serialize(v, (JsonSerializerOptions?)null),
                        v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>())
                    .HasColumnType("JSON");

                entity.HasOne(e => e.Parent)
                    .WithMany(c => c.Children)
                    .HasForeignKey(e => e.ParentId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasIndex(e => e.ParentId);
                entity.HasIndex(e => e.Name);
            });

        }
    }
}

