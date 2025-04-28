using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class KorisnikAgencijaUpdateRequest
    {
       
        public int KorisnikId { get; set; }
        public int AgencijaId { get; set; }
    }
}
