using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IAgencijaService : ICRUDService<Model.Agencija, Model.SearchObjects.AgencijaSearchObject, Model.Requests.AgencijaInsertRequest, Model.Requests.AgencijaUpdateRequest>
    {
    }
}
