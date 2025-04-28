using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class TipNekretnine
{
    public int TipNekretnineId { get; set; }

    public string NazivTipa { get; set; } = null!;

    public string? OpisTipa { get; set; }

    public virtual ICollection<Nekretnina> Nekretninas { get; set; } = new List<Nekretnina>();
}
