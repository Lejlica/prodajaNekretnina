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
    public class RecenzijaController : BaseCRUDController<Model.Recenzija, Model.SearchObjects.RecenzijaSearchObject, Model.Requests.RecenzijaInsertRequest, Model.Requests.RecenzijaUpdateRequest>
    {
        public RecenzijaController(ILogger<BaseController<Model.Recenzija, Model.SearchObjects.RecenzijaSearchObject>> logger, IRecenzijaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Recenzija> Insert([FromBody] RecenzijaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}