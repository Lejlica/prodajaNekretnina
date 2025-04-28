using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Problem
    {
        [Key]
        public int ProblemId { get; set; }
        public string Opis { get; set; }
        public DateTime DatumPrijave { get; set; }
        public bool IsVecPrijavljen { get; set; }
        public DateTime DatumNastankaProblema { get; set; }
        public DateTime DatumRjesenja { get; set; }
        public string OpisRjesenja { get; set; }
        public int KorisnikId { get; set; }
       
        public int StatusId { get; set; }
        public int NekretninaId { get; set; }
        public Korisnici Korisnik { get; set; }
        
        public Status Status { get; set; }
        public Nekretnina Nekretnina { get; set; }
    }
}
