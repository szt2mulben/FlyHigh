using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Diagnostics;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FlyHighApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UseradatokController : ControllerBase
    {
        private readonly flyhighdbContext _context;
        private readonly IConfiguration _configuration;

        public UseradatokController(flyhighdbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UseradatokModel>>> Getusers()
        {
            if (_context.UserData == null)
            {
                return NotFound();
            }
            return await _context.UserData.ToListAsync();
        }

        [HttpPost("login")]
        public async Task<ActionResult<UseradatokModel>> Login(UseradatokModel loginModel)
        {
            try
            {
                var user = await _context.UserData.SingleOrDefaultAsync(u => u.Name == loginModel.Name && u.Password == loginModel.Password);
                if (user == null)
                {
                    return Unauthorized();
                }
                else
                {
                    var token = GenerateJwtToken(user.Id);
                    Debug.Write(token);
                    return Ok(new { Token = token });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Belépési hiba: {ex.Message}");
            }
        }


        [HttpPost("register")]
        public async Task<ActionResult<UseradatokModel>> Register(UseradatokModel registerModel)
        {
            try
            {
                var existingUser = await _context.UserData.SingleOrDefaultAsync(u => u.Name == registerModel.Name);
                if (existingUser != null)
                { 
                    return Conflict("A felhasználónév már foglalt.");
                }
                else
                {
                    _context.UserData.Add(registerModel);
                    await _context.SaveChangesAsync();
                    var token = GenerateJwtToken(registerModel.Id);
                    return Ok(new { Token = token });
                }
                //var user = new UseradatokModel { Id = registerModel.Id, Name = registerModel.Name, Password = registerModel.Password, Email = registerModel.Email };
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Regisztrációs hiba: {ex.Message}");
            }
        }


        private string GenerateJwtToken(int userId)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, userId.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
