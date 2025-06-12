using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class RecenzijaData
    {
        public static void SeedData(this EntityTypeBuilder<Recenzija> entity)
        {
            entity.HasData(

                 new Recenzija
                 {
                     RecenzijaId = 1,
                     VrijednostZvjezdica = 4.5f,
                     KupacId = 5,
                     KorisnikId = 2
                 },
                 new Recenzija
                 {
                     RecenzijaId = 2,
                     VrijednostZvjezdica = 2.5f,
                     KupacId = 6,
                     KorisnikId = 2
                 }

            );
        }
    }
}
