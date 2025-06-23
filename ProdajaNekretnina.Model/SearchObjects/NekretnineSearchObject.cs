using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.SearchObjects
{
    public class NekretnineSearchObject : BaseSearchObject
    {
        [Range(0, float.MaxValue)]
        public float? CijenaOd { get; set; }
        [Range(0, float.MaxValue)]
        public float? CijenaDo { get; set; }
        [StringLength(100, MinimumLength = 0)]
        public string? Grad { get; set; }
        [StringLength(100, MinimumLength = 0)]
        public string? Vlasnik { get; set; }
        [StringLength(100, MinimumLength = 0)]
        public bool? nazivTipa { get; set; }
        public int? tipNekretnineId { get; set; }

        public bool? isOdobrena { get; set; }
        public int? KvadraturaOd { get; set; }
        public int? KvadraturaDo { get; set; }
    }
}
