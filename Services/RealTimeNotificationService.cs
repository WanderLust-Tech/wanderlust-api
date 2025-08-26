using Microsoft.AspNetCore.SignalR;
using WanderlustApi.Hubs;
using WanderlustApi.Models;

namespace WanderlustApi.Services;

public interface IRealTimeNotificationService
{
    Task SendNewPostNotification(CommunityPost post);
    Task SendNewCommentNotification(Comment comment, string postId);
    Task SendReactionNotification(Reaction reaction, string postId, string? commentId = null);
    Task SendUserMentionNotification(string mentionedUserId, string postId, string content);
    Task SendModeratorActionNotification(string action, string targetId, string reason);
    Task SendSystemNotification(string message, string? targetUserId = null);
    Task SendLiveUserCount(int count);
    Task SendContentUpdateNotification(string contentType, string contentId, string action);
}

public class RealTimeNotificationService : IRealTimeNotificationService
{
    private readonly IHubContext<CommunityHub> _hubContext;
    private readonly ILogger<RealTimeNotificationService> _logger;

    public RealTimeNotificationService(
        IHubContext<CommunityHub> hubContext,
        ILogger<RealTimeNotificationService> logger)
    {
        _hubContext = hubContext;
        _logger = logger;
    }

    public async Task SendNewPostNotification(CommunityPost post)
    {
        try
        {
            var notification = new
            {
                Type = "new_post",
                PostId = post.Id,
                Title = post.Title,
                Author = post.AuthorName,
                Category = post.Type, // Using Type as Category for now
                CreatedAt = post.CreatedAt,
                Excerpt = post.Content?.Length > 100 ? post.Content[..100] + "..." : post.Content,
                Tags = new string[] { post.Type } // Using Type as a tag for now
            };

            // Send to all users
            await _hubContext.Clients.All.SendAsync("NewPost", notification);

            // Send to category-specific groups
            if (!string.IsNullOrEmpty(post.Type))
            {
                await _hubContext.Clients.Group($"category_{post.Type}")
                    .SendAsync("NewPostInCategory", notification);
            }

            _logger.LogInformation("Sent new post notification for post {PostId} by {Author}", 
                post.Id, post.AuthorName);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send new post notification for post {PostId}", post.Id);
        }
    }

    public async Task SendNewCommentNotification(Comment comment, string postId)
    {
        try
        {
            var notification = new
            {
                Type = "new_comment",
                CommentId = comment.Id,
                PostId = postId,
                Author = comment.Author,
                Content = comment.Content?.Length > 100 ? comment.Content[..100] + "..." : comment.Content,
                CreatedAt = comment.CreatedAt,
                ParentCommentId = comment.ParentCommentId
            };

            // Send to post group
            await _hubContext.Clients.Group($"post_{postId}")
                .SendAsync("NewComment", notification);

            // Send to all users (for global activity feed)
            await _hubContext.Clients.All.SendAsync("NewActivity", notification);

            _logger.LogInformation("Sent new comment notification for comment {CommentId} on post {PostId}", 
                comment.Id, postId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send new comment notification for comment {CommentId}", comment.Id);
        }
    }

    public async Task SendReactionNotification(Reaction reaction, string postId, string? commentId = null)
    {
        try
        {
            var notification = new
            {
                Type = "new_reaction",
                ReactionId = reaction.Id,
                PostId = postId,
                CommentId = commentId,
                Author = reaction.Author,
                ReactionType = reaction.Type,
                CreatedAt = reaction.CreatedAt
            };

            // Send to post group
            await _hubContext.Clients.Group($"post_{postId}")
                .SendAsync("NewReaction", notification);

            _logger.LogInformation("Sent reaction notification for {ReactionType} by {Author} on {Target}", 
                reaction.Type, reaction.Author, commentId != null ? $"comment {commentId}" : $"post {postId}");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send reaction notification for reaction {ReactionId}", reaction.Id);
        }
    }

    public async Task SendUserMentionNotification(string mentionedUserId, string postId, string content)
    {
        try
        {
            var notification = new
            {
                Type = "user_mention",
                PostId = postId,
                Content = content?.Length > 100 ? content[..100] + "..." : content,
                MentionedAt = DateTime.UtcNow
            };

            // Send to specific user
            await _hubContext.Clients.Group($"user_{mentionedUserId}")
                .SendAsync("UserMention", notification);

            _logger.LogInformation("Sent mention notification to user {UserId} for post {PostId}", 
                mentionedUserId, postId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send mention notification to user {UserId}", mentionedUserId);
        }
    }

    public async Task SendModeratorActionNotification(string action, string targetId, string reason)
    {
        try
        {
            var notification = new
            {
                Type = "moderator_action",
                Action = action, // "post_hidden", "comment_removed", "user_warned", etc.
                TargetId = targetId,
                Reason = reason,
                Timestamp = DateTime.UtcNow
            };

            // Send to all moderators/admins (you might want to implement role-based groups)
            await _hubContext.Clients.All.SendAsync("ModeratorAction", notification);

            _logger.LogInformation("Sent moderator action notification: {Action} on {TargetId}", 
                action, targetId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send moderator action notification for {Action}", action);
        }
    }

    public async Task SendSystemNotification(string message, string? targetUserId = null)
    {
        try
        {
            var notification = new
            {
                Type = "system_notification",
                Message = message,
                Timestamp = DateTime.UtcNow
            };

            if (!string.IsNullOrEmpty(targetUserId))
            {
                // Send to specific user
                await _hubContext.Clients.Group($"user_{targetUserId}")
                    .SendAsync("SystemNotification", notification);
            }
            else
            {
                // Send to all users
                await _hubContext.Clients.All.SendAsync("SystemNotification", notification);
            }

            _logger.LogInformation("Sent system notification: {Message} to {Target}", 
                message, targetUserId ?? "all users");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send system notification: {Message}", message);
        }
    }

    public async Task SendLiveUserCount(int count)
    {
        try
        {
            await _hubContext.Clients.All.SendAsync("LiveUserCount", new
            {
                Count = count,
                UpdatedAt = DateTime.UtcNow
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send live user count: {Count}", count);
        }
    }

    public async Task SendContentUpdateNotification(string contentType, string contentId, string action)
    {
        try
        {
            var notification = new
            {
                Type = "content_update",
                ContentType = contentType, // "post", "comment", "article", etc.
                ContentId = contentId,
                Action = action, // "created", "updated", "deleted", "published", etc.
                Timestamp = DateTime.UtcNow
            };

            await _hubContext.Clients.All.SendAsync("ContentUpdate", notification);

            _logger.LogInformation("Sent content update notification: {ContentType} {ContentId} {Action}", 
                contentType, contentId, action);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send content update notification for {ContentType} {ContentId}", 
                contentType, contentId);
        }
    }
}

// Extension class for easier usage in controllers
public static class RealTimeNotificationExtensions
{
    public static async Task NotifyNewPost(this IRealTimeNotificationService service, CommunityPost post)
    {
        await service.SendNewPostNotification(post);
    }

    public static async Task NotifyNewComment(this IRealTimeNotificationService service, Comment comment, string postId)
    {
        await service.SendNewCommentNotification(comment, postId);
    }

    public static async Task NotifyReaction(this IRealTimeNotificationService service, Reaction reaction, string postId, string? commentId = null)
    {
        await service.SendReactionNotification(reaction, postId, commentId);
    }
}
