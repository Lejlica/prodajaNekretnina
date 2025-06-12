using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class ProblemData
    {
        public static void SeedData(this EntityTypeBuilder<Problem> entity)
        {
            entity.HasData(

                 new Problem
                 {
                     ProblemId = 1,
                     Opis = "Prokišnjava krov na spratu.",
                     DatumPrijave = new DateTime(2024, 06, 01),
                     IsVecPrijavljen = false,
                     DatumNastankaProblema = new DateTime(2024, 06, 01),
                     DatumRjesenja = new DateTime(2024, 06, 01),
                     OpisRjesenja = "",
                     KorisnikId = 3,
                     StatusId = 1,
                     NekretninaId = 1
                 },
                 new Problem
                 {
                     ProblemId = 2,
                     Opis = "Vrata se ne mogu otvoriti.",
                     DatumPrijave = new DateTime(2024, 06, 01),
                     IsVecPrijavljen = false,
                     DatumNastankaProblema = new DateTime(2024, 06, 01),
                     DatumRjesenja = new DateTime(2024, 06, 01),
                     OpisRjesenja = "",
                     KorisnikId = 3,
                     StatusId = 1,
                     NekretninaId = 2
                 },
                 new Problem
                 {
                     ProblemId = 3,
                     Opis = "Ne radi grijanje.",
                     DatumPrijave = new DateTime(2024, 06, 01),
                     IsVecPrijavljen = false,
                     DatumNastankaProblema = new DateTime(2024, 06, 01),
                     DatumRjesenja = new DateTime(2024, 06, 01),
                     OpisRjesenja = "",
                     KorisnikId = 3,
                     StatusId = 4,
                     NekretninaId = 3
                 },
                 new Problem
                 {
                     ProblemId = 4,
                     Opis = "Potrebno obaviti sanitarizaciju.",
                     DatumPrijave = new DateTime(2024, 06, 01),
                     IsVecPrijavljen = false,
                     DatumNastankaProblema = new DateTime(2024, 06, 01),
                     DatumRjesenja = new DateTime(2024, 06, 01),
                     OpisRjesenja = "",
                     KorisnikId = 5,
                     StatusId = 4,
                     NekretninaId = 7
                 }

            );
        }
    }
}
