using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Drzava
{
    public int DrzavaId { get; set; }

    public string Naziv { get; set; } = null!;

    public virtual ICollection<Grad> Grads { get; set; } = new List<Grad>();

    public virtual ICollection<Lokacija> Lokacijas { get; set; } = new List<Lokacija>();
}
