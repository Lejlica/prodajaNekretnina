using Microsoft.CodeAnalysis;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.SearchObjects
{
    public class DrzavaSearchObject : BaseSearchObject
    {
        [StringLength(100, MinimumLength = 0)]
        public string? Naziv { get; set; }
    }
}
