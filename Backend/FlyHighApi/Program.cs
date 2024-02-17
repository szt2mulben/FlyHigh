using FlyHighApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FlyHighApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            builder.Services.AddDbContext<flyhighdbContext>(
                options => options.UseMySql(
                    // appsettings.json fájlból való kiolvasás
                    builder.Configuration.GetConnectionString("FlyHighDB"),
                    // adatbázis szerver verziója
                    ServerVersion.Parse("10.4.28-mariadb")
                    ));
            // CORS házirend hozzáadása
            builder.Services.AddCors(options =>
                options.AddDefaultPolicy(policy =>
                    policy.AllowAnyHeader().AllowAnyOrigin().AllowAnyMethod()));

            var app = builder.Build();
            // CORS engedélyezése
            app.UseCors();

            // Configure the HTTP request pipeline.

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}