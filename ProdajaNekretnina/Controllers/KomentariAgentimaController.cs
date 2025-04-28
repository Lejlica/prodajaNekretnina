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
    public class KomentariAgentimaController : BaseCRUDController<Model.KomentariAgentima, Model.SearchObjects.KomentariAgentimaSearchObject, Model.Requests.KomentariAgentimaInsertRequest, Model.Requests.KomentariAgentimaUpdateRequest>
    {
        public KomentariAgentimaController(ILogger<BaseController<Model.KomentariAgentima, Model.SearchObjects.KomentariAgentimaSearchObject>> logger, IKomentariAgentimaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.KomentariAgentima> Insert([FromBody] KomentariAgentimaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}