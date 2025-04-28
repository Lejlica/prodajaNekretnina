using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class AgencijaInsertRequest
    {
        public int AgencijaId { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public string Logo { get; set; }
        public int KorisnikId { get; set; }
        public string Adresa { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }
        public string KontaktOsoba { get; set; }
        public DateTime DatumDodavanja { get; set; }
        public DateTime DatumAzuriranja { get; set; }
    }
}
