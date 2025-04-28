using AutoMapper;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.NekretnineStateMachine
{
    public class InitialNekretninaState : BaseState
    {
        public InitialNekretninaState(IServiceProvider serviceProvider, Database.SeminarskiNekretnineContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Nekretnina> Insert(NekretnineInsertRequest request)
        {
            //TODO: EF CALL
            var set = _context.Set<Database.Nekretnina>();

            var entity = _mapper.Map<Database.Nekretnina>(request);

            entity.StateMachine = "draft";

            set.Add(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Nekretnina>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Insert");

            return list;
        }
    }
}
