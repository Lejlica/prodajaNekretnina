using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class TipNekretnineData
    {
        public static void SeedData(this EntityTypeBuilder<TipNekretnine> entity)
        {
            entity.HasData(
                new TipNekretnine
                {
                    TipNekretnineId = 1,
                    NazivTipa = "Stan",
                    OpisTipa="Za stanovanje"

                },
                new TipNekretnine
                {
                    TipNekretnineId = 2,
                    NazivTipa = "Kuca",
                    OpisTipa = "Za stanovanje"
                },
                new TipNekretnine
                {
                    TipNekretnineId = 3,
                    NazivTipa = "Poslovni prostor",
                    OpisTipa = "Za poslovanje"
                },
                new TipNekretnine
                {
                    TipNekretnineId = 4,
                    NazivTipa = "Zemljiste",
                    OpisTipa = "Za gradnju"
                },
                new TipNekretnine
                {
                    TipNekretnineId = 5,
                    NazivTipa = "Apartman",
                    OpisTipa = "Za iznajmljivanje"
                }


            );
        }
    }
}
