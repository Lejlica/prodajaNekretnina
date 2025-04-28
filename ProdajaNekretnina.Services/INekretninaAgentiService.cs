using ProdajaNekretnina.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface INekretninaAgentiService : ICRUDService<Model.NekretninaAgenti, Model.SearchObjects.NekretninaAgentiSearchObject,NekretninaAgentiInsertRequest,NekretninaAgentiUpdateRequest>
    {
    }
}
