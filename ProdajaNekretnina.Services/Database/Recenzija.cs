using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Recenzija
{
    public int RecenzijaId { get; set; }

    public float VrijednostZvjezdica { get; set; }

    public int KupacId { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Kupci Kupac { get; set; } = null!;
}
