using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class GradData
    {
        public static void SeedData(this EntityTypeBuilder<Grad> entity)
        {
            entity.HasData(
                new Grad
                {
                    GradId=1,
                    DrzavaId = 1,
                    Naziv = "Mostar"


                },
                new Grad
                {
                    GradId = 2,
                    DrzavaId = 1,
                    Naziv = "Sarajevo"

                },
                new Grad
                {
                    GradId = 3,
                    DrzavaId = 1,
                    Naziv = "Tuzla"

                },
                new Grad
                {
                    GradId = 4,
                    DrzavaId = 2,
                    Naziv = "Rijad"

                }




            );
        }
    }
}
