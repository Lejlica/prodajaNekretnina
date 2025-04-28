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
    public class LokacijaController : BaseCRUDController<Model.Lokacija, Model.SearchObjects.LokacijaSearchObject, Model.Requests.LokacijaInsertRequest, Model.Requests.LokacijaUpdateRequest>
    {
        public LokacijaController(ILogger<BaseController<Model.Lokacija, Model.SearchObjects.LokacijaSearchObject>> logger, ILokacijaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Lokacija> Insert([FromBody] LokacijaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}