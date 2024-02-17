using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FlyHighApi.Models;

namespace FlyHighApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GepAdatokController : ControllerBase
    {
        private readonly flyhighdbContext _context;

        public GepAdatokController(flyhighdbContext context)
        {
            _context = context;
        }

        // GET: api/Gepadatok
        [HttpGet]
        public async Task<ActionResult<IEnumerable<GepAdatokModel>>> Getgepadatok()
        {
          if (_context.gepadatok == null)
          {
              return NotFound();
          }
            return await _context.gepadatok.ToListAsync();
        }

        // GET: api/Gepadatok/5
        [HttpGet("{id}")]
        public async Task<ActionResult<GepAdatokModel>> Getgepadatok(int id)
        {
          if (_context.gepadatok == null)
          {
              return NotFound();
          }
            var tapanyagok = await _context.gepadatok.FindAsync(id);

            if (tapanyagok == null)
            {
                return NotFound();
            }

            return tapanyagok;
        }

        // PUT: api/Gepadatok/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> Putgepadatok(int id, GepAdatokModel gepek)
        {
            if (id != gepek.Id)
            {
                return BadRequest();
            }

            _context.Entry(gepek).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!gepadatokExists(id))
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

        // POST: api/Gepadatok
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<GepAdatokModel>> Postgepadatok(GepAdatokModel gepek)
        {
          if (_context.gepadatok == null)
          {
              return Problem("Entity set 'flyhighdbContext.gepadatok'  is null.");
          }
            _context.gepadatok.Add(gepek);
            await _context.SaveChangesAsync();

            return CreatedAtAction("Getgepadatok", new { id = gepek.Id }, gepek);
        }

        // DELETE: api/Gepadatok/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Deletetgepadatok(int id)
        {
            if (_context.gepadatok == null)
            {
                return NotFound();
            }
            var gepek = await _context.gepadatok.FindAsync(id);
            if (gepek == null)
            {
                return NotFound();
            }

            _context.gepadatok.Remove(gepek);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool gepadatokExists(int id)
        {
            return (_context.gepadatok?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
