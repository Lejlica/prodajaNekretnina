using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class NekretnineUpdateRequest
    {
        public bool? IsOdobrena { get; set; }
        
        public int? TipNekretnineId { get; set; }
        public int? KategorijaId { get; set; }
        public int? LokacijaId { get; set; }
        public DateTime? DatumDodavanja { get; set; }
        public DateTime? DatumIzmjene { get; set; }
        public float? Cijena { get; set; }
        public string? StateMachine { get; set; }
        public string Naziv { get; set; }
        public int Kvadratura { get; set; }
        public int BrojSoba { get; set; }
        public int BrojSpavacihSoba { get; set; }
        public bool Namjesten { get; set; }
        public bool Novogradnja { get; set; }
        public int Sprat { get; set; }
        public bool ParkingMjesto { get; set; }
        public int BrojUgovora { get; set; }
        public string DetaljanOpis { get; set; }
    }
}
