using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class DrzavaData
    {
        public static void SeedData(this EntityTypeBuilder<Drzava> entity)
        {
            entity.HasData(
                new Drzava
                {
                    DrzavaId = 1,
                    Naziv = "BiH"
                    

                },
                new Drzava
                {
                    DrzavaId = 2,
                    Naziv = "Saudijska Arabija"

                }




            );
        }
    }
}
