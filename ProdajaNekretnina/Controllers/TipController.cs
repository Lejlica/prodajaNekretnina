using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Services;
using System.Data;


namespace ProdajaNekretnina.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TipController : BaseCRUDController<Model.TipNekretnine, Model.SearchObjects.TipSearchObject, Model.Requests.TipInsertRequest, Model.Requests.TipUpdateRequest>
    {
        public TipController(ILogger<BaseController<Model.TipNekretnine, Model.SearchObjects.TipSearchObject>> logger, ITipService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<TipNekretnine> Insert([FromBody] TipInsertRequest insert)
        {
            return base.Insert(insert);
        }


        

    }



}