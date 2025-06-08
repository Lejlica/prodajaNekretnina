using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.MailPublisher.Config
{
    public class RabbitConfiguration
    {
        public string Host { get; set; } = string.Empty;

        public int Port { get; set; }

        public string User { get; set; } = string.Empty;

        public string Password { get; set; } = string.Empty;
    }
}
