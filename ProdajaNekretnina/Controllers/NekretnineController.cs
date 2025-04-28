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
    public class NekretnineController : BaseCRUDController<Model.Nekretnina, Model.SearchObjects.NekretnineSearchObject, Model.Requests.NekretnineInsertRequest, Model.Requests.NekretnineUpdateRequest>
    {
        private readonly PayPalService _payPalService;
        public NekretnineController(ILogger<BaseController<Nekretnina, Model.SearchObjects.NekretnineSearchObject>> logger, INekretnineService service, PayPalService payPalService) : base(logger, service)
        {
            this._payPalService = payPalService;
        }

        //[Authorize(Roles = "Administrator")]
        public override Task<Nekretnina> Insert([FromBody] NekretnineInsertRequest insert)
        {
            return base.Insert(insert);
        }


        [HttpPut("{id}/activate")]
        public virtual async Task<Model.Nekretnina> Activate(int id)
        {
            return await (_service as INekretnineService).Activate(id);
        }

        [HttpPut("{id}/hide")]
        public virtual async Task<Model.Nekretnina> Hide(int id)
        {
            return await (_service as INekretnineService).Hide(id);
        }


        [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as INekretnineService).AllowedActions(id);
        }


        [AllowAnonymous]
        [HttpPost("createPayment")]
        public IActionResult CreatePayment([FromBody] PaymentRequest request)
        {
            // Logika za kreiranje plaćanja
            var paymentUrl = _payPalService.CreatePayment(request.Amount, request.Currency, request.ReturnUrl, request.CancelUrl);

            return Ok(paymentUrl);
        }
        [HttpGet("recommend")]
        public virtual List<Model.Nekretnina> Recommend(int userId)
        {
            return (_service as INekretnineService).Recommend(userId);
        }
    }



}