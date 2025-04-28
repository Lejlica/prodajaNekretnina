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
    public class AgencijaController : BaseCRUDController<Model.Agencija, Model.SearchObjects.AgencijaSearchObject, Model.Requests.AgencijaInsertRequest, Model.Requests.AgencijaUpdateRequest>
    {
        public AgencijaController(ILogger<BaseController<Model.Agencija, Model.SearchObjects.AgencijaSearchObject>> logger, IAgencijaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Agencija> Insert([FromBody] AgencijaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}