using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IKorisnikNekretninaWishService : ICRUDService<Model.KorisnikNekretninaWish, Model.SearchObjects.KorisnikNekretninaWishSearchObject, Model.Requests.KorisnikNekretninaWishInsertRequest, Model.Requests.KorisnikNekretninaWishUpdateRequest>
    {
       
    }
}
