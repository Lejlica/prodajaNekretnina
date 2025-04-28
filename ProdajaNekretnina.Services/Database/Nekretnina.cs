using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Nekretnina
{
    public int NekretninaId { get; set; }
    

    public bool IsOdobrena { get; set; }

    public int KorisnikId { get; set; }

    public int TipNekretnineId { get; set; }

    public int KategorijaId { get; set; }

    public int LokacijaId { get; set; }

    public DateTime DatumDodavanja { get; set; }

    public DateTime DatumIzmjene { get; set; }

    //public virtual Kategorije Kategorija { get; set; } = null!;

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Lokacija Lokacija { get; set; } = null!;

    public virtual ICollection<Obilazak> Obilazaks { get; set; } = new List<Obilazak>();

    public virtual ICollection<Problem> Problems { get; set; } = new List<Problem>();

    public virtual ICollection<Slika> Slikas { get; set; } = new List<Slika>();
    public virtual ICollection<NekretninaAgenti> NekretninaAgentis { get; set; } = new List<NekretninaAgenti>();
    public virtual ICollection<NekretninaTipAkcije> NekretninaTipAkcijes { get; set; } = new List<NekretninaTipAkcije>();
    public virtual ICollection<KorisnikNekretninaWish> KorisnikNekretninaWishs { get; set; } = new List<KorisnikNekretninaWish>();
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
