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

        public override IQueryable<Obilazak> AddFilter(IQueryable<Obilazak> query, ObilazakSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search?.isOdobren == true)
            {
                filteredQuery = filteredQuery.Where(x => x.isOdobren == search.isOdobren);
            }
            return filteredQuery;

        }
    }
}
