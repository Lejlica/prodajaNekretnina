﻿using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;

using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IService<T, TSearch> where TSearch : class
    {
        Task<PagedResult<T>> Get(TSearch search = null);
       
        Task<T> GetById(int id);
    }
}
