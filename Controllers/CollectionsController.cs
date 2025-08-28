using Microsoft.AspNetCore.Mvc;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CollectionsController : ControllerBase
    {
        private readonly ILogger<CollectionsController> _logger;

        public CollectionsController(ILogger<CollectionsController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Collection>> GetCollections()
        {
            // TODO: Implement with Collection repository when needed
            return Ok(new List<Collection>());
        }
    }
}
