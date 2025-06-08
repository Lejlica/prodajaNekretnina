using Microsoft.AspNetCore.Mvc;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services;
using ProdajaNekretnina.Services.RabbitMQ;

namespace ProdajaNekretnina.Controllers
{
    
    [ApiController]
    [Route("[controller]")]
    public class KupovinaController : BaseCRUDController<Model.Kupovina, Model.SearchObjects.KupovinaSearchObject, Model.Requests.KupovinaInsertRequest, Model.Requests.KupovinaUpdateRequest>
    {
        private readonly IKupovinaService _reservationService;
      
        public KupovinaController(
            ILogger<BaseController<Kupovina, KupovinaSearchObject>> logger,
            IKupovinaService service
            ) : base(logger, service)
        {
            _reservationService = service;
         
        }

       

        public class EmailModel
        {
            public string Sender { get; set; }
            public string Recipient { get; set; }
            public string Subject { get; set; }
            public string Content { get; set; }
        }

        

        [HttpPut("UpdateIsPaid/{id}/{isPaid}")]
        public async Task<IActionResult> UpdateIsPaid(int id, bool isPaid)
        {
            try
            {
                var updatedReservation = await _reservationService.UpdateIsPaid(id, isPaid);
                return Ok(updatedReservation);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpPut("UpdateIsConfirmed/{id}/{isConfirmed}")]
        public async Task<IActionResult> UpdateIsConfirmed(int id, bool isConfirmed)
        {
            try
            {
                var updatedReservation = await _reservationService.UpdateIsConfirmed(id, isConfirmed);
                return Ok(updatedReservation);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        


        [HttpPut("AddPayPalPaymentId/{id}/{payPalPaymentId}")]
        public async Task<IActionResult> AddPayPalPaymentId(int id, string payPalPaymentId)
        {
            try
            {
                var updatedReservation = await _reservationService.AddPayPalPaymentId(id, payPalPaymentId);
                return Ok(updatedReservation);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
