using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class AuthorizationResponseDataPayPal
    {
        public string scope { get; set; } = null!;
        public string access_token { get; set; } = null!;
        public string token_type { get; set; } = null!;
        public string app_id { get; set; } = null!;
        public int expires_in { get; set; } 
        public List<string> supported_authn_schemes { get; set; } = null!;
        public string nonce { get; set; } = null!;
        public ClientMetadata client_metadata { get; set; }
    }
}
