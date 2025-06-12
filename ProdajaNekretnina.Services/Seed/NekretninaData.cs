using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class NekretninaData
    {
        public static void SeedData(this EntityTypeBuilder<Nekretnina> entity)
        {
            entity.HasData(
            new Nekretnina
            {
                NekretninaId = 1,
                IsOdobrena = true,
                KorisnikId = 3,
                TipNekretnineId = 1,
                KategorijaId = 1,
                LokacijaId = 1,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 250000,
                StateMachine = "draft",
                Naziv = "Moderna Porodicna Kuca",
                Kvadratura = 180,
                BrojSoba = 5,
                BrojSpavacihSoba = 3,
                Namjesten = true,
                Novogradnja = false,
                Sprat = 2,
                ParkingMjesto = true,
                BrojUgovora = 12345,
                DetaljanOpis = "Prostrana kuca sa velikim dvoristem u mirnom dijelu grada."
            },
            new Nekretnina
            {
                NekretninaId = 2,
                IsOdobrena = true,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 1,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 350000,
                StateMachine = "draft",
                Naziv = "Stan na dan",
                Kvadratura = 280,
                BrojSoba = 4,
                BrojSpavacihSoba = 1,
                Namjesten = true,
                Novogradnja = false,
                Sprat = 2,
                ParkingMjesto = true,
                BrojUgovora = 12345,
                DetaljanOpis = "Prostrani stan sa velikom okucnicom u centru grada."
            },
            new Nekretnina
            {
                NekretninaId = 3,
                IsOdobrena = true,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 2,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 500000,
                StateMachine = "draft",
                Naziv = "Villa u centru Sarajeva",
                Kvadratura = 180,
                BrojSoba = 7,
                BrojSpavacihSoba = 4,
                Namjesten = true,
                Novogradnja = true,
                Sprat = 2,
                ParkingMjesto = true,
                BrojUgovora = 10000,
                DetaljanOpis = "Moderna villa u centru sarajeva. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 4,
                IsOdobrena = false,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 1,
                LokacijaId = 3,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 20000,
                StateMachine = "draft",
                Naziv = "Poslovni prostor",
                Kvadratura = 200,
                BrojSoba = 0,
                BrojSpavacihSoba = 0,
                Namjesten = false,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = "Iznajmljuje se poslovni prostor. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 5,
                IsOdobrena = false,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 3,
                LokacijaId = 3,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 4000,
                StateMachine = "draft",
                Naziv = "Garaza",
                Kvadratura = 200,
                BrojSoba = 0,
                BrojSpavacihSoba = 0,
                Namjesten = false,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = "Iznajmljuje se garaza. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 6,
                IsOdobrena = false,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 4,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 600000,
                StateMachine = "draft",
                Naziv = "Kuca sa okucnicom",
                Kvadratura = 200,
                BrojSoba = 0,
                BrojSpavacihSoba = 0,
                Namjesten = false,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = "Prodaje se moderno uredjena kuca. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 7,
                IsOdobrena = true,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 2,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 600000,
                StateMachine = "draft",
                Naziv = "Stan sa bazenom",
                Kvadratura = 200,
                BrojSoba = 0,
                BrojSpavacihSoba = 0,
                Namjesten = false,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = "Prodaje se moderno uredjen stan. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 8,
                IsOdobrena = false,
                KorisnikId = 5,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 2,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 600000,
                StateMachine = "draft",
                Naziv = "Vikendica prostrana",
                Kvadratura = 100,
                BrojSoba = 3,
                BrojSpavacihSoba = 1,
                Namjesten = true,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = "Prodaje se moderno uredjena vikendica. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 9,
                IsOdobrena = false,
                KorisnikId = 6,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 4,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 502000,
                StateMachine = "draft",
                Naziv = "Stan Ilidza",
                Kvadratura = 100,
                BrojSoba = 3,
                BrojSpavacihSoba = 1,
                Namjesten = true,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = "Prodaje se moderno uredjen stan. Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 10,
                IsOdobrena = false,
                KorisnikId = 6,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 3,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 700000,
                StateMachine = "draft",
                Naziv = "Moderna kuca sa dva sprata",
                Kvadratura = 100,
                BrojSoba = 3,
                BrojSpavacihSoba = 1,
                Namjesten = true,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = " Za dodatne informacije javiti se na mail."
            },
            new Nekretnina
            {
                NekretninaId = 11,
                IsOdobrena = false,
                KorisnikId = 3,
                TipNekretnineId = 2,
                KategorijaId = 2,
                LokacijaId = 1,
                DatumDodavanja = new DateTime(2025, 6, 1),
                DatumIzmjene = new DateTime(2025, 6, 5),
                Cijena = 705000,
                StateMachine = "draft",
                Naziv = "Trospratna kuca prodaja",
                Kvadratura = 100,
                BrojSoba = 3,
                BrojSpavacihSoba = 1,
                Namjesten = true,
                Novogradnja = true,
                Sprat = 1,
                ParkingMjesto = true,
                BrojUgovora = 12300,
                DetaljanOpis = " Za dodatne informacije javiti se na mail."
            }

            );
        }
    }
}
