using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Lokacija
{
    public int LokacijaId { get; set; }

    public string PostanskiBroj { get; set; } = null!;

    public string Ulica { get; set; } = null!;

    public int GradId { get; set; }

    public int DrzavaId { get; set; }

    public virtual Drzava Drzava { get; set; } = null!;

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<Nekretnina> Nekretninas { get; set; } = new List<Nekretnina>();
}
