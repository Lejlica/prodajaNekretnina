using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class KorisnikNekretninaWish
    {
        public int KorisnikNekretninaWishId { get; set; }
        public int KorisnikId { get; set; }
        public int NekretninaId { get; set; }
        public Korisnici Korisnik { get; set; }
        public Nekretnina Nekretnina { get; set; }
    }
}
