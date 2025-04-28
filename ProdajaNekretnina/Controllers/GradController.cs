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
    public class GradController : BaseCRUDController<Model.Grad, Model.SearchObjects.GradSearchObject, Model.Requests.GradInsertRequest, Model.Requests.GradUpdateRequest>
    {
        public GradController(ILogger<BaseController<Model.Grad, Model.SearchObjects.GradSearchObject>> logger, IGradService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Grad> Insert([FromBody] GradInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}