using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class StatusData
    {
        public static void SeedData(this EntityTypeBuilder<Status> entity)
        {
            entity.HasData(
                new Status
                {
                    StatusId = 1,
                    Opis = "U toku",
                   

                },
                new Status
                {
                    StatusId = 2,
                    Opis = "Procesiran",
                   
                },
                new Status
                {
                    StatusId = 3,
                    Opis = "Zavrsen",
                  
                },
                new Status
                {
                    StatusId = 4,
                    Opis = "Na cekanju",
                   
                }
                


            );
        }
    }
}
