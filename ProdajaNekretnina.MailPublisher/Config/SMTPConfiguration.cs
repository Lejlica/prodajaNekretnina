using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.MailPublisher.Config
{
    public class SMTPConfiguration
    {
        public int Port { get; set; }
        public string Server { get; set; } = string.Empty;
        public string FromMail { get; set; } = string.Empty;
        public string AppPassword { get; set; } = string.Empty;
    }
}
