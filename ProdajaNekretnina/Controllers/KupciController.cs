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
    public class KupciController : BaseCRUDController<Model.Kupci, Model.SearchObjects.KupciSearchObject, Model.Requests.KupciInsertRequest, Model.Requests.KupciUpdateRequest>
    {
        public KupciController(ILogger<BaseController<Model.Kupci, Model.SearchObjects.KupciSearchObject>> logger, IKupciService service) : base(logger, service)
        {

        }

     
       

    }



}