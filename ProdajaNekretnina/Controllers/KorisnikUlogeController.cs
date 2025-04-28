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
    public class KorisnikUlogeController : BaseCRUDController<Model.KorisniciUloge, Model.SearchObjects.KorisnikUlogeSearchObject, Model.Requests.KorisnikUlogeInsertRequest, Model.Requests.KorisnikUlogeUpdateRequest>
    {
        public KorisnikUlogeController(ILogger<BaseController<Model.KorisniciUloge, Model.SearchObjects.KorisnikUlogeSearchObject>> logger, IKorisnikUlogeService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        [AllowAnonymous]
        public override Task<Model.KorisniciUloge> Insert([FromBody] KorisnikUlogeInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}