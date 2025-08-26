using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.Models;
using WanderlustApi.Services;
using Microsoft.AspNetCore.Authorization;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CommunityController : ControllerBase
    {
        private readonly WanderlustDbContext _context;
        private readonly IRealTimeNotificationService _notificationService;

        public CommunityController(WanderlustDbContext context, IRealTimeNotificationService notificationService)
        {
            _context = context;
            _notificationService = notificationService;
        }

        [HttpGet("posts")]
        public async Task<ActionResult<IEnumerable<CommunityPost>>> GetCommunityPosts()
        {
            return await _context.CommunityPosts
                .OrderByDescending(p => p.CreatedAt)
                .ToListAsync();
        }

        [HttpGet("posts/{id}")]
        public async Task<ActionResult<CommunityPost>> GetCommunityPost(int id)
        {
            var post = await _context.CommunityPosts.FindAsync(id);

            if (post == null)
            {
                return NotFound();
            }

            return post;
        }

        [HttpGet("posts/type/{type}")]
        public async Task<ActionResult<IEnumerable<CommunityPost>>> GetCommunityPostsByType(string type)
        {
            return await _context.CommunityPosts
                .Where(p => p.Type == type)
                .OrderByDescending(p => p.CreatedAt)
                .ToListAsync();
        }

        [HttpPost("posts")]
        [Authorize]
        public async Task<ActionResult<CommunityPost>> PostCommunityPost(CommunityPost post)
        {
            post.CreatedAt = DateTime.UtcNow;

            _context.CommunityPosts.Add(post);
            await _context.SaveChangesAsync();

            // Send real-time notification
            await _notificationService.SendNewPostNotification(post);

            return CreatedAtAction("GetCommunityPost", new { id = post.Id }, post);
        }

        [HttpPut("posts/{id}")]
        public async Task<IActionResult> PutCommunityPost(int id, CommunityPost post)
        {
            if (id != post.Id)
            {
                return BadRequest();
            }

            _context.Entry(post).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CommunityPostExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        [HttpDelete("posts/{id}")]
        [Authorize]
        public async Task<IActionResult> DeleteCommunityPost(int id)
        {
            var post = await _context.CommunityPosts.FindAsync(id);
            if (post == null)
            {
                return NotFound();
            }

            _context.CommunityPosts.Remove(post);
            await _context.SaveChangesAsync();

            // Send real-time notification
            await _notificationService.SendContentUpdateNotification("post", id.ToString(), "deleted");

            return NoContent();
        }

        // Comments endpoints
        [HttpGet("posts/{postId}/comments")]
        public async Task<ActionResult<IEnumerable<Comment>>> GetComments(int postId)
        {
            // Note: You'll need to add a Comments DbSet to your context if not already present
            // For now, returning empty array
            return Ok(new List<Comment>());
        }

        [HttpPost("posts/{postId}/comments")]
        [Authorize]
        public async Task<ActionResult<Comment>> PostComment(int postId, Comment comment)
        {
            comment.CreatedAt = DateTime.UtcNow;
            comment.PostId = postId;

            // Add comment to database (you'll need to implement this)
            // For demo purposes, setting a temporary ID
            comment.Id = Guid.NewGuid().ToString();

            // Send real-time notification
            await _notificationService.SendNewCommentNotification(comment, postId.ToString());

            return CreatedAtAction("GetComment", new { postId = postId, commentId = comment.Id }, comment);
        }

        [HttpGet("posts/{postId}/comments/{commentId}")]
        public async Task<ActionResult<Comment>> GetComment(int postId, string commentId)
        {
            // Implement comment retrieval
            return NotFound();
        }

        // Reactions endpoints
        [HttpPost("posts/{postId}/reactions")]
        [Authorize]
        public async Task<ActionResult<Reaction>> PostReaction(int postId, Reaction reaction)
        {
            reaction.CreatedAt = DateTime.UtcNow;
            reaction.Id = Guid.NewGuid().ToString();

            // Add reaction to database (you'll need to implement this)
            
            // Send real-time notification
            await _notificationService.SendReactionNotification(reaction, postId.ToString());

            return Ok(reaction);
        }

        [HttpPost("posts/{postId}/comments/{commentId}/reactions")]
        [Authorize]
        public async Task<ActionResult<Reaction>> PostCommentReaction(int postId, string commentId, Reaction reaction)
        {
            reaction.CreatedAt = DateTime.UtcNow;
            reaction.Id = Guid.NewGuid().ToString();

            // Add reaction to database (you'll need to implement this)
            
            // Send real-time notification
            await _notificationService.SendReactionNotification(reaction, postId.ToString(), commentId);

            return Ok(reaction);
        }

        // Live user activity
        [HttpGet("activity/live")]
        public async Task<ActionResult> GetLiveActivity()
        {
            // Mock live user count - implement actual logic
            var userCount = 42; // Replace with actual logic
            await _notificationService.SendLiveUserCount(userCount);

            return Ok(new { OnlineUsers = userCount, Timestamp = DateTime.UtcNow });
        }

        private bool CommunityPostExists(int id)
        {
            return _context.CommunityPosts.Any(e => e.Id == id);
        }
    }
}
