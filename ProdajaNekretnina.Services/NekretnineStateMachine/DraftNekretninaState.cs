using AutoMapper;
using Microsoft.Extensions.Logging;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.NekretnineStateMachine
{
    public class DraftNekretninaState : BaseState
    {
        protected ILogger<DraftNekretninaState> _logger;
        public DraftNekretninaState(ILogger<DraftNekretninaState> logger, IServiceProvider serviceProvider, Database.SeminarskiNekretnineContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _logger = logger;
        }

        public override async Task<Nekretnina> Update(int id, NekretnineUpdateRequest request)
        {
            var set = _context.Set<Database.Nekretnina>();

            var entity = await set.FindAsync(id);

            _mapper.Map(request, entity);

            if (entity.Cijena < 0)
            {
                throw new Exception("Cijena ne moze biti u minusu");
            }



            if (entity.Cijena < 1)
            {
                throw new UserException("Cijena ispod minimuma");
            }




            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Nekretnina>(entity);
        }

        public override async Task<Nekretnina> Activate(int id)
        {
            _logger.LogInformation($"Aktivacija proizvoda: {id}");

            _logger.LogWarning($"W: Aktivacija proizvoda: {id}");

            _logger.LogError($"E: Aktivacija proizvoda: {id}");

            var set = _context.Set<Database.Nekretnina>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();


            //var factory = new ConnectionFactory { HostName = "localhost" };
            //using var connection = factory.CreateConnection();
            //using var channel = connection.CreateModel();


            //string message = "";

            ////JSON$"{entity.ProizvodId}, {entity.Sifra}, {entity.Naziv}";
            //var body = Encoding.UTF8.GetBytes(message);

            //channel.BasicPublish(exchange: string.Empty,
            //                     routingKey: "product_added",
            //                     basicProperties: null,
            //                     body: body);

            var mappedEntity = _mapper.Map<Model.Nekretnina>(entity);

            //using var bus = RabbitHutch.CreateBus("host=localhost");

            //bus.PubSub.Publish(mappedEntity);

            return mappedEntity;
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Update");
            list.Add("Activate");

            return list;
        }
    }
}
