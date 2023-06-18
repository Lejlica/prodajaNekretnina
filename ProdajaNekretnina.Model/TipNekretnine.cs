using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class TipNekretnine
    {
        [Key]
        public int TipNekretnineId { get; set; }
        public string NazivTipa { get; set; }
        public string? OpisTipa { get; set; }
    }
}
