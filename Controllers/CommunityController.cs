using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CommunityController : ControllerBase
    {
        private readonly ILogger<CommunityController> _logger;

        public CommunityController(ILogger<CommunityController> logger)
        {
            _logger = logger;
        }

        [HttpGet("posts")]
        public ActionResult<IEnumerable<CommunityPost>> GetPosts()
        {
            // TODO: Implement with CommunityPost repository when needed
            return Ok(new List<CommunityPost>());
        }
    }
}
