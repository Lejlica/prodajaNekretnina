using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class NekretninaTipAkcijeUpdateRequest
    {
        public int NekretninaId { get; set; }
        public int TipAkcijeId { get; set; }
    }
}
