﻿using Azure.Core;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using ProdajaNekretnina.Services;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Text;

namespace ProdajaNekretnina
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        IKorisniciService _korisniciService;
        public BasicAuthenticationHandler(IKorisniciService korisniciService, IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock) : base(options, logger, encoder, clock)
        {
            _korisniciService = korisniciService;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
            {
                return AuthenticateResult.Fail("Missing header");
            }

            var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
            var credentialsBytes = Convert.FromBase64String(authHeader.Parameter);
            var credentials = Encoding.UTF8.GetString(credentialsBytes).Split(':');

            var username = credentials[0];
            var password = credentials[1];

            var user = await _korisniciService.Login(username, password);

            if (user == null)
            {
                return AuthenticateResult.Fail("Incorrect username or password");
            }
            else
            {


                var claims = new List<Claim>()
                {
                    new Claim(ClaimTypes.Name, user.Ime),
                    new Claim(ClaimTypes.NameIdentifier, user.KorisnickoIme)
                };

                foreach (var role in user.KorisniciUloges)
                {
                    claims.Add(new Claim(ClaimTypes.Role, role.Uloga.Naziv));
                }

                var identity = new ClaimsIdentity(claims, Scheme.Name);

                var principal = new ClaimsPrincipal(identity);

                var ticket = new AuthenticationTicket(principal, Scheme.Name);
                return AuthenticateResult.Success(ticket);
            }
        }
    }
}
