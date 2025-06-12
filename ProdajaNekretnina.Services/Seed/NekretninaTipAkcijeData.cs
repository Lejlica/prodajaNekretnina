using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class NekretninaTipAkcijeData
    {
        public static void SeedData(this EntityTypeBuilder<NekretninaTipAkcije> entity)
        {
            entity.HasData(

                 new NekretninaTipAkcije
                 {
                     NekretninaTipAkcijeId = 1,
                     NekretninaId = 1,
                     TipAkcijeId = 2
                 },
                  new NekretninaTipAkcije
                  {
                      NekretninaTipAkcijeId = 2,
                      NekretninaId = 2,
                      TipAkcijeId = 1
                  },
                   new NekretninaTipAkcije
                   {
                       NekretninaTipAkcijeId = 3,
                       NekretninaId = 3,
                       TipAkcijeId = 2
                   },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 4,
                        NekretninaId = 4,
                        TipAkcijeId = 2
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 5,
                        NekretninaId = 5,
                        TipAkcijeId = 1
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 6,
                        NekretninaId = 6,
                        TipAkcijeId = 1
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 7,
                        NekretninaId = 7,
                        TipAkcijeId = 2
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 8,
                        NekretninaId = 8,
                        TipAkcijeId = 2
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 9,
                        NekretninaId = 9,
                        TipAkcijeId = 1
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 10,
                        NekretninaId = 10,
                        TipAkcijeId = 2
                    },
                    new NekretninaTipAkcije
                    {
                        NekretninaTipAkcijeId = 11,
                        NekretninaId = 11,
                        TipAkcijeId = 1
                    }

            );
        }
    }
}
