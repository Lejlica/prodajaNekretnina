using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKategorijaService : ICRUDService<Model.Kategorije, Model.SearchObjects.KategorijeSearchObject, Model.Requests.KategorijaInsertRequest, Model.Requests.KategorijaUpdateRequest>
    {
    }
}
