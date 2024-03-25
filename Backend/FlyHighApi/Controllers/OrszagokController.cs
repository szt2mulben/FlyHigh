using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FlyHighApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrszagokController : ControllerBase
    {
        private readonly flyhighdbContext _flyhighdbContext;
        private readonly IConfiguration _configuration;

        public OrszagokController(flyhighdbContext context, IConfiguration configuration)
        {
            _flyhighdbContext = context;
            _configuration = configuration;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<orszagokModel>>> Getorszagok()
        {
            if (_flyhighdbContext.orszagok == null)
            {
                return NotFound();
            }
            return await _flyhighdbContext.orszagok.ToListAsync();
        }
    }
}
