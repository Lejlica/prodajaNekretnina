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
    public class KorisnikUlogeService : BaseCRUDService<Model.KorisniciUloge, Database.KorisniciUloge, KorisnikUlogeSearchObject, KorisnikUlogeInsertRequest, KorisnikUlogeUpdateRequest>, IKorisnikUlogeService
    {
        public KorisnikUlogeService(SeminarskiNekretnineContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        
    }
}
