using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ArticlesController : ControllerBase
    {
        private readonly ILogger<ArticlesController> _logger;

        public ArticlesController(ILogger<ArticlesController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Article>> GetArticles()
        {
            // TODO: Implement with Article repository when needed
            return Ok(new List<Article>());
        }

        [HttpGet("{id}")]
        public ActionResult<Article> GetArticle(int id)
        {
            // TODO: Implement with Article repository when needed
            return NotFound("Article functionality not yet implemented with Dapper");
        }
    }
}
