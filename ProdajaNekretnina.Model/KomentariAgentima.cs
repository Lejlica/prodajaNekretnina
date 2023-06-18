using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public  class KomentariAgentima
    {
        [Key]
        public int KomentariAgentimaId { get; set; }
        public string Sadrzaj { get; set; }
        public DateTime Datum { get; set; }

      
        public int KorisnikId { get; set; }
        public int KupacId { get; set; }

       
        public Korisnici Korisnik { get; set; }
        public Kupci Kupac { get; set; }
    }
}
