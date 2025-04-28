using System;
using System.Collections.Generic;

namespace ProdajaNekretnina.Services.Database;

public partial class Problem
{
    public int ProblemId { get; set; }

    public string Opis { get; set; } = null!;

    public DateTime DatumPrijave { get; set; }

    public bool IsVecPrijavljen { get; set; }

    public DateTime DatumNastankaProblema { get; set; }

    public DateTime? DatumRjesenja { get; set; }

    public string? OpisRjesenja { get; set; } = null!;

    public int KorisnikId { get; set; }

   

    public int StatusId { get; set; }

    public int NekretninaId { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    

    public virtual Status Status { get; set; } = null!;
    public virtual Nekretnina Nekretnina { get; set; } = null!;
}
