using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class ProblemInsertRequest
    {
        public string Opis { get; set; }
        public DateTime DatumPrijave { get; set; }
        public bool IsVecPrijavljen { get; set; }
        public DateTime DatumNastankaProblema { get; set; }
        public DateTime DatumRjesenja { get; set; }
        public string OpisRjesenja { get; set; }
        public int KorisnikId { get; set; }
        public int NekretninaId { get; set; }
        public int StatusId { get; set; }
    }
}
