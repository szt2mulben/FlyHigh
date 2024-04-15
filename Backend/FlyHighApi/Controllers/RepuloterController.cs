﻿using FlyHighApi.Models;
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


    }
}