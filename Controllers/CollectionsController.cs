using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WanderlustApi.Data;
using WanderlustApi.Models;

namespace WanderlustApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CollectionsController : ControllerBase
    {
        private readonly WanderlustDbContext _context;

        public CollectionsController(WanderlustDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Collection>>> GetCollections()
        {
            return await _context.Collections
                .OrderByDescending(c => c.UpdatedAt)
                .ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Collection>> GetCollection(int id)
        {
            var collection = await _context.Collections.FindAsync(id);

            if (collection == null)
            {
                return NotFound();
            }

            return collection;
        }

        [HttpPost]
        public async Task<ActionResult<Collection>> PostCollection(Collection collection)
        {
            collection.CreatedAt = DateTime.UtcNow;
            collection.UpdatedAt = DateTime.UtcNow;

            _context.Collections.Add(collection);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCollection", new { id = collection.Id }, collection);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCollection(int id, Collection collection)
        {
            if (id != collection.Id)
            {
                return BadRequest();
            }

            collection.UpdatedAt = DateTime.UtcNow;
            _context.Entry(collection).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CollectionExists(id))
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
        public async Task<IActionResult> DeleteCollection(int id)
        {
            var collection = await _context.Collections.FindAsync(id);
            if (collection == null)
            {
                return NotFound();
            }

            _context.Collections.Remove(collection);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CollectionExists(int id)
        {
            return _context.Collections.Any(e => e.Id == id);
        }
    }
}
