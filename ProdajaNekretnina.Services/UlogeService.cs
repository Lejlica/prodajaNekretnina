using AutoMapper;
using Microsoft.EntityFrameworkCore;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public class UlogeService : BaseService<Model.Uloge, Database.Uloge, UlogeSearchObject>, IUlogeService
    {
        public UlogeService(SeminarskiNekretnineContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        
    }
}
