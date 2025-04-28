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
    public class KategorijaController : BaseCRUDController<Model.Kategorije, Model.SearchObjects.KategorijeSearchObject, Model.Requests.KategorijaInsertRequest, Model.Requests.KategorijaUpdateRequest>
    {
        public KategorijaController(ILogger<BaseController<Model.Kategorije, Model.SearchObjects.KategorijeSearchObject>> logger, IKategorijaService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Model.Kategorije> Insert([FromBody] KategorijaInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }



}