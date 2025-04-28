using AutoMapper;
using Azure.Core;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;


namespace ProdajaNekretnina.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
       
        public BaseCRUDService(SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
           
        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }

        /*[HttpGet]
        public virtual async Task<bool> CheckPassword([FromBody] string password)
        {
            

            var authHeader = AuthenticationHeaderValue.Parse(_httpContext.Request.Headers["Authorization"]);
            var credentialsBytes = Convert.FromBase64String(authHeader.Parameter);
            var credentials = Encoding.UTF8.GetString(credentialsBytes).Split(':');

            var username = credentials[0];
            var passwordd = credentials[1];

            if (password == passwordd)
                return true;
            else
                return false;
        }*/


        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();

            var entity = await set.FindAsync(id);

            _mapper.Map(update, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);


        }
       
        public virtual async Task<T> Delete(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            if (entity != null)
            {
                _context.Set<TDb>().Remove(entity);
                await _context.SaveChangesAsync();
            }

            // Return a completed task without a value
            return await Task.FromResult(default(T));
        }






    }

}

