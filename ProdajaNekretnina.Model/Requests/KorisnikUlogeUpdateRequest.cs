using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class KorisnikUlogeUpdateRequest
    {
        public int KorisnikId { get; set; }
        public int UlogaId { get; set; }
    }
}
