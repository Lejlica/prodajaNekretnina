using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class SlikaInsertRequest
    {
        public string ImageBase64 { get; set; }
        public int NekretninaId { get; set; }
    }
}
