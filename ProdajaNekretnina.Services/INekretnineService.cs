using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface INekretnineService : ICRUDService<Model.Nekretnina, Model.SearchObjects.NekretnineSearchObject, Model.Requests.NekretnineInsertRequest, Model.Requests.NekretnineUpdateRequest>
    {
        Task<Nekretnina> Activate(int id);

        Task<Nekretnina> Hide(int id);

        Task<List<string>> AllowedActions(int id);
        public List<Model.Nekretnina> Recommend(int userId);
    }
}
