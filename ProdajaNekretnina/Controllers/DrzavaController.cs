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
    public class DrzavaController : BaseCRUDController<Model.Drzava, Model.SearchObjects.DrzavaSearchObject, Model.Requests.DrzavaInsertRequest, Model.Requests.DrzavaUpdateRequest>
    {
        public DrzavaController(ILogger<BaseController<Drzava, Model.SearchObjects.DrzavaSearchObject>> logger, IDrzavaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Drzava> Insert([FromBody] DrzavaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}