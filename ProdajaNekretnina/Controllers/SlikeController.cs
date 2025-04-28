using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Services;
using System.Data;
using ProdajaNekretnina.Services.Database;
using Microsoft.EntityFrameworkCore;
using AutoMapper;


namespace ProdajaNekretnina.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SlikeController : BaseCRUDController<Model.Slika, Model.SearchObjects.SlikaSearchObject, Model.Requests.SlikaInsertRequest, Model.Requests.SlikaUpdateRquest>
    {
        SeminarskiNekretnineContext _context;
        IMapper _mapper;

        public SlikeController(ILogger<BaseController<Model.Slika, Model.SearchObjects.SlikaSearchObject>> logger, ISlikaService service, SeminarskiNekretnineContext context, IMapper mapper)
    : base(logger, service)
        {
            _context = context;
            _mapper = mapper;
        }


        //[Authorize(Roles = "Administrator")]
        public override async Task<Model.Slika> Insert([FromBody] SlikaInsertRequest insert)
        {
            
            byte[] imageBytes = Convert.FromBase64String(insert.ImageBase64);

           
            var slika = new Model.Slika
            {
                BajtoviSlike = imageBytes,
                NekretninaId = insert.NekretninaId
            };

          
            var databaseSlika = _mapper.Map<ProdajaNekretnina.Services.Database.Slika>(slika);

           
            _context.Slikas.Add(databaseSlika);

           
            await _context.SaveChangesAsync();

            return slika;
        }



    }



}