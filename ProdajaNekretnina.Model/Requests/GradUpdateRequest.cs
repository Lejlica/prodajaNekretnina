﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Model.Requests
{
    public class GradUpdateRequest
    {
        public string Naziv { get; set; }
        public int DrzavaId { get; set; }
    }
}
