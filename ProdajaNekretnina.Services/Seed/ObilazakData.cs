using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class ObilazakData
    {
        public static void SeedData(this EntityTypeBuilder<Obilazak> entity)
        {
            entity.HasData(

                 new Obilazak
                 {
                     ObilazakId = 1,
                     DatumObilaska = new DateTime(2024, 06, 01),
                     VrijemeObilaska = new DateTime(2024, 06, 01), 
                     NekretninaId = 1,
                     KorisnikId = 3,
                     isOdobren = true
                 },
                  new Obilazak
                  {
                      ObilazakId = 2,
                      DatumObilaska = new DateTime(2024, 06, 01),
                      VrijemeObilaska = new DateTime(2024, 06, 01),
                      NekretninaId = 2,
                      KorisnikId = 3,
                      isOdobren = true
                  },
                   new Obilazak
                   {
                       ObilazakId = 3,
                       DatumObilaska = new DateTime(2024, 06, 01),
                       VrijemeObilaska = new DateTime(2024, 06, 01),
                       NekretninaId = 3,
                       KorisnikId = 3,
                       isOdobren = false
                   },
                    new Obilazak
                    {
                        ObilazakId = 4,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 7,
                        KorisnikId = 3,
                        isOdobren = false
                    },
                    new Obilazak
                    {
                        ObilazakId = 5,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 7,
                        KorisnikId = 6,
                        isOdobren = false
                    },
                    new Obilazak
                    {
                        ObilazakId = 6,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 1,
                        KorisnikId = 6,
                        isOdobren = false
                    },
                    new Obilazak
                    {
                        ObilazakId = 7,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 7,
                        KorisnikId = 5,
                        isOdobren = false
                    },
                    new Obilazak
                    {
                        ObilazakId = 8,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 2,
                        KorisnikId = 5,
                        isOdobren = false
                    },
                    new Obilazak
                    {
                        ObilazakId = 9,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 3,
                        KorisnikId = 5,
                        isOdobren = false
                    },
                    new Obilazak
                    {
                        ObilazakId = 10,
                        DatumObilaska = new DateTime(2024, 06, 01),
                        VrijemeObilaska = new DateTime(2024, 06, 01),
                        NekretninaId = 2,
                        KorisnikId = 6,
                        isOdobren = false
                    }


            );
        }
    }
}
