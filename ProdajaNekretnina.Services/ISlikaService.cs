using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface ISlikaService : ICRUDService<Model.Slika, Model.SearchObjects.SlikaSearchObject, Model.Requests.SlikaInsertRequest, Model.Requests.SlikaUpdateRquest>
    {
       
    }
}
