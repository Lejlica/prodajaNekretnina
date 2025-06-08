using AutoMapper;
using IdentityModel;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Grad = ProdajaNekretnina.Model.Grad;
using Nekretnina = ProdajaNekretnina.Model.Nekretnina;

namespace ProdajaNekretnina.Services
{
    public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        protected SeminarskiNekretnineContext _context;
        protected IMapper _mapper { get; set; }
        public BaseService(SeminarskiNekretnineContext context, IMapper mapper )
        {
            _context = context;
            _mapper = mapper;
        }
        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.PageSize.Value).Take(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<T>>(list);
            result.Result = tmp;
            return result;
        }
        
        /*public virtual async Task<T?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await _context.Set<TDb>().FindAsync(id, cancellationToken);

            if (entity == null)
            {
                return null; // Ako entitet nije pronađen, možemo vratiti null
            }

            var dto = _mapper.Map<T>(entity);
            return dto;
        }*/



        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            return _mapper.Map<T>(entity);
        }
    }
}
