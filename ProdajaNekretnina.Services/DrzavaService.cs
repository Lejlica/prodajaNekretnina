using AutoMapper;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public class DrzavaService : BaseCRUDService<Model.Drzava, Database.Drzava, DrzavaSearchObject, DrzavaInsertRequest, DrzavaUpdateRequest>, IDrzavaService
    {
        public DrzavaService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
