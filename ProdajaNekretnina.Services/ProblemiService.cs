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
    public class ProblemiService : BaseCRUDService<Model.Problem, Database.Problem, ProblemiSearchObject, ProblemInsertRequest, ProblemUpdateRequest>, IProblemService
    {
        public ProblemiService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
            
        }
        public override IQueryable<Problem> AddFilter(IQueryable<Problem> query, ProblemiSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search?.DatumPrijave !=null)
            {
                filteredQuery = filteredQuery.Where(x => x.DatumPrijave == search.DatumPrijave);
            }
            return filteredQuery;

        }
    }
}
