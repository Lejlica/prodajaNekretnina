using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class NekretninaTipAkcije
    {
        [Key]
        public int NekretninaTipAkcijeId { get; set; }
        public int NekretninaId { get; set; }
        public int TipAkcijeId { get; set; }
        public Nekretnina Nekretnina { get; set; }
        public TipAkcije TipAkcije { get; set; }
    }
}
