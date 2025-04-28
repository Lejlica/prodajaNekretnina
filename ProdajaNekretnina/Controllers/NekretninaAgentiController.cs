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
    public class NekretninaAgentiController : BaseCRUDController<Model.NekretninaAgenti, Model.SearchObjects.NekretninaAgentiSearchObject, Model.Requests.NekretninaAgentiInsertRequest, Model.Requests.NekretninaAgentiUpdateRequest>
    {
        public NekretninaAgentiController(ILogger<BaseController<NekretninaAgenti, Model.SearchObjects.NekretninaAgentiSearchObject>> logger, INekretninaAgentiService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<NekretninaAgenti> Insert([FromBody] NekretninaAgentiInsertRequest insert)
        {
            return base.Insert(insert);
        }


       

    }



}