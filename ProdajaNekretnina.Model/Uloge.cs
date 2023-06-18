using System.ComponentModel.DataAnnotations;

namespace ProdajaNekretnina.Model
{
    public class Uloge
    {
        [Key]
        public int UlogaId { get; set; }
        public string Naziv { get; set; }
        public string? Opis { get; set; }

    }
}