using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class LokacijaData
    {
        public static void SeedData(this EntityTypeBuilder<Lokacija> entity)
        {
            entity.HasData(
                new Lokacija
                {
                    LokacijaId = 1,
                    PostanskiBroj = "71000",
                    Ulica = "Zmaja od Bosne 12",
                    GradId = 2,
                    DrzavaId = 1
                },
                new Lokacija
                {
                    LokacijaId = 2,
                    PostanskiBroj = "88000",
                    Ulica = "Kralja Tomislava 5",
                    GradId = 1,
                    DrzavaId = 1
                },
                new Lokacija
                {
                    LokacijaId = 3,
                    PostanskiBroj = "78000",
                    Ulica = "Tuzlanska",
                    GradId = 3,
                    DrzavaId = 1
                },
                new Lokacija
                {
                    LokacijaId = 4,
                    PostanskiBroj = "78000",
                    Ulica = "Brcanska Malta",
                    GradId = 3,
                    DrzavaId = 1
                }
            );

        }
    }
}
