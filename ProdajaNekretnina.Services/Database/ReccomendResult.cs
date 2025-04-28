using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.Database
{
    public class ReccomendResult
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NekretninaId { get; set; }
        public int PrvaNekretninaId { get; set; }
        public int DrugaNekretninaId { get; set; }
        public int TrecaNekretninaId { get; set; }
        public int KorisnikId { get; set; }
    }
}
