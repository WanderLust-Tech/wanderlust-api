using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Models;
using WanderlustApi.Data.Repositories;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CmsController : ControllerBase
    {

        private readonly ILogger<CmsController> _logger;
        private readonly IArticleRepository _articleRepository;

        public CmsController(ILogger<CmsController> logger, IArticleRepository articleRepository)
        {
            _logger = logger;
            _articleRepository = articleRepository;
        }


        [HttpGet("articles")]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticles()
        {
            try
            {
                var articles = await _articleRepository.GetAllAsync();
                return Ok(articles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve articles from database");
                return StatusCode(500, "Failed to retrieve articles from database");
            }
        }
        
        [HttpGet("collections")]
        public ActionResult<IEnumerable<Collection>> GetCollections()
        {
            // TODO: Implement with repositories when needed
            return Ok(new List<Collection>());
        }

        [HttpGet("articles_by_title")]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticlesByTitle(string title)
        {
            try
            {
                var articles = await _articleRepository.GetByTitleAsync(title);
                return Ok(articles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve articles by title from database");
                return StatusCode(500, "Failed to retrieve articles by title from database");
            }
        }

        [HttpGet("articles_by_category")]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticlesByCategory(string category)
        {
            try
            {
                var articles = await _articleRepository.GetByCategoryAsync(category);
                return Ok(articles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve articles by category from database");
                return StatusCode(500, "Failed to retrieve articles by category from database");
            }
        }

        [HttpGet("categories")]
        public async Task<ActionResult<IEnumerable<string>>> GetCategories()
        {
            try
            {
                var categories = await _articleRepository.GetCategoriesAsync();
                return Ok(categories);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve categories from database");
                return StatusCode(500, "Failed to retrieve categories from database");
            }
        }

        [HttpGet("articles/{id}")]
        public async Task<ActionResult<Article>> GetArticleById(int id)
        {
            try
            {
                var article = await _articleRepository.GetByIdAsync(id);
                if (article == null)
                {
                    return NotFound($"Article with ID {id} not found");
                }
                
                // Increment view count
                await _articleRepository.IncrementViewCountAsync(id);
                
                return Ok(article);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve article by ID {ArticleId}", id);
                return StatusCode(500, "Failed to retrieve article");
            }
        }

        [HttpGet("articles/path/{*path}")]
        public async Task<ActionResult<Article>> GetArticleByPath(string path)
        {
            try
            {
                var article = await _articleRepository.GetByPathAsync(path);
                if (article == null)
                {
                    return NotFound($"Article with path '{path}' not found");
                }
                
                // Increment view count
                await _articleRepository.IncrementViewCountAsync(article.Id);
                
                return Ok(article);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve article by path {Path}", path);
                return StatusCode(500, "Failed to retrieve article");
            }
        }

        [HttpGet("articles/featured")]
        public async Task<ActionResult<IEnumerable<Article>>> GetFeaturedArticles()
        {
            try
            {
                var articles = await _articleRepository.GetFeaturedArticlesAsync();
                return Ok(articles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve featured articles");
                return StatusCode(500, "Failed to retrieve featured articles");
            }
        }

        [HttpGet("articles/recent")]
        public async Task<ActionResult<IEnumerable<Article>>> GetRecentArticles([FromQuery] int count = 10)
        {
            try
            {
                var articles = await _articleRepository.GetRecentArticlesAsync(count);
                return Ok(articles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to retrieve recent articles");
                return StatusCode(500, "Failed to retrieve recent articles");
            }
        }

        [HttpGet("articles/search")]
        public async Task<ActionResult<IEnumerable<Article>>> SearchArticles([FromQuery] string q)
        {
            if (string.IsNullOrWhiteSpace(q))
            {
                return BadRequest("Search term is required");
            }

            try
            {
                var articles = await _articleRepository.SearchArticlesAsync(q);
                return Ok(articles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to search articles with term {SearchTerm}", q);
                return StatusCode(500, "Failed to search articles");
            }
        }

        [HttpPost("articles/{id}/view")]
        public async Task<ActionResult> IncrementViewCount(int id)
        {
            try
            {
                var success = await _articleRepository.IncrementViewCountAsync(id);
                if (!success)
                {
                    return NotFound($"Article with ID {id} not found");
                }
                return Ok();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to increment view count for article {ArticleId}", id);
                return StatusCode(500, "Failed to increment view count");
            }
        }
    }
}
