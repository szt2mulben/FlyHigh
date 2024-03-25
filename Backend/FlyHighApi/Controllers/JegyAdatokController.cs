using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
    }
}
