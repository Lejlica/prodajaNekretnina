using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class KomentariAgentimaInsertRequest
    {
        public string Sadrzaj { get; set; }
        public DateTime Datum { get; set; }


        public int KorisnikId { get; set; }
        public int KupacId { get; set; }

    }
}
