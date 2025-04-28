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
    public class NekretninaTipAkcijeController : BaseCRUDController<Model.NekretninaTipAkcije, Model.SearchObjects.NekretninaTipAkcijeSearchObject, Model.Requests.NekretninaTipAkcijeInsertRequest, Model.Requests.NekretninaTipAkcijeUpdateRequest>
    {
        public NekretninaTipAkcijeController(ILogger<BaseController<Model.NekretninaTipAkcije, Model.SearchObjects.NekretninaTipAkcijeSearchObject>> logger, INekretninaTipAkcijeService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.NekretninaTipAkcije> Insert([FromBody] NekretninaTipAkcijeInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}