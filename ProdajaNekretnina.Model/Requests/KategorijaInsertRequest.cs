using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class KategorijaInsertRequest
    {
        public string Naziv { get; set; } = null! ;
        public string? Opis { get; set; }
    }
}
