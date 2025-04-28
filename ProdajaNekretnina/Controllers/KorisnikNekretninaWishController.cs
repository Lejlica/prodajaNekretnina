using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Services;
using System.Data;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikNekretninaWishController : BaseCRUDController<Model.KorisnikNekretninaWish, Model.SearchObjects.KorisnikNekretninaWishSearchObject, Model.Requests.KorisnikNekretninaWishInsertRequest, Model.Requests.KorisnikNekretninaWishUpdateRequest>
    {
        public KorisnikNekretninaWishController(ILogger<BaseController<Model.KorisnikNekretninaWish, Model.SearchObjects.KorisnikNekretninaWishSearchObject>> logger, IKorisnikNekretninaWishService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.KorisnikNekretninaWish> Insert([FromBody] KorisnikNekretninaWishInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}