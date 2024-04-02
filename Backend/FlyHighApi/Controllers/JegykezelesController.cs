using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace FlyHighApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class JegykezelesController : ControllerBase
    {
        private readonly flyhighdbContext _flyhighdbContext;
        private readonly IConfiguration _configuration;

        public JegykezelesController(flyhighdbContext context, IConfiguration configuration)
        {
            _flyhighdbContext = context;
            _configuration = configuration;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<JegyekModel>>> Getjegyek()
        {
            if (_flyhighdbContext.jegyek == null)
            {
                return NotFound();
            }
            return await _flyhighdbContext.jegyek.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<JegyekModel>> Postjegyek(JegyekModel jegyek)
        {
            Debug.WriteLine(jegyek);

            if (_flyhighdbContext.jegyek == null)
            {
                return Problem("Entity set 'flyhighdbContext.jegyek'  is null.");
            }
            _flyhighdbContext.jegyek.Add(jegyek);
            await _flyhighdbContext.SaveChangesAsync();

            return CreatedAtAction("Postjegyek", new { id = jegyek.jegy_id }, jegyek);
        }

    }
}
