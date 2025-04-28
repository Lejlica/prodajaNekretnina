using Newtonsoft.Json;
using PayPal.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using ProdajaNekretnina.Model;
using System.Net.Http.Headers;
using PayPal;
using IdentityModel.Client;
using System.Web.Http.Results;
using ProdajaNekretnina.PayPalRequests;
using ProdajaNekretnina.PayPalResponses;

namespace ProdajaNekretnina.Services
{
    public class PayPalService
    {
        private HttpClient _client;
        private void CreateClient()
        {
            _client = new HttpClient();
        }
        private void EnsureClientCreated()
        {
            if (_client == null)
                CreateClient();
        }
        private readonly string clientId = "AYPd-vE8xgrhBxsiIUPpd5hfmW235FoxltVoyJU2qjEg8JA3AJ7MrWddt2J91eFfqXMo6PXXYslSkpU-";
        private readonly string clientSecret = "EB7gOhq78ALkCuliJUNikwKGyOKUDejGeR0YoETbFAkFIwfr_-iv6jkHbaDteDEgZAZUCrCO4pm42ReK";
        private readonly string redirectUri = "https://example.com/callback";
        private readonly string baseUrl= " https://api-m.sandbox.paypal.com";

        //public async string GetAuthorizationUrl()
        public async Task<AuthorizationResponseDataPayPal> GetAuthorizationRequest()
        {
            /*var authUrl = $"https://www.paypal.com/signin/authorize" +
                          $"?client_id={clientId}" +
                          $"&response_type=code" +
                          $"&scope={HttpUtility.UrlEncode("openid profile email")}" +
                          $"&redirect_uri={HttpUtility.UrlEncode(redirectUri)}";

            return authUrl;*/

            EnsureClientCreated();
            var byteArray = Encoding.ASCII.GetBytes($"{clientId}:{clientSecret}");
            _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var keyValuePairs = new List<KeyValuePair<string, string>> { new KeyValuePair<string, string>("grant_type", "client_credentials") };

            var response = await _client.PostAsync($"{baseUrl}/v1/oauth2/token", new FormUrlEncodedContent(keyValuePairs));

            var responseAsString = await response.Content.ReadAsStringAsync();

            var authorizationResponse = JsonConvert.DeserializeObject<AuthorizationResponseDataPayPal>(responseAsString);
            return authorizationResponse;
        }

        public async Task<string> GetAccessToken(string receivedCode)
        {
            var tokenEndpoint = "https://api.paypal.com/v1/oauth2/token";  // Promijeni na sandbox ako koristiš testni okoliš

            var tokenRequest = new Dictionary<string, string>
        {
            { "grant_type", "authorization_code" },
            { "code", receivedCode },
            { "redirect_uri", redirectUri },
        };

            using (var httpClient = new HttpClient())
            {
                var tokenResponse = await httpClient.PostAsync(tokenEndpoint, new FormUrlEncodedContent(tokenRequest));
                var tokenJson = await tokenResponse.Content.ReadAsStringAsync();
                var tokenData = JsonConvert.DeserializeObject<PayPalTokenResponse>(tokenJson);

                return tokenData.access_token;
            }
        }

        public void SetToken(string token)
        {
            _client.SetBearerToken(token);
          
        }

        public async void PostaviToken()
        {
            var authResponse = await GetAuthorizationRequest(); 

            
            string accessToken = authResponse.access_token;

            SetToken(authResponse.access_token);

            
        }

        //public async Task<string> GenerateRedirectUrl(string accessToken, string clientId)
        //{
        //    using (var httpClient = new HttpClient())
        //    {
        //        httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

        //        var userInfoResponse = await httpClient.GetAsync("https://api.paypal.com/v2/identity/oauth2/userinfo");

        //        if (userInfoResponse.IsSuccessStatusCode)
        //        {
        //            var userInfoJson = await userInfoResponse.Content.ReadAsStringAsync();
        //            var userInfo = JsonConvert.DeserializeObject<PayPalUserInfo>(userInfoJson);

        //            // Konstruiši URL za redirekciju prema potrebama tvoje aplikacije
        //            var redirectUrl = $"https://tvoj_server.com/redirect?userId={userInfo.UserId}";

        //            return redirectUrl;
        //        }
        //        else
        //        {
        //            // Obradi grešku ako dođe do problema sa dobijanjem korisničkih informacija
        //            throw new Exception($"Neuspješan zahtjev za UserInfo: {userInfoResponse.StatusCode}");
        //        }
        //    }
        //}

        public async Task<string> GenerateRedirectUrl()
        {
            string clientId = "APP-80W284485P519543T";
            string accessToken = "A21AAIOu7p9nLRkCVRTs_q3l6OeEUtVvtrsyO59-tRbk1lnt3bUmjcq1dKJAPtKYsybGZfjr--vKu00HdZU2DNDwtQ5JiyLZA";
            using (var httpClient = new HttpClient())
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

                var userInfoResponse = await httpClient.GetAsync("https://api.paypal.com/v2/identity/oauth2/userinfo");

                if (userInfoResponse.IsSuccessStatusCode)
                {
                    var userInfoJson = await userInfoResponse.Content.ReadAsStringAsync();
                    var userInfo = JsonConvert.DeserializeObject<PayPalUserInfo>(userInfoJson);

                    // Konstruiši URL za redirekciju prema potrebama tvoje aplikacije
                    var redirectUrl = $"https://tvoj_server.com/redirect?userId={userInfo.UserId}";

                    return redirectUrl;
                }
                else
                {
                    // Obradi grešku ako dođe do problema sa dobijanjem korisničkih informacija
                    throw new Exception($"Neuspješan zahtjev za UserInfo: {userInfoResponse.StatusCode}");
                }
            }
        }

        public async Task<CreatePlanResponse> CreatePlan(CreatePlanRequest request)
        {
            EnsureClientCreated();

            var requestContent = JsonConvert.SerializeObject(request);

            var httpRequestMessage = new HttpRequestMessage
            {
                Content = new StringContent(requestContent, Encoding.UTF8, "application/json")
            };

            httpRequestMessage.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var response = await _client.PostAsync($"{baseUrl}/v1/billing/plans", httpRequestMessage.Content);

            var responseAsString = await response.Content.ReadAsStringAsync();

            var result = JsonConvert.DeserializeObject<CreatePlanResponse>(responseAsString);

            return result;
        }
 

public async Task<CreatePlanResponse> GetPlanDetails(string planId)
        {
            EnsureClientCreated();

            var response = await _client.GetAsync($"{baseUrl}/v1/billing/plans/{planId}");

            var responseAsString = await response.Content.ReadAsStringAsync();

            var result = JsonConvert.DeserializeObject<CreatePlanResponse>(responseAsString);

            return result;
        }


        public Payment ExecutePayment(string paymentId, string payerId)
        {
            var config = new Dictionary<string, string> { { "mode", "sandbox" } };
            var accessToken = new OAuthTokenCredential(clientId, clientSecret, config).GetAccessToken();

            var apiContext = new APIContext(accessToken);
            var paymentExecution = new PaymentExecution() { payer_id = payerId };
            var payment = new Payment() { id = paymentId };

            return payment.Execute(apiContext, paymentExecution);
        }

        

        public string CreatePayment(decimal amount, string currency, string returnUrl, string cancelUrl)
        {
            try
            {
                // Dobavi pristupni token pre nego što napraviš API poziv
                var accessToken = GetPayPalAccessToken();

                // Sada koristi accessToken u zaglavlju za autorizaciju API poziva
                var apiContext = new APIContext(accessToken);

                // Kreiraj plaćanje
                var payment = new Payment
                {
                    intent = "order",
                    payer = new Payer { payment_method = "paypal" },
                    transactions = new List<Transaction>
                {
                    new Transaction
                    {
                        amount = new Amount
                        {
                            currency = currency,
                            total = amount.ToString("0.00"),
                        },
                        description = "Opis transakcije",
                    }
                },
                    redirect_urls = new RedirectUrls
                    {
                        return_url = returnUrl,
                        cancel_url = cancelUrl
                    }
                };

                var createdPayment = payment.Create(apiContext);

                // Nastavi sa obradom rezultata, ovo može biti zavisno od tvojih potreba
                // Na primer, možeš čuvati createdPayment.id ili nešto drugo

                return createdPayment.links.First(link => link.rel.Equals("approval_url")).href;
            }
            catch (PayPal.PayPalException ex)
            {
                // Obradi grešku
                Console.WriteLine($"PayPal Error: {ex.Message}");
                throw; // Propagiraj grešku nazad ka kontroleru
            }
        }

        public async Task CreateProduct(Product product)
        {
            using (var httpClient = new HttpClient())
            {
                var apiEndpoint = "https://api-m.paypal.com/v1/catalogs/products";

                var authResponse = await GetAuthorizationRequest();
                

                // Dodaj sandbox token (moraš ga prethodno dobiti)
                var accessToken = authResponse.access_token;
                httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {accessToken}");

                // Pretvori proizvod u JSON
                var productJson = JsonConvert.SerializeObject(product);

                // Pošalji POST zahtjev za stvaranje proizvoda
                var response = await httpClient.PostAsync(apiEndpoint, new StringContent(productJson));

                if (response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Proizvod uspješno stvoren.");
                }
                else
                {
                    Console.WriteLine($"Neuspješno stvaranje proizvoda. Kod odgovora: {response.StatusCode}");
                }
            }
        }

        private string GetPayPalAccessToken()
        {
            var config = new Dictionary<string, string> { { "mode", "sandbox" } };
            var accessToken = new OAuthTokenCredential(clientId, clientSecret, config).GetAccessToken();
            return accessToken;
        }

        public Payment GetPayment(string paymentId)
        {
            var apiContext = new APIContext(clientId);
            apiContext.Config = new Dictionary<string, string> { { "mode", "sandbox" } };

            var payment = Payment.Get(apiContext, paymentId);
            return payment;
        }


    }
}
