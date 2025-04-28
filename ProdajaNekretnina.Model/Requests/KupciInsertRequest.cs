using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class KupciInsertRequest
    {
        public string Ime { get; set; } = null!;

        public string Prezime { get; set; } = null!;

        public DateTime DatumRegistracije { get; set; }

        public string Email { get; set; } = null!;

        public string KorisnickoIme { get; set; } = null!;

        [Compare("PasswordPotvrda", ErrorMessage = "Passwords do not match.")]
        public string Password { get; set; }

        [Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string PasswordPotvrda { get; set; }

        public bool Status { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
    }
}
