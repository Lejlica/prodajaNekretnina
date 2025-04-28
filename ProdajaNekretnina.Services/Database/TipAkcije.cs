using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.Database
{
    public partial class TipAkcije
    {
        public int TipAkcijeId { get; set; }
        public string Naziv { get; set; }
        public virtual ICollection<NekretninaTipAkcije> NekretninaTipAkcijes { get; set; } = new List<NekretninaTipAkcije>();
    }
}
