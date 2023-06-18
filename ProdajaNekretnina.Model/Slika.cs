using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Slika
    {
        [Key]
        public int SlikaId { get; set; }
        public byte[] BajtoviSlike { get; set; }
        public int NekretninaId { get; set; }
        public Nekretnina Nekretnina { get; set; }
    }
}
