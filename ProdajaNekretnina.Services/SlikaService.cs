using AutoMapper;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;

namespace ProdajaNekretnina.Services
{
    public class SlikaService : BaseCRUDService<Model.Slika, Database.Slika, SlikaSearchObject, SlikaInsertRequest, SlikaUpdateRquest>, ISlikaService
    {
        public SlikaService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.Slika> AddFilter(IQueryable<Database.Slika> query, SlikaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.nekretninaId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.NekretninaId == search.nekretninaId.Value);
            }
            return filteredQuery;

        }
    }
}
