using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class TipAkcijeData
    {
        public static void SeedData(this EntityTypeBuilder<TipAkcije> entity)
        {
            entity.HasData(
                new TipAkcije
                {
                    TipAkcijeId = 1,
                    Naziv = "Prodaja",
                   
                },
                new TipAkcije
                {
                    TipAkcijeId = 2,
                    Naziv = "Iznajmljivanje",
                }
               


            );
        }
    }
}
