using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CommunityController : ControllerBase
    {
        private readonly WanderlustDbContext _context;

        public CommunityController(WanderlustDbContext context)
        {
            _context = context;
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
        public async Task<ActionResult<CommunityPost>> PostCommunityPost(CommunityPost post)
        {
            post.CreatedAt = DateTime.UtcNow;

            _context.CommunityPosts.Add(post);
            await _context.SaveChangesAsync();

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
        public async Task<IActionResult> DeleteCommunityPost(int id)
        {
            var post = await _context.CommunityPosts.FindAsync(id);
            if (post == null)
            {
                return NotFound();
            }

            _context.CommunityPosts.Remove(post);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CommunityPostExists(int id)
        {
            return _context.CommunityPosts.Any(e => e.Id == id);
        }
    }
}
