using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace FlyHighApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class JegyAdatokController : ControllerBase
    {
        private readonly flyhighdbContext _flyhighdbContext;
        private readonly IConfiguration _configuration;

        public JegyAdatokController(flyhighdbContext context, IConfiguration configuration)
        {
            _flyhighdbContext = context;
            _configuration = configuration;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<JegyAdatokModel>>> Getjegyadatok()
        {
            if (_flyhighdbContext.jegyadatok == null)
            {
                return NotFound();
            }
            return await _flyhighdbContext.jegyadatok.ToListAsync();
        }

        [HttpPost("search")]
        public async Task<ActionResult<JegyAdatokModel>> Search(JegyAdatok jegyek)
        {
            try
            {
                var jegyAdatok = await _flyhighdbContext.jegyadatok
                    .Where(j => j.honnan == jegyek.honnan && j.hova == jegyek.hova)
                    .ToListAsync();

                if (jegyAdatok == null || !jegyAdatok.Any())
                {
                    return NotFound("Nincs ilyen járat.");
                }
                Debug.WriteLine(jegyAdatok);
                return Ok(jegyAdatok);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Hiba történt a keresés közben.");
            }
        }

    }
}
