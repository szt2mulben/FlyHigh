using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FlyHighApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly flyhighdbContext _context;
        private readonly IConfiguration _configuration;

        public UserController(flyhighdbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] UseradatokModel loginModel)
        {
            var user = await _context.UserData.SingleOrDefaultAsync(u => u.Name == loginModel.Name && u.Password == loginModel.Password);
            if (user == null)
                return Unauthorized();

            var token = GenerateJwtToken(user.Id);
            return Ok(new { Token = token });
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] UseradatokModel registerModel)
        {
            var existingUser = await _context.UserData.SingleOrDefaultAsync(u => u.Name == registerModel.Name);
            if (existingUser != null)
                return Conflict("A felhasználónév már foglalt.");

            var user = new UseradatokModel { Name = registerModel.Name, Password = registerModel.Password };
            _context.UserData.Add(user);
            await _context.SaveChangesAsync();

            var token = GenerateJwtToken(user.Id);
            return Ok(new { Token = token });
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
