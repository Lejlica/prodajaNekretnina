using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class KorisniciUloge
    {
        [Key]
        public int KorisnikUlogaId { get; set; }

        public int KorisnikId { get; set; }

        public int UlogaId { get; set; }

        public DateTime DatumIzmjene { get; set; }
        [JsonIgnore]
        public virtual Korisnici Korisnik { get; set; } = null!;

        public virtual Uloge Uloga { get; set; } = null!;
    }
}
