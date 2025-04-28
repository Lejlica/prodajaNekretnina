using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Services;
using System.Collections.Generic;
using System.Data;


namespace ProdajaNekretnina.Controllers
/*{
    [ApiController]
    [Route("[controller]")]
    public class KorisniciController : BaseCRUDController<Model.Korisnici, Model.SearchObjects.KorisniciSearchObject, Model.Requests.KorisniciInsertRequest, Model.Requests.KorisniciUpdateRequest>
    {
        public KorisniciController(ILogger<BaseController<Model.Korisnici, Model.SearchObjects.KorisniciSearchObject>> logger, IKorisniciService service) : base(logger, service)
        {

        }

        [Authorize(Roles = "Administrator")]
        public override Task<Korisnici> Insert([FromBody] KorisniciInsertRequest insert)
        {
            return base.Insert(insert);
        }

       

    }



}*/


{ 
[ApiController]
    [Route("[controller]")]
    public class KorisniciController : BaseCRUDController<Model.Korisnici, Model.SearchObjects.KorisniciSearchObject, Model.Requests.KorisniciInsertRequest, Model.Requests.KorisniciUpdateRequest>
    {
        private readonly IKupciService _kupciService;
        private readonly IKorisniciService _korisniciService;

        public KorisniciController(
     ILogger<BaseController<Model.Korisnici, Model.SearchObjects.KorisniciSearchObject>> logger,
     IKorisniciService korisniciService,
     IKupciService kupciService
     ) : base(logger, korisniciService)
        {
            _kupciService = kupciService;
            _korisniciService = korisniciService;
        }


        // [Authorize(Roles = "Administrator")]
        [AllowAnonymous]
        public override async Task<Korisnici> Insert([FromBody] KorisniciInsertRequest insert)
        {
            // Perform the insertion into Korisnici table
            var insertedKorisnik = await base.Insert(insert);

            // Create a corresponding entry in Kupci table
            var kupciInsertRequest = new KupciInsertRequest
            {
                Ime = insert.Ime,
                Prezime = insert.Prezime,
                DatumRegistracije = DateTime.Now,
                Email = insert.Email,
                KorisnickoIme = insert.KorisnickoIme,
                Password = insert.Password,
                PasswordPotvrda = insert.PasswordPotvrda,
                Status = true,
               ClientId="nijePostavljen",
               ClientSecret = "nijePostavljen"
            };

            await _kupciService.Insert(kupciInsertRequest); // Insert into Kupci table

            return insertedKorisnik;
        }

        [HttpPut("{userId}/update-password")]
        public async Task<IActionResult> UpdatePassword(int userId,[FromBody] KorisniciUpdateRequest updateRequest)
        {
           

            

            // Pozovite metodu za ažuriranje lozinke
            bool success = await _korisniciService.UpdatePassword(userId, updateRequest.Password);

            if (success)
            {
                return Ok(); // Uspješno ažurirano
            }
            else
            {
                return NotFound(); // Korisnik nije pronađen
            }
        }

        /*[Authorize]
        [HttpPut("PayMembership")]
        public async Task<IActionResult> PayMembership([FromQuery] int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                await _korisniciService.PayMembershipAsync(userId, cancellationToken);
                return Ok("Membership successfully activated");
            }
            catch (Exception e)
            {

                Logger.LogError(e, "Problem when paying membership");
                return BadRequest(e.Message + ", " + e?.InnerException);
            }
        }*/


    }
} 
