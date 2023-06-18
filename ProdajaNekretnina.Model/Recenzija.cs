using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Recenzija
    {
        [Key]
        public int RecenzijaId { get; set; }
        public int VrijednostZvjezdica { get; set; }
        public int KupacId { get; set; }
        public int KorisnikId { get; set; }
        public Kupci Kupac { get; set; }
        public Korisnici Korisnik { get; set; }
    }
}
