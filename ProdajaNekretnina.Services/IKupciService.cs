using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKupciService : ICRUDService<Model.Kupci, Model.SearchObjects.KupciSearchObject, Model.Requests.KupciInsertRequest, Model.Requests.KupciUpdateRequest>
    {
       
    }
}
