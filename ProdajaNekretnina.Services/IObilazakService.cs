using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IObilazakService : ICRUDService<Model.Obilazak, Model.SearchObjects.ObilazakSearchObject, Model.Requests.ObilazakInsertRequest, Model.Requests.ObilazakUpdateRequest>
    {
    }
}
