using Microsoft.AspNetCore.Mvc;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MediaController : ControllerBase
    {
        private readonly ILogger<MediaController> _logger;

        public MediaController(ILogger<MediaController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public ActionResult GetMedia()
        {
            // TODO: Implement media functionality when needed
            return Ok("Media functionality not yet implemented with Dapper");
        }
    }
}
