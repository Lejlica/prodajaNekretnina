using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Agent
    {
        [Key]
        public int AgentId { get; set; }
        public int KorisnikId { get; set; }
        public Korisnici Korisnik { get; set; }
    }
}
