using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class LokacijaInsertRequest
    {
        public string PostanskiBroj { get; set; }
        public string Ulica { get; set; }
        public int GradId { get; set; }
        public int DrzavaId { get; set; }
       
    }
}
