using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class SlikaUpdateRquest
    {
        public byte[] BajtoviSlike { get; set; }
        public int NekretninaId { get; set; }
    }
}
