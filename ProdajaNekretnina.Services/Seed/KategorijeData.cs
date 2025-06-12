using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Seed
{
    public static class KategorijeData
    {
        public static void SeedData(this EntityTypeBuilder<Kategorije> entity)
        {
            entity.HasData(

                 new Kategorije
                 {
                     KategorijaId = 1,
                     Naziv="Samostalna jednica",
                     Opis="samostalna"
                 },
                 new Kategorije
                 {
                     KategorijaId = 2,
                     Naziv = "Visejedinicna",
                     Opis = "visejedinicna"
                 },
                 new Kategorije
                 {
                     KategorijaId = 3,
                     Naziv = "Etazirana",
                     Opis = "etazirana"
                 }

            );
        }
    }
}
