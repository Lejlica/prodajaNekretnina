using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class UlogeData
    {
        public static void SeedData(this EntityTypeBuilder<Uloge> entity)
        {
            entity.HasData(
                new Uloge
                {
                    UlogaId = 1,
                    Naziv = "Admin",
                    Opis="admin"
                },
                new Uloge
                {
                    UlogaId = 2,
                    Naziv = "Agent",
                    Opis = "agent"
                },
                new Uloge
                {
                    UlogaId = 3,
                    Naziv = "Stranka",
                    Opis = "stranka"
                }
            

            );
        }
    }
}
