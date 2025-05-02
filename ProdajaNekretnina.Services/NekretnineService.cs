

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

namespace ProdajaNekretnina.Services
{
    public class NekretnineService : BaseCRUDService<Model.Nekretnina, Database.Nekretnina, NekretnineSearchObject, NekretnineInsertRequest, NekretnineUpdateRequest>, INekretnineService
    {
        public BaseState _baseState { get; set; }
        public NekretnineService(BaseState baseState, SeminarskiNekretnineContext context, IMapper mapper) : base(context, mapper)
        {
            _baseState = baseState;
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
            if (search?.tipNekretnineId == 1)
            {
                filteredQuery = filteredQuery.Where(x => x.TipNekretnineId == 1);
            }
            if (search?.tipNekretnineId == 7)
            {
                filteredQuery = filteredQuery.Where(x => x.TipNekretnineId == 7);
            }
            if (search?.tipNekretnineId == 8)
            {
                filteredQuery = filteredQuery.Where(x => x.TipNekretnineId == 8);
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
            var entity = await _context.Nekretninas.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Activate(id);
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



        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public static ProductEntry ConvertNekretninaToProductEntry(ProdajaNekretnina.Services.Database.Nekretnina nekretnina)
        {
            return new ProductEntry
            {
                NekretninaId = (uint)nekretnina.NekretninaId,
                /*IsOdobrena = nekretnina.IsOdobrena ? true : false,
                KorisnikId = nekretnina.KorisnikId,
                TipNekretnineId = nekretnina.TipNekretnineId,
                KategorijaId = nekretnina.KategorijaId,*/
                LokacijaId = nekretnina.LokacijaId,
                /*DatumDodavanja = nekretnina.DatumDodavanja,
                DatumIzmjene = nekretnina.DatumIzmjene,
                Cijena = nekretnina.Cijena,
                Kvadratura = nekretnina.Kvadratura,
                BrojSoba = nekretnina.BrojSoba,
                BrojSpavacihSoba = nekretnina.BrojSpavacihSoba,
                Namjesten = nekretnina.Namjesten ? true : false,
                Novogradnja = nekretnina.Novogradnja ? true : false,
                Sprat = nekretnina.Sprat,
                ParkingMjesto = nekretnina.ParkingMjesto ? true : false,
                BrojUgovora = nekretnina.BrojUgovora,
                DetaljanOpis = nekretnina.DetaljanOpis,*/
                // Add more properties if needed...
            };
        }
        [AllowAnonymous]

        public List<Model.Nekretnina> Recommend(int userId)
        {
            MLContext mlContext = new MLContext();

            var tmpData = _context.Nekretninas.Include("KorisnikNekretninaWishs").ToList();
            var data = new List<ProductEntry>();

            // Convert your data to ML.NET compatible format
            foreach (var nekretnina in tmpData)
            {
                data.Add(new ProductEntry
                {
                    NekretninaId = (uint)nekretnina.NekretninaId,
                    LokacijaId = nekretnina.LokacijaId,
                    // Add other properties...
                });
            }

            var trainData = mlContext.Data.LoadFromEnumerable(data);

            var pipeline = mlContext.Transforms.Conversion.MapValueToKey("NekretninaId", "NekretninaId")
    .Append(mlContext.Transforms.Conversion.MapValueToKey("LokacijaId", "LokacijaId"));


            var model = pipeline.Fit(trainData);

            // Make recommendations for a specific user (replace userId with the desired user's id)
            //var userId = 3; // Replace with the actual user id
            var recommendations = GetRecommendations(mlContext, model, tmpData, userId);

            // Add the recommendations to the RecommendResults table or use them as needed
            foreach (var recommendation in recommendations)
            {
                // Assuming you have a RecommendResult model/entity
                var recommendResult = new ProdajaNekretnina.Services.Database.ReccomendResult
                {

                    PrvaNekretninaId = recommendation.PrvaNekretninaId,
                    DrugaNekretninaId = recommendation.DrugaNekretninaId,
                    TrecaNekretninaId = recommendation.TrecaNekretninaId,
                    KorisnikId = userId
                    // Add more properties if needed...
                };

                // Assuming your context is named _context
                _context.ReccomendResults.Add(recommendResult);
            }

            // Save changes to the database
            _context.SaveChanges();


            // Return the recommended Nekretnina instances
            return recommendations.Select(r => new Model.Nekretnina
            {
                NekretninaId = (int)r.PrvaNekretninaId, // Use the appropriate property here
                                                        // Map other properties as needed...
            }).ToList();
        }

        List<ReccomendResult> GetRecommendations(MLContext context, ITransformer model, List<ProdajaNekretnina.Services.Database.Nekretnina> data, int userId)
        {
            //var predictionEngine = context.Model.CreatePredictionEngine<ProductEntry, ReccomendResult>(model);

        //    var userWishlist = _context.KorisnikNekretninaWishes
        //        .Where(w => w.KorisnikId == userId)
        //        .OrderBy(n => n.NekretninaId)
        //.Select(n => n.NekretninaId)
        //        .ToList();

            var userWishlist = _context.KorisnikNekretninaWishes
                .Where(w => w.KorisnikId == userId).OrderByDescending(x => x.KorisnikNekretninaWishId).Select(x => x.NekretninaId).ToList();





            var unseenNekretnine = data
    .Where(nek => !userWishlist.Contains(nek.NekretninaId))
    .ToList();

            List<int> allLocationIds = new List<int>();
            for (int i = 0; i < userWishlist.Count; i++)
            {
                var lokacijaIds = data.Where(n => n.NekretninaId == userWishlist[i]).Select(n => n.LokacijaId);
                allLocationIds.AddRange(lokacijaIds);
                Console.WriteLine($"userWishNekId: {userWishlist[i]}");
            }

            List<int> gotove = new List<int>();
            List<Database.Nekretnina> gg;
            foreach (var item in allLocationIds)
            {
                var gotoveIds = data.Where(n => n.LokacijaId == item).Select(n => n.NekretninaId);
                gotove.AddRange(gotoveIds);
                // gg = data.Where(n => n.LokacijaId == item).ToList();
                Console.WriteLine($"LokacijaId: {item}, NekretninaIds: {string.Join(", ", gotoveIds)}");

            }





            var recommendations = new List<ReccomendResult>();

            /*foreach (var nekretnina in unseenNekretnine)
            {
                var productEntry = ConvertNekretninaToProductEntry(nekretnina);
                var prediction = predictionEngine.Predict(productEntry);

                recommendations.Add(new ReccomendResult
                {
                    NekretninaId= prediction.NekretninaId,
                    PrvaNekretninaId = prediction.PrvaNekretninaId,
                    DrugaNekretninaId = prediction.DrugaNekretninaId,
                    TrecaNekretninaId = prediction.TrecaNekretninaId,
                    // Add more properties if needed...
                });
            }*/

            for (int i = 0; i < Math.Min(gotove.Count, 4); i++)
            {
                recommendations.Add(new ReccomendResult
                {
                    NekretninaId = gotove[i],
                    // Prilagodite ovo prema vašim potrebama
                    PrvaNekretninaId = gotove[(i + 1) % gotove.Count], // Zaokruživanje na početak ako smo došli do kraja liste
                    DrugaNekretninaId = gotove[(i + 2) % gotove.Count],
                    TrecaNekretninaId = gotove[(i + 3) % gotove.Count],
                    KorisnikId = userId
                    // Dodajte još svojstava ako je potrebno...
                });
            }
            return recommendations;
        }



        /*lock (isLocked)
        {
            if (mlContext == null)
            {
                mlContext = new MLContext();
                var tmpData = _context.Nekretninas.Include("KorisnikNekretninaWishs").ToList();

                //var tmpData = _context.Nekretninas.ToList();

                var data = new List<ProductEntry>();


                foreach (var x in tmpData)
                {
                    if (tmpData.Count > 1)
                    {

                        var distinctItemId = tmpData.Select(y => y.NekretninaId).ToList();
                        var targetNekretnina = tmpData.FirstOrDefault(x => x.NekretninaId == id);
                        var distinctItemLocation = targetNekretnina?.LokacijaId;


                        distinctItemId.ForEach(y =>
                        {
                            var relatedItems = tmpData.Where(z =>  z.LokacijaId == distinctItemLocation);

                            foreach (var z in relatedItems)
                            {
                                data.Add(new ProductEntry()
                                {
                                    ProductID = (uint)y,
                                    CoPurchaseProductID = (uint)z.NekretninaId,
                                });
                            }
                        });
                    }
                }








                var traindata = mlContext.Data.LoadFromEnumerable(data);
                Console.WriteLine($"Count traindata: {traindata.GetColumn<float>("Label").Count()}");

                //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
                //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
                MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                options.LabelColumnName = "Label";
                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                options.Alpha = 0.01;
                options.Lambda = 0.025;
                // For better results use the following parameters
                options.NumberOfIterations = 100;
                options.C = 0.00001;

                var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                model = est.Fit(traindata);

            }
        }




        //prediction

        var products = _context.Nekretninas.Where(x => x.NekretninaId != id);

        var predictionResult = new List<Tuple<Database.Nekretnina, float>>();

        foreach (var product in products)
        {

            var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
            var prediction = predictionengine.Predict(
                                     new ProductEntry()
                                     {
                                         ProductID = (uint)id,
                                         CoPurchaseProductID = (uint)product.NekretninaId
                                     });


            predictionResult.Add(new Tuple<Database.Nekretnina, float>(product, prediction.Score));
        }


        var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

        return _mapper.Map<List<Model.Nekretnina>>(finalResult);*/

    }


}

public class Copurchase_prediction
{
    public float Score { get; set; }
}

public class ProductEntry
{
    [KeyType(count: 100)] // Postavite odgovarajući broj ovisno o vašim podacima
    [LoadColumn(0)]
    public uint NekretninaId;

    [LoadColumn(5)]
    public int LokacijaId;
}
