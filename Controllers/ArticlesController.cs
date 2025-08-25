using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ArticlesController : ControllerBase
    {
        private readonly WanderlustDbContext _context;

        public ArticlesController(WanderlustDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticles()
        {
            return await _context.Articles.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Article>> GetArticle(int id)
        {
            var article = await _context.Articles.FindAsync(id);

            if (article == null)
            {
                return NotFound();
            }

            return article;
        }

        [HttpGet("by-path/{*path}")]
        public async Task<ActionResult<Article>> GetArticleByPath(string path)
        {
            var article = await _context.Articles
                .FirstOrDefaultAsync(a => a.Path == path);

            if (article == null)
            {
                return NotFound();
            }

            return article;
        }

        [HttpGet("category/{category}")]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticlesByCategory(string category)
        {
            return await _context.Articles
                .Where(a => a.Category == category && a.IsPublished)
                .OrderByDescending(a => a.UpdatedAt)
                .ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Article>> PostArticle(Article article)
        {
            article.CreatedAt = DateTime.UtcNow;
            article.UpdatedAt = DateTime.UtcNow;

            _context.Articles.Add(article);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetArticle", new { id = article.Id }, article);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutArticle(int id, Article article)
        {
            if (id != article.Id)
            {
                return BadRequest();
            }

            article.UpdatedAt = DateTime.UtcNow;
            _context.Entry(article).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ArticleExists(id))
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

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteArticle(int id)
        {
            var article = await _context.Articles.FindAsync(id);
            if (article == null)
            {
                return NotFound();
            }

            _context.Articles.Remove(article);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ArticleExists(int id)
        {
            return _context.Articles.Any(e => e.Id == id);
        }
    }
}
