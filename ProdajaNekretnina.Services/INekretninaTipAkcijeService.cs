using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface INekretninaTipAkcijeService : ICRUDService<Model.NekretninaTipAkcije, Model.SearchObjects.NekretninaTipAkcijeSearchObject, Model.Requests.NekretninaTipAkcijeInsertRequest, Model.Requests.NekretninaTipAkcijeUpdateRequest>
    {
       
    }
}
