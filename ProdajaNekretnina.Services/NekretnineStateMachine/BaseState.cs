using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services.NekretnineStateMachine
{
    public class BaseState
    {
        protected SeminarskiNekretnineContext _context;
        protected IMapper _mapper { get; set; }
        public IServiceProvider _serviceProvider { get; set; }
        public BaseState(IServiceProvider serviceProvider, SeminarskiNekretnineContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.Nekretnina> Insert(NekretnineInsertRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Nekretnina> Update(int id, NekretnineUpdateRequest request)
        {
            throw new UserException("Not allowed");
        }



        public virtual Task<Model.Nekretnina> Activate(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Nekretnina> Hide(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Nekretnina> Delete(int id)
        {
            throw new UserException("Not allowed");
        }

        public BaseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                case null:
                    return _serviceProvider.GetService<InitialNekretninaState>();
                    break;
                case "draft":
                    return _serviceProvider.GetService<DraftNekretninaState>();
                    break;
                case "active":
                    return _serviceProvider.GetService<ActiveNekretninaState>();
                    break;

                default:
                    throw new UserException("Not allowed");
            }
        }

        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }

    }
}
