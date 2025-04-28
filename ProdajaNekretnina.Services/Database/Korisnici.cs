using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Korisnici
{
    public int KorisnikId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string? Email { get; set; }

    public string? Telefon { get; set; }

    public string KorisnickoIme { get; set; } = null!;

    public string LozinkaHash { get; set; } = null!;

    public string LozinkaSalt { get; set; } = null!;

    public bool? Status { get; set; }
    public int? BrojUspjesnoProdanihNekretnina { get; set; }
    public float? RejtingKupaca { get; set; }
    public byte[]? BajtoviSlike { get; set; }

    public virtual ICollection<Agencija> Agencijas { get; set; } = new List<Agencija>();

    public virtual ICollection<KomentariAgentima> KomentariAgentimas { get; set; } = new List<KomentariAgentima>();

    public virtual ICollection<KorisniciUloge> KorisniciUloges { get; set; } = new List<KorisniciUloge>();

    public virtual ICollection<Nekretnina> Nekretninas { get; set; } = new List<Nekretnina>();

    public virtual ICollection<Obilazak> Obilazaks { get; set; } = new List<Obilazak>();

    public virtual ICollection<Problem> Problems { get; set; } = new List<Problem>();

    public virtual ICollection<Recenzija> Recenzijas { get; set; } = new List<Recenzija>();
    public virtual ICollection<Agent> Agents { get; set; } = new List<Agent>();
    public virtual ICollection<NekretninaAgenti> NekretninaAgentis { get; set; } = new List<NekretninaAgenti>();
    public virtual ICollection<KorisnikNekretninaWish> KorisnikNekretninaWishs { get; set; } = new List<KorisnikNekretninaWish>();
    public virtual ICollection<KorisnikAgencija> KorisnikAgencijas { get; set; } = new List<KorisnikAgencija>();
}
