using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class ReccomendUpdateRequest
    {
        public int NekretninaId { get; set; }
        public int PrvaNekretninaId { get; set; }
        public int DrugaNekretninaId { get; set; }
        public int TrecaNekretninaId { get; set; }
    }
}
