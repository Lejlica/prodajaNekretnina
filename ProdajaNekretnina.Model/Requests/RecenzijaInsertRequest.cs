using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class RecenzijaInsertRequest
    {
        public float VrijednostZvjezdica { get; set; }
        public int KupacId { get; set; }
        public int KorisnikId { get; set; }
    }
}
