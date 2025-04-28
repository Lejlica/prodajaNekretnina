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
    public class ObilazakService : BaseCRUDService<Model.Obilazak, Database.Obilazak, ObilazakSearchObject, ObilazakInsertRequest, ObilazakUpdateRequest>, IObilazakService
    {
        public ObilazakService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
