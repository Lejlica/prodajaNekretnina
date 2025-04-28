using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class ObilazakInsertRequest
    {
       
        public DateTime DatumObilaska { get; set; }
        public DateTime VrijemeObilaska { get; set; }
        public int NekretninaId { get; set; }
        public int KorisnikId { get; set; }
        public bool isOdobren { get; set; }

    }
}
