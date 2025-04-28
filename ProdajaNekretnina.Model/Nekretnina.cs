using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Nekretnina
    {
        [Key]
        public int NekretninaId { get; set; }
       
        public bool IsOdobrena { get; set; }
        public int KorisnikId { get; set; }//vlasnik
        public int TipNekretnineId { get; set; }
        public int KategorijaId { get; set; }
        public int LokacijaId { get; set; }
        public DateTime DatumDodavanja { get; set; }
        public DateTime DatumIzmjene { get; set; }
        public Korisnici Korisnik { get; set; }
        public TipNekretnine TipNekretnine { get; set; }
        public Kategorije Kategorija { get; set; }
        public Lokacija Lokacija { get; set; }
        public float Cijena { get; set; }
        public string? StateMachine { get; set; }
        public string Naziv { get; set; }
        public int Kvadratura { get; set; }
        public int BrojSoba { get; set; }
        public int BrojSpavacihSoba { get; set; }
        public bool Namjesten { get; set; }
        public bool Novogradnja { get; set; }
        public int Sprat { get; set; }
        public bool ParkingMjesto { get; set; }
        public int BrojUgovora { get; set; }
        public string DetaljanOpis { get; set; }
     

    }
}
