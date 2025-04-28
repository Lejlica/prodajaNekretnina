using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKorisnikUlogeService : ICRUDService<Model.KorisniciUloge, Model.SearchObjects.KorisnikUlogeSearchObject, Model.Requests.KorisnikUlogeInsertRequest, Model.Requests.KorisnikUlogeUpdateRequest>
    {
       
    }
}
