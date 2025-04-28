using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.Database
{
    public partial class KorisnikAgencija
    {


        public int KorisnikAgencijaId { get; set; }
        public Korisnici Korisnik { get; set; }
        public int KorisnikId { get; set; }
        public Agencija Agencija { get; set; }
        public int AgencijaId { get; set; }



    }
}

