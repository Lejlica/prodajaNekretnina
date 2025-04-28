using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class KomentariAgentima
{
    public int KomentariAgentimaId { get; set; }

    public string Sadrzaj { get; set; } = null!;

    public DateTime Datum { get; set; }

    public int KorisnikId { get; set; }

    public int KupacId { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Kupci Kupac { get; set; } = null!;
}
