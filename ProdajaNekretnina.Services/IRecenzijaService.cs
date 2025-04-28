using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IRecenzijaService : ICRUDService<Model.Recenzija, Model.SearchObjects.RecenzijaSearchObject, Model.Requests.RecenzijaInsertRequest, Model.Requests.RecenzijaUpdateRequest>
    {

    }
}
