using Microsoft.AspNetCore.SignalR;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace WanderlustApi.Hubs;

[Authorize]
public class CommunityHub : Hub
{
    private readonly ILogger<CommunityHub> _logger;

    public CommunityHub(ILogger<CommunityHub> logger)
    {
        _logger = logger;
    }

    public override async Task OnConnectedAsync()
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;
        
        _logger.LogInformation("User {Username} ({UserId}) connected to CommunityHub with connection {ConnectionId}", 
            username, userId, Context.ConnectionId);

        // Join user to their personal group for notifications
        if (!string.IsNullOrEmpty(userId))
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, $"user_{userId}");
        }

        // Notify all users that someone joined (optional)
        await Clients.Others.SendAsync("UserConnected", new
        {
            Username = username,
            UserId = userId,
            ConnectedAt = DateTime.UtcNow
        });

        await base.OnConnectedAsync();
    }

    public override async Task OnDisconnectedAsync(Exception? exception)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        _logger.LogInformation("User {Username} ({UserId}) disconnected from CommunityHub with connection {ConnectionId}", 
            username, userId, Context.ConnectionId);

        // Remove user from their personal group
        if (!string.IsNullOrEmpty(userId))
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"user_{userId}");
        }

        // Notify all users that someone left (optional)
        await Clients.Others.SendAsync("UserDisconnected", new
        {
            Username = username,
            UserId = userId,
            DisconnectedAt = DateTime.UtcNow
        });

        await base.OnDisconnectedAsync(exception);
    }

    // Join a specific discussion/post group
    public async Task JoinPostGroup(string postId)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        await Groups.AddToGroupAsync(Context.ConnectionId, $"post_{postId}");
        
        _logger.LogInformation("User {Username} joined post group {PostId}", username, postId);

        // Notify others in the group
        await Clients.OthersInGroup($"post_{postId}").SendAsync("UserJoinedPost", new
        {
            Username = username,
            UserId = userId,
            PostId = postId,
            JoinedAt = DateTime.UtcNow
        });
    }

    // Leave a specific discussion/post group
    public async Task LeavePostGroup(string postId)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"post_{postId}");
        
        _logger.LogInformation("User {Username} left post group {PostId}", username, postId);

        // Notify others in the group
        await Clients.OthersInGroup($"post_{postId}").SendAsync("UserLeftPost", new
        {
            Username = username,
            UserId = userId,
            PostId = postId,
            LeftAt = DateTime.UtcNow
        });
    }

    // Join a category group
    public async Task JoinCategoryGroup(string category)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        await Groups.AddToGroupAsync(Context.ConnectionId, $"category_{category}");
        
        _logger.LogInformation("User {Username} joined category group {Category}", username, category);
    }

    // Leave a category group
    public async Task LeaveCategoryGroup(string category)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"category_{category}");
        
        _logger.LogInformation("User {Username} left category group {Category}", username, category);
    }

    // Send typing indicator
    public async Task SendTypingIndicator(string postId, bool isTyping)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        await Clients.OthersInGroup($"post_{postId}").SendAsync("TypingIndicator", new
        {
            Username = username,
            UserId = userId,
            PostId = postId,
            IsTyping = isTyping,
            Timestamp = DateTime.UtcNow
        });
    }

    // Send user activity status
    public async Task UpdateUserStatus(string status, string? activity = null)
    {
        var userId = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var username = Context.User?.FindFirst(ClaimTypes.Name)?.Value;

        await Clients.All.SendAsync("UserStatusUpdate", new
        {
            Username = username,
            UserId = userId,
            Status = status, // "online", "away", "busy", "offline"
            Activity = activity, // "Reading article: ...", "Writing comment", etc.
            UpdatedAt = DateTime.UtcNow
        });
    }
}
