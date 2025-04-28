using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKorisniciService : ICRUDService<Model.Korisnici, Model.SearchObjects.KorisniciSearchObject, Model.Requests.KorisniciInsertRequest, Model.Requests.KorisniciUpdateRequest>
    {
        public Task<Model.Korisnici> Login(string username, string password);
        public Task<bool> UpdatePassword(int userId, string newPassword);
    }
}
