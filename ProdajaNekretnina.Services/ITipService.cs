using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface ITipService : ICRUDService<Model.TipNekretnine, Model.SearchObjects.TipSearchObject, Model.Requests.TipInsertRequest, Model.Requests.TipUpdateRequest>
    {
       
    }
}
