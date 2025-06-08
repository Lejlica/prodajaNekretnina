using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ProdajaNekretnina.Model;

namespace ProdajaNekretnina.Services
{
    public interface IKupovinaService : ICRUDService<Model.Kupovina, Model.SearchObjects.KupovinaSearchObject, Model.Requests.KupovinaInsertRequest, Model.Requests.KupovinaUpdateRequest>
    {
       
        public Task<Model.Kupovina> UpdateIsConfirmed(int id, bool isConfirmed);
        public Task<Model.Kupovina> UpdateIsPaid(int id, bool isPaid);

        public Task<Model.Kupovina> AddPayPalPaymentId(int id, string payPalPaymentId);


    }
}
