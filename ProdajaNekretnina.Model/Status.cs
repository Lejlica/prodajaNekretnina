using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Status
    {
        [Key]
        public int StatusId { get; set; }
        public string Opis { get; set; }
    }
}
