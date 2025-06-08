using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services
{
    public class KupovinaService : BaseCRUDService<Model.Kupovina, Database.Kupovina, KupovinaSearchObject, KupovinaInsertRequest, KupovinaUpdateRequest>, IKupovinaService
    {
        public KupovinaService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
        }

        

        public async Task<Model.Kupovina> UpdateIsPaid(int id, bool isPaid)
        {
            var reservation = await base.GetById(id);

            if (reservation != null)
            {
                var updateRequest = new KupovinaUpdateRequest
                {
                    KorisnikId = reservation.KorisnikId,
                    IsConfirmed = reservation.IsConfirmed,
                    IsPaid = isPaid,
                    Price = reservation.Price,
   
                    PayPalPaymentId = reservation.PayPalPaymentId,
                };
                await base.Update(id, updateRequest);
            }
            return reservation;
        }

        public async Task<Model.Kupovina> UpdateIsConfirmed(int id, bool isConfirmed)
        {
            var reservation = await base.GetById(id);

            if (reservation != null)
            {
                var updateRequest = new KupovinaUpdateRequest
                {
                    KorisnikId = reservation.KorisnikId,
                    IsConfirmed = isConfirmed,
                    IsPaid = reservation.IsPaid,
                    Price = reservation.Price,
                    
                    PayPalPaymentId = reservation.PayPalPaymentId,
                };
                await base.Update(id, updateRequest);
            }
            return reservation;
        }
        public async Task<Model.Kupovina> CreateKupovina(int korisnikId, decimal price,int nekretninaId)
        {
            var newKupovina = new KupovinaInsertRequest
            {
                KorisnikId = korisnikId,
                NekretninaId=nekretninaId,
                Price = price,
                IsConfirmed = false,  // dok nije potvrđeno
                IsPaid = false,       // dok nije plaćeno
                PayPalPaymentId = null
            };

            var insertedKupovina = await base.Insert(newKupovina);
            return insertedKupovina;
        }


        public async Task<Model.Kupovina> AddPayPalPaymentId(int nekretninaId, string payPalPaymentId)
        {
            var kupovina = await _context.Kupovine
    .Include(k => k.Nekretnina)
    .Include(k => k.Korisnik)
    .FirstOrDefaultAsync(k => k.NekretninaId == nekretninaId);


            if (kupovina == null)
                throw new Exception("Kupovina nije pronađena za dati nekretninaId ili je već plaćena.");

            // 2. Pripremi update request
            var updateRequest = new KupovinaUpdateRequest
            {
                KorisnikId = kupovina.KorisnikId,
                NekretninaId = nekretninaId,
                IsConfirmed = true,
                IsPaid = true,  // postavi na plaćeno
                Price = kupovina.Price,
                PayPalPaymentId = payPalPaymentId
            };

            // 3. Update po primarnom ključu (kupovina.Id)

           
                await base.Update(kupovina.KupovinaId, updateRequest);
      
            

            // 4. Vrati ažuriranu kupovinu (možeš opet dohvatiti iz baze ako treba)
            return await base.GetById(kupovina.KupovinaId);
        }
    }
}

