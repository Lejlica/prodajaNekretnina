using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.Database
{
    public partial class Agent
    {
        public int AgentId { get; set; }
        public int KorisnikId { get; set; }
        public Korisnici Korisnik { get; set; }
    }
}
