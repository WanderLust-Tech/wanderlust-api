using Dapper;
using Microsoft.Data.SqlClient;
using WanderlustApi.Models;

namespace WanderlustApi.Services
{
    public interface ICommunityService
    {
        Task<CommunityPost?> GetPostByIdAsync(int id);
        Task<IEnumerable<CommunityPost>> GetPostsAsync(string? category = null, int page = 1, int pageSize = 20);
        Task<CommunityPost> CreatePostAsync(CommunityPost post);
        Task<CommunityPost> UpdatePostAsync(CommunityPost post);
        Task<bool> DeletePostAsync(int id);
        Task<IEnumerable<Comment>> GetPostCommentsAsync(int postId);
        Task<Comment> AddCommentAsync(Comment comment);
        Task<IEnumerable<DiscussionCategory>> GetCategoriesAsync();
        Task<DiscussionCategory> CreateCategoryAsync(DiscussionCategory category);
    }

    public class CommunityService : ICommunityService
    {
        private readonly string _connectionString;

        public CommunityService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection")!;
        }

        public async Task<CommunityPost?> GetPostByIdAsync(int id)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT cp.*, u.Username, u.DisplayName, u.AvatarUrl 
                FROM CommunityPosts cp
                LEFT JOIN Users u ON cp.AuthorId = u.Id
                WHERE cp.Id = @Id";

            var result = await connection.QueryAsync<CommunityPost, User, CommunityPost>(
                sql,
                (post, author) =>
                {
                    post.Author = author;
                    return post;
                },
                new { Id = id },
                splitOn: "Username"
            );

            var post = result.FirstOrDefault();
            if (post != null)
            {
                // Update view count
                await connection.ExecuteAsync(
                    "UPDATE CommunityPosts SET ViewCount = ViewCount + 1 WHERE Id = @Id",
                    new { Id = id }
                );
                post.ViewCount++;
            }

            return post;
        }

        public async Task<IEnumerable<CommunityPost>> GetPostsAsync(string? category = null, int page = 1, int pageSize = 20)
        {
            using var connection = new SqlConnection(_connectionString);
            
            var whereClause = string.IsNullOrEmpty(category) ? "WHERE cp.IsApproved = 1" : "WHERE cp.Category = @Category AND cp.IsApproved = 1";
            var sql = $@"
                SELECT cp.*, u.Username, u.DisplayName, u.AvatarUrl 
                FROM CommunityPosts cp
                LEFT JOIN Users u ON cp.AuthorId = u.Id
                {whereClause}
                ORDER BY cp.IsPinned DESC, cp.LastActivity DESC
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            var offset = (page - 1) * pageSize;
            var parameters = new { Category = category, Offset = offset, PageSize = pageSize };

            var result = await connection.QueryAsync<CommunityPost, User, CommunityPost>(
                sql,
                (post, author) =>
                {
                    post.Author = author;
                    return post;
                },
                parameters,
                splitOn: "Username"
            );

            return result;
        }

        public async Task<CommunityPost> CreatePostAsync(CommunityPost post)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                INSERT INTO CommunityPosts (
                    Title, Content, AuthorName, AuthorAvatar, Type, AuthorId, Category, 
                    Tags, CreatedAt, UpdatedAt, LastActivity, IsApproved, IsPinned, IsClosed, IsLocked
                )
                OUTPUT INSERTED.Id
                VALUES (
                    @Title, @Content, @AuthorName, @AuthorAvatar, @Type, @AuthorId, @Category, 
                    @Tags, @CreatedAt, @UpdatedAt, @LastActivity, @IsApproved, @IsPinned, @IsClosed, @IsLocked
                )";

            post.CreatedAt = DateTime.UtcNow;
            post.UpdatedAt = DateTime.UtcNow;
            post.LastActivity = DateTime.UtcNow;

            var id = await connection.QuerySingleAsync<int>(sql, post);
            post.Id = id;

            return post;
        }

        public async Task<CommunityPost> UpdatePostAsync(CommunityPost post)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                UPDATE CommunityPosts SET 
                    Title = @Title,
                    Content = @Content,
                    Category = @Category,
                    Tags = @Tags,
                    UpdatedAt = @UpdatedAt,
                    IsPinned = @IsPinned,
                    IsClosed = @IsClosed,
                    IsLocked = @IsLocked,
                    IsApproved = @IsApproved,
                    IsFlagged = @IsFlagged,
                    ModerationReason = @ModerationReason,
                    ModeratedBy = @ModeratedBy,
                    ModeratedAt = @ModeratedAt
                WHERE Id = @Id";

            post.UpdatedAt = DateTime.UtcNow;
            await connection.ExecuteAsync(sql, post);

            return post;
        }

        public async Task<bool> DeletePostAsync(int id)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = "DELETE FROM CommunityPosts WHERE Id = @Id";

            var affected = await connection.ExecuteAsync(sql, new { Id = id });
            return affected > 0;
        }

        public async Task<IEnumerable<Comment>> GetPostCommentsAsync(int postId)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT c.*, u.Username, u.DisplayName, u.AvatarUrl 
                FROM Comments c
                LEFT JOIN Users u ON CAST(c.AuthorId AS INT) = u.Id
                WHERE c.PostId = @PostId AND c.IsDeleted = 0
                ORDER BY c.CreatedAt ASC";

            var result = await connection.QueryAsync<Comment, User, Comment>(
                sql,
                (comment, author) =>
                {
                    if (author != null)
                    {
                        comment.Author = author.Username;
                    }
                    return comment;
                },
                new { PostId = postId },
                splitOn: "Username"
            );

            return result;
        }

        public async Task<Comment> AddCommentAsync(Comment comment)
        {
            using var connection = new SqlConnection(_connectionString);
            using var transaction = connection.BeginTransaction();

            try
            {
                const string commentSql = @"
                    INSERT INTO Comments (Content, Author, AuthorId, PostId, ParentCommentId, CreatedAt)
                    OUTPUT INSERTED.Id
                    VALUES (@Content, @Author, @AuthorId, @PostId, @ParentCommentId, @CreatedAt)";

                comment.CreatedAt = DateTime.UtcNow;
                var commentId = await connection.QuerySingleAsync<string>(commentSql, comment, transaction);
                comment.Id = commentId;

                // Update post reply count and last activity
                const string updatePostSql = @"
                    UPDATE CommunityPosts SET 
                        ReplyCount = ReplyCount + 1,
                        LastActivity = @LastActivity,
                        LastReplyById = @LastReplyById,
                        LastReplyByName = @LastReplyByName
                    WHERE Id = @PostId";

                await connection.ExecuteAsync(updatePostSql, new
                {
                    LastActivity = DateTime.UtcNow,
                    LastReplyById = int.TryParse(comment.AuthorId, out var authorId) ? authorId : (int?)null,
                    LastReplyByName = comment.Author,
                    PostId = comment.PostId
                }, transaction);

                transaction.Commit();
                return comment;
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
        }

        public async Task<IEnumerable<DiscussionCategory>> GetCategoriesAsync()
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                SELECT * FROM DiscussionCategories 
                ORDER BY 
                    CASE WHEN ParentId IS NULL THEN 0 ELSE 1 END,
                    Name";

            return await connection.QueryAsync<DiscussionCategory>(sql);
        }

        public async Task<DiscussionCategory> CreateCategoryAsync(DiscussionCategory category)
        {
            using var connection = new SqlConnection(_connectionString);
            const string sql = @"
                INSERT INTO DiscussionCategories (Name, Description, Color, Icon, ParentId, Moderators, IsPrivate, RequireApproval)
                OUTPUT INSERTED.Id
                VALUES (@Name, @Description, @Color, @Icon, @ParentId, @Moderators, @IsPrivate, @RequireApproval)";

            var id = await connection.QuerySingleAsync<string>(sql, category);
            category.Id = id;

            return category;
        }
    }
}
