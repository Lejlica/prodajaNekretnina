using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class KomentariAgentimaData
    {
        public static void SeedData(this EntityTypeBuilder<KomentariAgentima> entity)
        {
            entity.HasData(
                new KomentariAgentima
                {
                    KomentariAgentimaId = 1,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 2, 
                    KupacId = 3     
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 2,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 2,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 3,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 2,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 4,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 4,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 5,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 4,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 6,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 4,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 7,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 8,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 8,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 8,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 9,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 8,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 10,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 9,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 11,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 9,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 12,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 9,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 13,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 10,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 14,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 10,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 15,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 10,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 16,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 11,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 17,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 11,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 18,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 11,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 19,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 12,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 20,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 12,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 21,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 12,
                    KupacId = 5
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 22,
                    Sadrzaj = "Vrlo profesionalan i usluzan agent. Preporucujem!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 13,
                    KupacId = 3
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 23,
                    Sadrzaj = "Preporučujem suradnju!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 13,
                    KupacId = 6
                },
                new KomentariAgentima
                {
                    KomentariAgentimaId = 24,
                    Sadrzaj = "Usluga na vrhunskom nivou. Svaka cast!",
                    Datum = new DateTime(2025, 6, 5),
                    KorisnikId = 13,
                    KupacId = 5
                }





            );
        }
    }
}
