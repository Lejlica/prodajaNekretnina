using AutoMapper;
using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.NekretnineStateMachine
{
    public class ActiveNekretninaState : BaseState
    {
        public ActiveNekretninaState(IServiceProvider serviceProvider, Database.SeminarskiNekretnineContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Nekretnina> Hide(int id)
        {
            var set = _context.Set<Database.Nekretnina>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "draft";

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Nekretnina>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Hide");

            return list;
        }
    }
}
