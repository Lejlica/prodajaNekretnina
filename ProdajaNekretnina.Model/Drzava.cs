using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Drzava
    {
        [Key]
        public int DrzavaId { get; set; }
        public string Naziv { get; set; }
    }
}
