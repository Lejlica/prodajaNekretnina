using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class NekretninaAgenti
    {
        [Key]
        public int NekretninaAgentiID { get; set; }
        public int NekretninaId { get; set; }
        public int KorisnikId { get; set; }
        public Korisnici Korisnik { get; set; }
        public Nekretnina Nekretnina { get; set; }
    }
}
