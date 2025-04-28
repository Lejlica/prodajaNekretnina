using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKomentariAgentimaService : ICRUDService<Model.KomentariAgentima, Model.SearchObjects.KomentariAgentimaSearchObject, Model.Requests.KomentariAgentimaInsertRequest, Model.Requests.KomentariAgentimaUpdateRequest>
    {
       
    }
}
