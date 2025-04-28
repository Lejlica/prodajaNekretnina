using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.Database
{
    public partial class KorisnikNekretninaWish
    {
        public int KorisnikNekretninaWishId { get; set; }
        public int KorisnikId { get; set; }
        public int NekretninaId { get; set; }
        public virtual Korisnici Korisnik { get; set; }
        public virtual Nekretnina Nekretnina { get; set; }
    }
}
