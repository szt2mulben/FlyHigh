using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FlyHighApi.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class RepuloterController : ControllerBase
    {
        private readonly flyhighdbContext _flyhighdbContext;
        private readonly IConfiguration _configuration;

        public RepuloterController(flyhighdbContext context, IConfiguration configuration)
        {
            _flyhighdbContext = context;
            _configuration = configuration;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RepuloterModels>>> Getrepterek()
        {
            if (_flyhighdbContext.repuloterek == null)
            {
                return NotFound();
            }
            return await _flyhighdbContext.repuloterek.ToListAsync();
        }


        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, RepuloterModels rep)
        {
            if (id != rep.Id)
            {
                return BadRequest();
            }

            _flyhighdbContext.Entry(rep).State = EntityState.Modified;

            try
            {
                await _flyhighdbContext.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!repExists(id))
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
        public async Task<IActionResult> Deletet(int id)
        {
            if (_flyhighdbContext.repuloterek == null)
            {
                return NotFound();
            }
            var rep = await _flyhighdbContext.repuloterek.FindAsync(id);
            if (rep == null)
            {
                return NotFound();
            }

            _flyhighdbContext.repuloterek.Remove(rep);
            await _flyhighdbContext.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("search/{keresesiKriterium}")]
        public async Task<ActionResult<IEnumerable<RepuloterModels>>> Search(string keresesiKriterium)
        {
            var rep = await _flyhighdbContext.repuloterek.Where(g => g.LastName.Contains(keresesiKriterium)).ToListAsync();
            return rep;
        }

        private bool repExists(int id)
        {
            return (_flyhighdbContext.repuloterek?.Any(e => e.Id == id)).GetValueOrDefault();
        }


    }
}
