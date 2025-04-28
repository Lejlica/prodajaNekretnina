using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IGradService : ICRUDService<Model.Grad, Model.SearchObjects.GradSearchObject, Model.Requests.GradInsertRequest, Model.Requests.GradUpdateRequest>
    {
    }
}
