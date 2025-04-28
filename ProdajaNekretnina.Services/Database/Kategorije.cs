using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Kategorije
{
    public int KategorijaId { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

   // public virtual ICollection<Nekretnina> Nekretninas { get; set; } = new List<Nekretnina>();
}
