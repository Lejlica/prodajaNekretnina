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
    public class TipAkcijeController : BaseController<Model.TipAkcije, Model.SearchObjects.TipAkcijeSearchObject>
    {
        public TipAkcijeController(ILogger<BaseController<Model.TipAkcije, Model.SearchObjects.TipAkcijeSearchObject>> logger, ITipAkcijeService service) : base(logger, service)
        {

        }

        

    }



}