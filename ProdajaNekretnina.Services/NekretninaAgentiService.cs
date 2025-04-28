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
    public class NekretninaAgentiService : BaseCRUDService<Model.NekretninaAgenti, Database.NekretninaAgenti, NekretninaAgentiSearchObject, NekretninaAgentiInsertRequest,NekretninaAgentiUpdateRequest>, INekretninaAgentiService
    {
        public NekretninaAgentiService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
