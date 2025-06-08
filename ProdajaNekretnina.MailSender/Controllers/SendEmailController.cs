using Microsoft.AspNetCore.Mvc;

using ProdajaNekretnina.MailPublisher.Services;
using ProdajaNekretnina.MailSender.Model;
using ProdajaNekretnina.MailSender.Services;

namespace ProdajaNekretnina.MailSender.Controllers
{
    [ApiController] 
    [Route("[controller]")] 
    public class SendEmailController : ControllerBase
    {
        private readonly IEmailService EmailService;
        private readonly IMailSenderService MailSender;
        public SendEmailController(IEmailService emailService, IMailSenderService mailSenderService)
        {
            EmailService = emailService;
            MailSender = mailSenderService;
        }

        [HttpGet("MailPublisher")]
        public async Task<IActionResult> MailPublisher([FromQuery] string poruka, [FromQuery] List<string> sendTo)
        {
            try
            {
                await EmailService.SendMessage(poruka, sendTo);
                return Ok("Poruka poslana.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }


        }
    }

}
