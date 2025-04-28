using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;

namespace ProdajaNekretnina;

public partial class Agencija
{
    public int AgencijaId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public string Logo { get; set; } = null!;

    public int KorisnikId { get; set; }

    public string Adresa { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Telefon { get; set; } = null!;

    public string KontaktOsoba { get; set; } = null!;

    public DateTime DatumDodavanja { get; set; }

    public DateTime DatumAzuriranja { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;
}
