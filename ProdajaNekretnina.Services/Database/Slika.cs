using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Slika
{
    public int SlikaId { get; set; }

    public byte[] BajtoviSlike { get; set; } = null!;

    public int NekretninaId { get; set; }

    public virtual Nekretnina Nekretnina { get; set; } = null!;
}
