using AutoMapper;
using Microsoft.EntityFrameworkCore;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProdajaNekretnina.Model;
using ProdajaNekretnina.Model.Requests;

namespace ProdajaNekretnina.Services
{
    public class MappingProfile: Profile
    {
        public MappingProfile()
        {
            
            CreateMap<Database.Korisnici, Model.Korisnici>();
            CreateMap<Model.Requests.KorisniciInsertRequest, Database.Korisnici>();
            CreateMap<Model.Requests.KorisniciUpdateRequest, Database.Korisnici>();
            CreateMap<Database.NekretninaAgenti, Model.NekretninaAgenti>();
            CreateMap<Model.Requests.NekretninaAgentiInsertRequest, Database.NekretninaAgenti>();
            CreateMap<Model.Requests.NekretninaAgentiUpdateRequest, Database.NekretninaAgenti>();
            CreateMap<Database.Agent, Model.Agent>();
            CreateMap<Model.Requests.AgentInsertRequest, Database.Agent>();
            CreateMap<Model.Requests.AgentUpdateRequest, Database.Agent>();
            CreateMap<Database.Kupci, Model.Kupci>();
            CreateMap<Model.Requests.KupciInsertRequest, Database.Kupci>();
            CreateMap<Model.Requests.KupciUpdateRequest, Database.Kupci>();
            CreateMap<Database.Recenzija, Model.Recenzija>();
            CreateMap<Model.Requests.RecenzijaInsertRequest, Database.Recenzija>();
            CreateMap<Model.Requests.RecenzijaUpdateRequest, Database.Recenzija>();
            CreateMap<Database.KorisnikNekretninaWish, Model.KorisnikNekretninaWish>();
            CreateMap<Model.Requests.KorisnikNekretninaWishInsertRequest, Database.KorisnikNekretninaWish>();
            CreateMap<Model.Requests.KorisnikNekretninaWishUpdateRequest, Database.KorisnikNekretninaWish>();
            CreateMap<Database.KomentariAgentima, Model.KomentariAgentima>();
            CreateMap<Model.Requests.KomentariAgentimaInsertRequest, Database.KomentariAgentima>();
            CreateMap<Model.Requests.KomentariAgentimaUpdateRequest, Database.KomentariAgentima>();
            CreateMap<Database.Uloge, Model.Uloge>();
            CreateMap<Database.Status, Model.Status>();
            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<Model.Requests.KorisnikUlogeInsertRequest, Database.KorisniciUloge>();
            CreateMap<Model.Requests.KorisnikUlogeUpdateRequest, Database.KorisniciUloge>();
            CreateMap<Database.Problem, Model.Problem>();
            CreateMap<Model.Requests.ProblemInsertRequest, Database.Problem>();
            CreateMap<Model.Requests.ProblemUpdateRequest, Database.Problem>();
            CreateMap<Database.NekretninaTipAkcije, Model.NekretninaTipAkcije>();
            CreateMap<Model.Requests.NekretninaTipAkcijeInsertRequest, Database.NekretninaTipAkcije>();
            CreateMap<Model.Requests.NekretninaTipAkcijeUpdateRequest, Database.NekretninaTipAkcije>();
            CreateMap<Database.TipAkcije, Model.TipAkcije>();
            CreateMap<Database.Grad, Model.Grad>();
            CreateMap<Model.Requests.GradInsertRequest, Database.Grad>();
            CreateMap<Model.Requests.GradUpdateRequest, Database.Grad>();
            CreateMap<Database.Grad, Model.Grad>()
                .ForMember(dest => dest.Drzava, opt => opt.MapFrom(src => src.Drzava));
            CreateMap<Database.Drzava, Model.Drzava>();
            CreateMap<Model.Requests.DrzavaInsertRequest, Database.Drzava>();
            CreateMap<Model.Requests.DrzavaUpdateRequest, Database.Drzava>();
            CreateMap<Database.Kupovina, Model.Kupovina>();
            CreateMap<Model.Requests.KupovinaInsertRequest, Database.Kupovina>();
            CreateMap<Model.Requests.KupovinaUpdateRequest, Database.Kupovina>();
            
            CreateMap<Database.Lokacija, Model.Lokacija>();
            CreateMap<Model.Requests.LokacijaInsertRequest, Database.Lokacija>();
            CreateMap<Model.Requests.LokacijaUpdateRequest, Database.Lokacija>();
            CreateMap<Database.Nekretnina, Model.Nekretnina>();
            CreateMap<Model.Requests.NekretnineInsertRequest, Database.Nekretnina>();
            CreateMap<Model.Requests.NekretnineUpdateRequest, Database.Nekretnina>();
            CreateMap<Model.Slika, Database.Slika>();
            CreateMap<Database.Slika, Model.Slika>();
            CreateMap<Model.Requests.SlikaInsertRequest, Database.Slika>();
            CreateMap<Model.Requests.SlikaUpdateRquest, Database.Slika>();
            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<Database.Uloge, Model.Uloge>();
            
            CreateMap<Database.Obilazak, Model.Obilazak>();
            CreateMap<Model.Requests.ObilazakInsertRequest, Database.Obilazak>();
            CreateMap<Model.Requests.ObilazakUpdateRequest, Database.Obilazak>();

            CreateMap<Database.ReccomendResult, Model.ReccomendResult>();
            CreateMap<Model.Requests.ReccomendInsertRequest, Database.ReccomendResult>();
            CreateMap<Model.Requests.ReccomendUpdateRequest, Database.ReccomendResult>();

            CreateMap<Database.KorisnikAgencija, Model.KorisnikAgencija>();
            CreateMap<Model.Requests.KorisnikAgencijaInsertRequest, Database.KorisnikAgencija>();
            CreateMap<Model.Requests.KorisnikAgencijaUpdateRequest, Database.KorisnikAgencija>();

            CreateMap<Database.Agencija, Model.Agencija>();
            CreateMap<Model.Requests.AgencijaInsertRequest, Database.Agencija>();
            CreateMap<Model.Requests.AgencijaUpdateRequest, Database.Agencija>();
            CreateMap<Database.Kategorije, Model.Kategorije>();
            CreateMap<Model.Requests.KategorijaInsertRequest, Database.Kategorije>();
            CreateMap<Model.Requests.KategorijaUpdateRequest, Database.Kategorije>();
            CreateMap<Database.TipNekretnine, Model.TipNekretnine>();
            CreateMap<Model.Requests.TipInsertRequest, Database.TipNekretnine>();
            CreateMap<Model.Requests.TipUpdateRequest, Database.TipNekretnine>();
            CreateMap<ProdajaNekretnina.Model.Requests.NekretnineInsertRequest, ProdajaNekretnina.Services.Database.Nekretnina>();


        }
    }
}
