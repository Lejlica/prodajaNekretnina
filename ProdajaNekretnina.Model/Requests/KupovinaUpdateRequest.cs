using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class KupovinaUpdateRequest
    {
        public int? KorisnikId { get; set; }

        public int? NekretninaId { get; set; }

        public decimal Price { get; set; }

        public bool IsPaid { get; set; } = false;
        public bool IsConfirmed { get; set; } = false;
        public string? PayPalPaymentId { get; set; }

    }
}
