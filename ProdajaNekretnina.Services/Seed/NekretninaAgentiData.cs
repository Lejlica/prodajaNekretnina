using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class NekretninaAgentiData
    {
        public static void SeedData(this EntityTypeBuilder<NekretninaAgenti> entity)
        {
            entity.HasData(

                 new NekretninaAgenti
                 {
                     NekretninaAgentiID = 1,
                     NekretninaId = 1,
                     KorisnikId = 2
                 },
                  new NekretninaAgenti
                  {
                      NekretninaAgentiID = 2,
                      NekretninaId = 2,
                      KorisnikId = 2
                  },
                   new NekretninaAgenti
                   {
                       NekretninaAgentiID = 3,
                       NekretninaId = 3,
                       KorisnikId = 2
                   },
                    new NekretninaAgenti
                    {
                        NekretninaAgentiID = 4,
                        NekretninaId = 7,
                        KorisnikId = 3
                    },
                    new NekretninaAgenti
                    {
                        NekretninaAgentiID = 5,
                        NekretninaId = 8,
                        KorisnikId = 3
                    },
                    new NekretninaAgenti
                    {
                        NekretninaAgentiID = 6,
                        NekretninaId = 9,
                        KorisnikId = 11
                    },
                    new NekretninaAgenti
                    {
                        NekretninaAgentiID = 7,
                        NekretninaId = 10,
                        KorisnikId = 12
                    },
                    new NekretninaAgenti
                    {
                        NekretninaAgentiID = 8,
                        NekretninaId = 11,
                        KorisnikId = 12
                    }

            );
        }
    }
}
