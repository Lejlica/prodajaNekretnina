using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Status
{
    public int StatusId { get; set; }

    public string Opis { get; set; } = null!;

    public virtual ICollection<Problem> Problems { get; set; } = new List<Problem>();
}
