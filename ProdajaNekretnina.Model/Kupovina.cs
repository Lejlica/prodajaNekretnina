using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CodeAnalysis;

namespace ProdajaNekretnina.Model
{
    public partial class Kupovina
    {

        [Key]
        public int KupovinaId { get; set; }
        public int? NekretninaId { get; set; }
        

        public int? KorisnikId { get; set; }  // korisnik koji kupuje
       

        public decimal Price { get; set; }
        public bool IsPaid { get; set; }
        public bool IsConfirmed { get; set; }

        public string? PayPalPaymentId { get; set; }
        public virtual Nekretnina? Nekretnina { get; set; }

        public virtual Korisnici? Korisnik { get; set; }
       

    }

}
