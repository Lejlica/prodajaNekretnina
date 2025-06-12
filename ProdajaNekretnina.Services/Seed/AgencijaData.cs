using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class AgencijaData
    {
        public static void SeedData(this EntityTypeBuilder<Agencija> entity)
        {
            entity.HasData(
                new Agencija
                {
                    AgencijaId = 1,
                    Naziv = "Golden Real Estate",
                    Opis = "Agencija specijalizovana za luksuzne nekretnine.",
                    Logo = "logo",
                    KorisnikId = 1, 
                    Adresa = "Zlatna Ulica 12, Sarajevo",
                    Email = "kontakt@goldenrealestate.ba",
                    Telefon = "+387 33 123 456",
                    KontaktOsoba = "Nedzma Tabak",
                    DatumDodavanja = new DateTime(2024, 06, 01),
                    DatumAzuriranja = new DateTime(2024, 06, 01)


                },
                new Agencija
                {
                    AgencijaId = 2,
                    Naziv = "Agencija za prodaju nekretnina",
                    Opis = "Agencija specijalizovana za luksuzne nekretnine.",
                    Logo = "logo",
                    KorisnikId = 7,
                    Adresa = "Marsala Tita, Mostar",
                    Email = "kontakt@agencija.ba",
                    Telefon = "+387 33 123 456",
                    KontaktOsoba = "Ensar Lizde",
                    DatumDodavanja = new DateTime(2024, 06, 01),
                    DatumAzuriranja = new DateTime(2024, 06, 01)


                }





            );
        }
    }
}
