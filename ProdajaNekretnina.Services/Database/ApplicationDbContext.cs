using Microsoft.EntityFrameworkCore;
using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



 
namespace ProdajaNekretnina.Services.Database
{
    public class ApplicationDbContext:DbContext
    {
        public DbSet<Uloge> Uloge { get; set; }
        public DbSet<Korisnici> Korisnici { get; set; }
        public DbSet<Agencija> Agencija { get; set; }
        public DbSet<Drzava> Drzava { get; set; }
        public DbSet<Grad> Grad { get; set; }
        public DbSet<Kategorije> Kategorije { get; set; }
        public DbSet<KomentariAgentima> KomentariAgentima { get; set; }
        public DbSet<Kupci> Kupci { get; set; }
        public DbSet<KorisniciUloge> KorisniciUloge { get; set; }
        public DbSet<Lokacija> Lokacija { get; set; }
        public DbSet<Nekretnina> Nekretnina { get; set; }
        public DbSet<Obilazak> Obilazak { get; set; }
        public DbSet<Problem> Problem { get; set; }
        public DbSet<Recenzija> Recenzija { get; set; }
        public DbSet<Slika> Slika { get; set; }
        public DbSet<Status> Status { get; set; }
        public DbSet<TipNekretnine> TipNekretnine { get; set; }




        public ApplicationDbContext(
           DbContextOptions options) : base(options)
        {
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Server=localhost;Database=seminarskiNekretnine;Trusted_Connection=True;MultipleActiveResultSets=True;Encrypt=False", b => b.MigrationsAssembly("ProdajaNekretnina"));

        }

    }
}
