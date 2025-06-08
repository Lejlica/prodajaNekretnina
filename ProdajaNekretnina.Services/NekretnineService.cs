

using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using ProdajaNekretnina.Services.NekretnineStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using ProdajaNekretnina.Model;
using Nekretnina = ProdajaNekretnina.Model.Nekretnina;
using ReccomendResult = ProdajaNekretnina.Model.ReccomendResult;
using PayPal.Api;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ProdajaNekretnina.Services
{
    public class NekretnineService : BaseCRUDService<Model.Nekretnina, Database.Nekretnina, NekretnineSearchObject, NekretnineInsertRequest, NekretnineUpdateRequest>, INekretnineService
    {
        public BaseState _baseState { get; set; }
      

        public NekretnineService(BaseState baseState, SeminarskiNekretnineContext context, IMapper mapper)
            : base(context, mapper)
        {
            _baseState = baseState;
           
        }
        public class EmailModel
        {
            public string Sender { get; set; }
            public string Recipient { get; set; }
            public string Subject { get; set; }
            public string Content { get; set; }
        }
      

        /*public override IQueryable<Database.Nekretnina> AddInclude(IQueryable<Database.Nekretnina> query, NekretnineSearchObject? search = null)
        {
            query = query.Include("Slikas");

            return base.AddInclude(query, search);
        }*/
        /*public override IQueryable<Nekretnina> AddInclude(IQueryable<Nekretnina> query, NekretnineSearchObject? search = null)
        {
            if (search?.nazivTipa == true)
            {
                query = query.Include("Kategorija");
            }
            return base.AddInclude(query, search);
        }*/

        public override IQueryable<Database.Nekretnina> AddFilter(IQueryable<Database.Nekretnina> query, NekretnineSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.CijenaOd != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Cijena >= search.CijenaOd.Value);
            }

            if (search?.CijenaDo != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Cijena <= search.CijenaDo.Value);
            }

            if (search?.kvadratura != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Kvadratura >= search.kvadratura.Value);
            }


            if (search?.Grad != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Lokacija.Grad.Naziv == search.Grad);
            }
            if (search?.Vlasnik != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime == search.Vlasnik);
            }
            if (search?.isOdobrena == true)
            {
                filteredQuery = filteredQuery.Where(x => x.IsOdobrena == search.isOdobrena);
            }
            if (search?.tipNekretnineId != null && search?.tipNekretnineId!=-1)
            {
                filteredQuery = filteredQuery.Where(x => x.TipNekretnineId == search.tipNekretnineId);
            }
            if (search?.kvadratura != null && search?.kvadratura != 0)
            {
                filteredQuery = filteredQuery.Where(x => x.Kvadratura == search.kvadratura);
            }

            return filteredQuery;
        }

        public override Task<Model.Nekretnina> Insert(NekretnineInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");

            return state.Insert(insert);

        }

        public override async Task<Model.Nekretnina> Update(int id, NekretnineUpdateRequest update)
        {
            var entity = await _context.Nekretninas.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Update(id, update);
        }

        public async Task<Model.Nekretnina> Activate(int id)
        {
            var entity = await _context.Nekretninas
                .Include(n => n.Korisnik)
                .FirstOrDefaultAsync(n => n.NekretninaId == id);

            var state = _baseState.CreateState(entity.StateMachine);
            var result = await state.Activate(id);

           

            return result;
        }


        public async Task<Model.Nekretnina> Hide(int id)
        {
            var entity = await _context.Nekretninas.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Hide(id);
        }

        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Nekretninas.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "initial");
            return await state.AllowedActions();
        }



        

        public List<Model.Nekretnina> RecommendNekretnina(int userId)
        {
            var korisnickeZelje = _context.KorisnikNekretninaWishes
                .Include(x => x.Nekretnina.Lokacija.Grad)
                .Where(x => x.KorisnikId == userId)
                .Select(x => x.Nekretnina)
                .ToList();

            if (korisnickeZelje.Count == 0)
                return new List<Model.Nekretnina>();

            // Uzimamo posljednju želju kao "cilj" za preporuku
            var targetWish = korisnickeZelje.Last();

            
             

             var sveNekretnine = _context.Nekretninas
                 .Include(x => x.Lokacija.Grad)
                 .ToList() 
                 .Where(x => !korisnickeZelje.Any(w => w.NekretninaId ==
            x.NekretninaId))
                 .ToList();


            // Dodajemo i target nekretninu u dataset
            var sveZaML = sveNekretnine.Append(targetWish).ToList();

            var mlContext = new MLContext();

            var podaci = sveZaML.Select(x => new NekretninePodaci
            {
                BrojSoba = x.BrojSoba,
                Cijena = x.Cijena,
                Lokacija = x.Lokacija.Grad.Naziv,
                NekretninaId = x.NekretninaId
            });

            var data = mlContext.Data.LoadFromEnumerable(podaci);

            var pipeline =
                mlContext.Transforms.Categorical.OneHotEncoding("LocationEncoded",
                "Lokacija")
                .Append(mlContext.Transforms.Concatenate("Features", "LocationEncoded",
                "BrojSoba", "Cijena"))
                .Append(mlContext.Transforms.NormalizeMinMax("Features"));

            var transformer = pipeline.Fit(data);
            var transformedData = transformer.Transform(data);

            var featuresWithId =
                mlContext.Data.CreateEnumerable<TransformedNekretnina>(transformedData,
                reuseRowObject: false).ToList();

            // Uzimamo vektor osobina za target nekretninu
            var targetVector = featuresWithId.First(x => x.NekretninaId
== targetWish.NekretninaId).Features;

            var recommendations = featuresWithId
                .Where(x => x.NekretninaId != targetWish.NekretninaId)
                .Select(x => new
                {
                    x.NekretninaId,
                    Similarity = CosineSimilarity(targetVector, x.Features)
                })
                .OrderByDescending(x => x.Similarity)
                .Take(3)
                .Select(x => x.NekretninaId)
                .ToList();

            var preporucene = sveNekretnine
                .Where(x => recommendations.Contains(x.NekretninaId))
                .ToList();

            return _mapper.Map<List<Model.Nekretnina>>(preporucene);
        }


        float CosineSimilarity(float[] a, float[] b)
        {
            float dot = 0, magA = 0, magB = 0;
            for (int i = 0; i < a.Length; i++)
            {
                dot += a[i] * b[i];
                magA += a[i] * a[i];
                magB += b[i] * b[i];
            }
            return dot / (MathF.Sqrt(magA) * MathF.Sqrt(magB));
        }

        public class NekretninePodaci
        {
            public int NekretninaId { get; set; }
            public string Lokacija { get; set; }
            public float BrojSoba { get; set; }
            public float Cijena { get; set; }
        }
        public class TransformedNekretnina
        {
            public int NekretninaId { get; set; }

            [VectorType] 
            public float[] Features { get; set; }
        }


    }
}


