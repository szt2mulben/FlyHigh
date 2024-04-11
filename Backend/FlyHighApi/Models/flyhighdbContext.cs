using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace FlyHighApi.Models
{
    public partial class flyhighdbContext : DbContext
    {
        public flyhighdbContext()
        {
        }

        public flyhighdbContext(DbContextOptions<flyhighdbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<GepAdatokModel> gepadatok { get; set; } = null!;
        public virtual DbSet<UseradatokModel> UserData{get; set;}
        public virtual DbSet<orszagokModel> orszagok { get; set; } = null!;
        public virtual DbSet<JegyekModel> jegyek { get; set; } = null!;
        public virtual DbSet<JegyAdatokModel> jegyadatok { get; set; }

        public virtual DbSet<RepuloterModels> repuloterek { get; set; }





        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    if (!optionsBuilder.IsConfigured)
        //    {
        //        optionsBuilder.UseMySql("server=localhost;user id=root;database=flyhighdb", Microsoft.EntityFrameworkCore.ServerVersion.Parse("10.4.28-mariadb"));
        //    }
        //}

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.UseCollation("utf8_hungarian_ci")
                .HasCharSet("utf8");

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
