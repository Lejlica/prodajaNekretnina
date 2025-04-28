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
    public class AgentController : BaseCRUDController<Model.Agent, Model.SearchObjects.AgentSearchObject, Model.Requests.AgentInsertRequest, Model.Requests.AgentUpdateRequest>
    {
        public AgentController(ILogger<BaseController<Model.Agent, Model.SearchObjects.AgentSearchObject>> logger, IAgentService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Agent> Insert([FromBody] AgentInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}