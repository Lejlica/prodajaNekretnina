using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PayPal.Api;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.PayPalRequests;
using ProdajaNekretnina.PayPalResponses;
using ProdajaNekretnina.Services;

namespace ProdajaNekretnina.Controllers
{
    [ApiController]
    [Route("api/paypal")]
    public class PayPalController : ControllerBase
    {
        private readonly PayPalService _payPalService;

        public PayPalController(PayPalService payPalService)
        {
            _payPalService = payPalService;
        }

        /* [HttpGet("authorization-url")]
         public ActionResult<string> GetAuthorizationUrl()
         {
             return _payPalService.GetAuthorizationUrl();
         }*/

        [HttpGet] //get access token
        public Task<AuthorizationResponseDataPayPal> GetAuthorizationRequest()
        {
            return _payPalService.GetAuthorizationRequest();
        }


        [AllowAnonymous]
        [HttpGet("redirect-url")]
        public async Task<string> GenerateRedirectUrl()
        {
            try
            {
                return await _payPalService.GenerateRedirectUrl();
            }
            
            catch (Exception ex)
            {
                Console.WriteLine($"Error in GenerateRedirectUrl: {ex.Message}");
                throw; // Ovo će ponovno baciti iznimku kako bi se prikazala na Swaggeru
            }

            return await Task.FromResult<string>("");

        }

        

        [HttpPost("payment-generated")]
        public async Task<CreatePlanResponse> PaymentGenerated()
        {
            var product = new Product()
            {
                id = "PROD-XYAB12ABSB7868434",
                name = "Video Streaming Service",
                description = "Video streaming service",
                type = "SERVICE",
                category = "SOFTWARE",
                image_url = "https://example.com/streaming.jpg",
                home_url = "https://example.com/home",
                create_time = "2019-01-10T21:20:49Z",
                update_time = "2019-01-10T21:20:49Z",
                links = new List<Link>
    {
        new Link
        {
            href = "https://api-m.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173",
            rel = "self",
            method = "GET"
        },
        new Link
        {
            href = "https://api-m.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173",
            rel = "edit",
            method = "PATCH"
        }
    }
            };

           _payPalService.CreateProduct(product);

            var trialBillingCycle = new BillingCycle()
            {
                frequency = new Frequency()
                {
                    interval_unit = "MONTH",
                    interval_count = 1,
                },
                tenure_type = "TRIAL",
                sequence = 1,
                total_cycles = 1,
                pricing_scheme = new PricingScheme()
                {
                    fixed_price = new FixedPrice()
                    {
                        currency_code = "USD",
                        value = "10.00"
                    }
                }

            };
            var regularBillingCycle = new BillingCycle()
            {

                frequency = new Frequency()
                {
                    interval_unit = "MONTH",
                    interval_count = 1,
                },
                tenure_type = "REGULAR",
                sequence = 2,
                total_cycles = 0,
                pricing_scheme = new PricingScheme()
                {
                    fixed_price = new FixedPrice()
                    {
                        currency_code = "USD",
                        value = "100.00"
                    }
                }
            };

            var createPlanRequest = new CreatePlanRequest()
            {
                product_id = "APP-80W284485P519543T", //Product Id
                name = "Technical Voice Plan",
                description = "Technical Voice Plan",
                status = "ACTIVE",
                billing_cycles = new List<BillingCycle>()
                            {
                                trialBillingCycle,
                                regularBillingCycle
                            },
                payment_preferences = new PaymentPreferences()
                {
                    auto_bill_outstanding = true,
                    setup_fee = new SetupFee()
                    {
                        currency_code = "USD",
                        value = "0"
                    },
                    setup_fee_failure_action = "CONTINUE",
                    payment_failure_threshold = 3
                }

            };
            var authResponse = await _payPalService.GetAuthorizationRequest();
            _payPalService.SetToken(authResponse.access_token);
            var createPlanResponse = await _payPalService.CreatePlan(createPlanRequest);

            return createPlanResponse;
        }


        [HttpPost("access-token")]
        public async Task<ActionResult<string>> GetAccessToken([FromBody] string authorizationCode)
        {
            return await _payPalService.GetAccessToken(authorizationCode);
        }

        [HttpPost("create-payment")]
        public ActionResult<string> CreatePayment(decimal amount, string currency, string returnUrl, string cancelUrl)
        {
            return _payPalService.CreatePayment(amount, currency, returnUrl, cancelUrl);
        }
    }

}
