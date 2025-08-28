using Microsoft.AspNetCore.Mvc;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ArticleSyncController : ControllerBase
    {
        private readonly ILogger<ArticleSyncController> _logger;

        public ArticleSyncController(ILogger<ArticleSyncController> logger)
        {
            _logger = logger;
        }

        [HttpPost("sync")]
        public ActionResult SyncArticles()
        {
            // TODO: Implement article sync when needed
            return Ok("Article sync not yet implemented with Dapper");
        }
    }
}
