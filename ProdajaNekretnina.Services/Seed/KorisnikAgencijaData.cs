using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class KorisnikAgencijaData
    {
        public static void SeedData(this EntityTypeBuilder<KorisnikAgencija> entity)
        {
            entity.HasData(
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 1,
                    KorisnikId = 1,
                    AgencijaId = 1
                    
                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 2,
                    KorisnikId = 2,
                    AgencijaId = 1

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 3,
                    KorisnikId = 4,
                    AgencijaId = 1

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 4,
                    KorisnikId = 7,
                    AgencijaId = 2

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 5,
                    KorisnikId = 8,
                    AgencijaId = 2

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 6,
                    KorisnikId = 9,
                    AgencijaId = 2

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 7,
                    KorisnikId = 10,
                    AgencijaId = 2

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 8,
                    KorisnikId = 11,
                    AgencijaId = 1

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 9,
                    KorisnikId = 12,
                    AgencijaId = 1

                },
                new KorisnikAgencija
                {
                    KorisnikAgencijaId = 10,
                    KorisnikId = 13,
                    AgencijaId = 2

                }




            );
        }
    }
}
