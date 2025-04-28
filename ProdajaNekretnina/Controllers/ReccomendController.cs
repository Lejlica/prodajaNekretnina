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
    public class ReccomendController : BaseController<Model.ReccomendResult, Model.SearchObjects.ReccomendSearchObject>
    {
        public ReccomendController(ILogger<BaseController<Model.ReccomendResult, Model.SearchObjects.ReccomendSearchObject>> logger, IReccomendResultService service) : base(logger, service)
        {

        }

     
       

    }



}