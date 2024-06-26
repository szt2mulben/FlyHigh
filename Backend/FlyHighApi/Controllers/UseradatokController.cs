﻿using FlyHighApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Diagnostics;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using FlyHighApi.Service;

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

        [HttpPut("{id}")]
        public async Task<IActionResult> Putuserek(int id, UseradatokModel userek)
        {
            if (id != userek.Id)
            {
                return BadRequest();
            }

            _context.Entry(userek).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!userekExists(id))
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
        public async Task<IActionResult> Deleteuser(int id)
        {
            if (_context.UserData == null)
            {
                return NotFound();
            }
            var user = await _context.UserData.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _context.UserData.Remove(user);
            await _context.SaveChangesAsync();

            return NoContent();
        }


        [HttpPost("login")]
        public async Task<ActionResult<UseradatokModel>> Login(Useradatok loginModel)
        {
            try
            {
                var user = await _context.UserData.SingleOrDefaultAsync(u => u.Name == loginModel.Name && u.Password == loginModel.Password);
                if (user == null)
                {
                    return Unauthorized("Sikertelen.");
                }

                var token = GenerateJwtToken(user);
                Debug.WriteLine("token: " + token);
                return Ok(new { Token = token });
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Beléptetési hiba: {ex.Message}");
                return StatusCode(500, $"Beléptetési hiba: {ex.Message}");
            }
        }



        [HttpPost("register")]
        public async Task<ActionResult<UseradatokModel>> Register(Useradatok registerModel)
        {
            try
            {
                var existingUser = await _context.UserData.SingleOrDefaultAsync(u => u.Name == registerModel.Name);
                if (existingUser != null)
                {
                    Debug.WriteLine("Sikertelen regisztráció: Felhasználónév már foglalt.");
                    return Conflict("A felhasználónév már foglalt.");
                }
                else
                {
                    var user = new UseradatokModel { Id = registerModel.Id, Name = registerModel.Name, Password = registerModel.Password, Email = registerModel.Email, Permission = "Ugyfel" };
                    _context.UserData.Add(user);
                    Debug.WriteLine(user.Name);
                    await _context.SaveChangesAsync();
                    return Ok();
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Regisztrációs hiba: {ex.Message}");
                return StatusCode(500, $"Regisztrációs hiba: {ex.Message}");
            }
        }

        private bool userekExists(int id)
        {
            return (_context.UserData?.Any(e => e.Id == id)).GetValueOrDefault();
        }


        private string GenerateJwtToken(UseradatokModel user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtKeyString = JwtKeyGenerator.GenerateJwtKey();
            var key = Encoding.ASCII.GetBytes(jwtKeyString);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim("Names", user.Name),
                    new Claim("Permissions", user.Permission)
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
