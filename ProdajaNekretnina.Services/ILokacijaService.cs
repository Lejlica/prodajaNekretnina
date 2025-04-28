using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface ILokacijaService : ICRUDService<Model.Lokacija, Model.SearchObjects.LokacijaSearchObject, Model.Requests.LokacijaInsertRequest, Model.Requests.LokacijaUpdateRequest>
    {
       
    }
}
