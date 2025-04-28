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
    public class KorisnikAgencijaController : BaseCRUDController<Model.KorisnikAgencija, Model.SearchObjects.KorisnikAgencijaSearchObject, Model.Requests.KorisnikAgencijaInsertRequest, Model.Requests.KorisnikAgencijaUpdateRequest>
    {
        public KorisnikAgencijaController(ILogger<BaseController<Model.KorisnikAgencija, Model.SearchObjects.KorisnikAgencijaSearchObject>> logger, IKorisnikAgencijaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.KorisnikAgencija> Insert([FromBody] KorisnikAgencijaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}