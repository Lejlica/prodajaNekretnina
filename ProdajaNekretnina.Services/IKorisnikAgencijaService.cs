using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKorisnikAgencijaService : ICRUDService<Model.KorisnikAgencija, Model.SearchObjects.KorisnikAgencijaSearchObject, Model.Requests.KorisnikAgencijaInsertRequest, Model.Requests.KorisnikAgencijaUpdateRequest>
    {
       
    }
}
