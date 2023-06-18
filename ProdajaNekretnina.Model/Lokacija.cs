using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Lokacija
    {
        [Key]
        public int LokacijaId { get; set; }
        public string PostanskiBroj { get; set; }
        public string Ulica { get; set; }
        public int GradId { get; set; }
        public int DrzavaId { get; set; } 

       
        public Grad Grad { get; set; } 
        public Drzava Drzava { get; set; }
    }
}
