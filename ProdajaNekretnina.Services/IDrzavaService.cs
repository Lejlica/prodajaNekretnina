using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IDrzavaService : ICRUDService<Model.Drzava, Model.SearchObjects.DrzavaSearchObject, Model.Requests.DrzavaInsertRequest, Model.Requests.DrzavaUpdateRequest>
    {
    }
}
