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
    public class NekretninaTipAkcijeService : BaseCRUDService<Model.NekretninaTipAkcije, Database.NekretninaTipAkcije, NekretninaTipAkcijeSearchObject, NekretninaTipAkcijeInsertRequest, NekretninaTipAkcijeUpdateRequest>, INekretninaTipAkcijeService
    {
        public NekretninaTipAkcijeService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
