using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CmsController : ControllerBase
    {
        private readonly ILogger<CmsController> _logger;

        public CmsController(ILogger<CmsController> logger)
        {
            _logger = logger;
        }

        [HttpGet("articles")]
        public ActionResult<IEnumerable<Article>> GetArticles()
        {
            // TODO: Implement with repositories when needed
            return Ok(new List<Article>());
        }
        
        [HttpGet("collections")]
        public ActionResult<IEnumerable<Collection>> GetCollections()
        {
            // TODO: Implement with repositories when needed
            return Ok(new List<Collection>());
        }
    }
}
