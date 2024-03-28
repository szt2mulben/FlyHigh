using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;
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

        [HttpGet("search")]
        public async Task<ActionResult<JegyAdatokModel>> Search(string honnan, string hova)
        {
            try
            {
                var jegyAdatok = await _flyhighdbContext.jegyadatok
                    .Where(j => j.honnan == honnan && j.hova == hova)
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
