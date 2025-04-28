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
    public class StatusController : BaseController<Model.Status, Model.SearchObjects.StatusSearchObject>
    {
        public StatusController(ILogger<BaseController<Model.Status, Model.SearchObjects.StatusSearchObject>> logger, IStatusService service) : base(logger, service)
        {

        }

        

    }



}