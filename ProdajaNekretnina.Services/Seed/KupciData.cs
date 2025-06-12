using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class KupciData
    {
        public static void SeedData(this EntityTypeBuilder<Kupci> entity)
        {
            entity.HasData(
                new Kupci
                {
                    KupacId = 1,
                    Ime = "Nedzma",
                    Prezime = "Tabak",
                    DatumRegistracije = new DateTime(2024, 06, 01),
                    Email = "nedzma@gmail.com", 
                    KorisnickoIme = "admin",
                    LozinkaHash = "sev5R8XFlYf19eoHmVQ6F42LbFU=",
                    LozinkaSalt = "JCb9vvndMHMdyGx//v/JAg==",
                    Status = true,
                    ClientId= "nijePostavljen",
                    ClientSecret = "nijePostavljen"
                },
                new Kupci
                {
                    KupacId = 2,
                    Ime = "Sadzid",
                    Prezime = "Maric",
                    DatumRegistracije = new DateTime(2024, 06, 01),
                    Email = "sadzid@gmail.com",
                    KorisnickoIme = "agent",
                    LozinkaHash = "pBAyxd0eFkTx1cCDulcJ0BtG3xA=",
                    LozinkaSalt = "VeRqUN240e4wbKSR29j16Q==",
                    Status = true,
                    ClientId = "nijePostavljen",
                    ClientSecret = "nijePostavljen"

                },
                new Kupci
                {
                    KupacId = 3,
                    Ime = "Asad",
                    Prezime = "Tabak",
                    DatumRegistracije = new DateTime(2024, 06, 01),
                    Email = "asad@gmail.com",
                    KorisnickoIme = "stranka",
                    LozinkaHash = "wg2XVVhmnLgojEPxH16OGOS0JPA=",
                    LozinkaSalt = "ej0ozWpZnNpfVicem0Yykg==",
                    Status = true,
                    ClientId = "nijePostavljen",
                    ClientSecret = "nijePostavljen"

                },
                new Kupci
                {
                    KupacId = 4,
                    Ime = "Zejd",
                    Prezime = "Maric",
                    DatumRegistracije = new DateTime(2024, 06, 01),
                    Email = "zejd@gmail.com",
                    KorisnickoIme = "zejd",
                    LozinkaHash = "ZFyhh2GWQZ1+ExBnGO7ZVH8LXkY=",
                    LozinkaSalt = "jU9tXRky/91o5rqeMqJLiw==",
                    Status = true,
                    ClientId = "nijePostavljen",
                    ClientSecret = "nijePostavljen"

                },
                new Kupci
                {
                    KupacId = 5,
                    Ime = "Selma",
                    Prezime = "Baralija",
                    DatumRegistracije = new DateTime(2024, 06, 01),
                    Email = "selma@gmail.com",
                    KorisnickoIme = "selma",
                    LozinkaHash = "0xjQ8VCH/vuQIeBWZ4gc6GXR9nA=",
                    LozinkaSalt = "jxmFfP2rCcNiJu/kB0gTdUw==",
                    Status = true,
                    ClientId = "nijePostavljen",
                    ClientSecret = "nijePostavljen"

                },
                 new Kupci
                 {
                     KupacId = 6,
                     Ime = "Amna",
                     Prezime = "Baralija",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "amna@gmail.com",
                     KorisnickoIme = "amna",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 7,
                     Ime = "Ensar",
                     Prezime = "Lizde",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "ensar@gmail.com",
                     KorisnickoIme = "ensar",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 8,
                     Ime = "Azra",
                     Prezime = "Lizde",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "azra@gmail.com",
                     KorisnickoIme = "azra",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 9,
                     Ime = "Adisa",
                     Prezime = "Lizde",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "adisa@gmail.com",
                     KorisnickoIme = "adisa",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 10,
                     Ime = "Semsudin",
                     Prezime = "Lizde",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "semsudin@gmail.com",
                     KorisnickoIme = "semsudin",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 11,
                     Ime = "Zijad",
                     Prezime = "Maric",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "zijad@gmail.com",
                     KorisnickoIme = "zijad",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 12,
                     Ime = "Mersija",
                     Prezime = "Maric",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "mersija@gmail.com",
                     KorisnickoIme = "mersija",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 },
                 new Kupci
                 {
                     KupacId = 13,
                     Ime = "Hazim",
                     Prezime = "Lizde",
                     DatumRegistracije = new DateTime(2024, 06, 01),
                     Email = "hazim@gmail.com",
                     KorisnickoIme = "hazim",
                     LozinkaHash = "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=",
                     LozinkaSalt = "5/PBVv9eWBSApe7SVx+BUA==",
                     Status = true,
                     ClientId = "nijePostavljen",
                     ClientSecret = "nijePostavljen"

                 }





            );
        }
    }
}
