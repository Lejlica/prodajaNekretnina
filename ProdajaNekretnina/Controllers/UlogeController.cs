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
    public class UlogeController : BaseController<Model.Uloge, Model.SearchObjects.UlogeSearchObject>
    {
        public UlogeController(ILogger<BaseController<Model.Uloge, Model.SearchObjects.UlogeSearchObject>> logger, IUlogeService service) : base(logger, service)
        {

        }

        
    }



}