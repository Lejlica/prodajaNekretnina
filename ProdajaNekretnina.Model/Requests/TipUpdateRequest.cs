using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class TipUpdateRequest
    {
        public string NazivTipa { get; set; }
        public string? OpisTipa { get; set; }
    }
}
