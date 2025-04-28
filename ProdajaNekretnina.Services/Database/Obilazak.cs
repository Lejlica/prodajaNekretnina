using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProdajaNekretnina.Services.Database;

public partial class Obilazak
{
    public int ObilazakId { get; set; }

    public DateTime DatumObilaska { get; set; }

    public DateTime VrijemeObilaska { get; set; }

    public int NekretninaId { get; set; }

   
    public int KorisnikId { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Nekretnina Nekretnina { get; set; } = null!;
    public bool isOdobren { get; set; }
    //public virtual ICollection<KorisniciUloge> KorisniciUloges { get; set; } = new List<KorisniciUloge>();
}
