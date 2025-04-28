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
    public class ProblemController : BaseCRUDController<Model.Problem, Model.SearchObjects.ProblemiSearchObject, Model.Requests.ProblemInsertRequest, Model.Requests.ProblemUpdateRequest>
    {
        public ProblemController(ILogger<BaseController<Model.Problem, Model.SearchObjects.ProblemiSearchObject>> logger, IProblemService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Problem> Insert([FromBody] ProblemInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}