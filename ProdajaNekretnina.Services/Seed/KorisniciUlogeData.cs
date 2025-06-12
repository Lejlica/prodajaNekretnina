using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class KorisniciUlogeData
    {
        public static void SeedData(this EntityTypeBuilder<KorisniciUloge> entity)
        {
            entity.HasData(
                new KorisniciUloge
                {
                    KorisnikUlogaId = 1,
                    KorisnikId = 1,
                    UlogaId = 1,
                    DatumIzmjene=DateTime.Now


                },
                new KorisniciUloge
                {
                    KorisnikUlogaId = 2,
                    KorisnikId = 2,
                    UlogaId = 2,
                    DatumIzmjene = DateTime.Now

                },
                new KorisniciUloge
                {
                    KorisnikUlogaId = 3,
                    KorisnikId = 3,
                    UlogaId = 3,
                    DatumIzmjene = DateTime.Now

                },
                new KorisniciUloge
                {
                    KorisnikUlogaId = 4,
                    KorisnikId = 4,
                    UlogaId = 2,
                    DatumIzmjene = DateTime.Now

                },
                 new KorisniciUloge
                 {
                     KorisnikUlogaId = 5,
                     KorisnikId = 5,
                     UlogaId = 3,
                     DatumIzmjene = DateTime.Now

                 },
                  new KorisniciUloge
                  {
                      KorisnikUlogaId = 6,
                      KorisnikId = 6,
                      UlogaId = 3,
                      DatumIzmjene = DateTime.Now

                  },
                  new KorisniciUloge
                  {
                      KorisnikUlogaId = 7,
                      KorisnikId = 7,
                      UlogaId = 1,
                      DatumIzmjene = DateTime.Now

                  },
                  new KorisniciUloge
                  {
                      KorisnikUlogaId = 8,
                      KorisnikId = 8,
                      UlogaId = 2,
                      DatumIzmjene = DateTime.Now

                  },
                   new KorisniciUloge
                   {
                       KorisnikUlogaId = 9,
                       KorisnikId = 9,
                       UlogaId = 2,
                       DatumIzmjene = DateTime.Now

                   },
                   new KorisniciUloge
                   {
                       KorisnikUlogaId = 10,
                       KorisnikId = 10,
                       UlogaId = 2,
                       DatumIzmjene = DateTime.Now

                   },
                   new KorisniciUloge
                   {
                       KorisnikUlogaId = 11,
                       KorisnikId = 11,
                       UlogaId = 2,
                       DatumIzmjene = DateTime.Now

                   },
                   new KorisniciUloge
                   {
                       KorisnikUlogaId = 12,
                       KorisnikId = 12,
                       UlogaId = 2,
                       DatumIzmjene = DateTime.Now

                   },
                   new KorisniciUloge
                   {
                       KorisnikUlogaId = 13,
                       KorisnikId = 13,
                       UlogaId = 2,
                       DatumIzmjene = DateTime.Now

                   }




            );
        }
    }
}
