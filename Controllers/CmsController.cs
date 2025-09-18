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
    }
}
