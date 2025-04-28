using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Services;
using ProdajaNekretnina.Services.Database;
using System.Data;


namespace ProdajaNekretnina.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ObilazakController : BaseCRUDController<Model.Obilazak, Model.SearchObjects.ObilazakSearchObject, Model.Requests.ObilazakInsertRequest, Model.Requests.ObilazakUpdateRequest>
    {
        public ObilazakController(ILogger<BaseController<Model.Obilazak, Model.SearchObjects.ObilazakSearchObject>> logger, IObilazakService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Obilazak> Insert([FromBody] ObilazakInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}