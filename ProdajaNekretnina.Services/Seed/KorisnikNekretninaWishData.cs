using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class KorisnikNekretninaWishData
    {
        public static void SeedData(this EntityTypeBuilder<KorisnikNekretninaWish> entity)
        {
            entity.HasData(

                 new KorisnikNekretninaWish
                 {
                     KorisnikNekretninaWishId = 1,
                     KorisnikId = 3,
                     NekretninaId = 1
                 },
                 new KorisnikNekretninaWish
                 {
                     KorisnikNekretninaWishId = 2,
                     KorisnikId = 3,
                     NekretninaId = 2
                 },
                 new KorisnikNekretninaWish
                 {
                     KorisnikNekretninaWishId = 3,
                     KorisnikId = 3,
                     NekretninaId = 3
                 },
                 new KorisnikNekretninaWish
                 {
                     KorisnikNekretninaWishId = 4,
                     KorisnikId = 3,
                     NekretninaId = 7
                 },
                 new KorisnikNekretninaWish
                 {
                     KorisnikNekretninaWishId = 5,
                     KorisnikId = 5,
                     NekretninaId = 3
                 }

            );
        }
    }
}
