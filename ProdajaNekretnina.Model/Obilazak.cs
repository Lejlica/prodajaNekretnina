using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Obilazak
    {
        [Key]
        public int ObilazakId { get; set; }
        public DateTime DatumObilaska { get; set; }
        public DateTime VrijemeObilaska { get; set; }
        public int NekretninaId { get; set; }
        
        public int KorisnikId { get; set; }
        public Nekretnina Nekretnina { get; set; }
        public Korisnici Korisnik { get; set; }
        public bool isOdobren { get; set; }
        //public virtual ICollection<KorisniciUloge> KorisniciUloges { get; set; } = new List<KorisniciUloge>();

    }
}
