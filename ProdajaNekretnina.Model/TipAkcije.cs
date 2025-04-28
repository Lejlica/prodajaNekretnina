using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class TipAkcije
    {
        [Key]
        public int TipAkcijeId { get; set; }
        public string Naziv { get; set; }
    }
}
