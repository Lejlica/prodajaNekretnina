using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model
{
    public class Product
    {
        public string id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string type { get; set; }
        public string category { get; set; }
        public string image_url { get; set; }
        public string home_url { get; set; }
        public string create_time { get; set; }
        public string update_time { get; set; }
        public List<Link> links { get; set; }
    }
}
