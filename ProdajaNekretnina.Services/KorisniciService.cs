using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using ProdajaNekretnina.Model.Requests;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Results;


namespace ProdajaNekretnina.Services
{
    public class KorisniciService : BaseCRUDService<Model.Korisnici, Database.Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>, IKorisniciService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        public KorisniciService(SeminarskiNekretnineContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor)
            : base(context, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public static void Main()
        {
           // bool isDesktopApp = IsDesktopApp();

            //Console.WriteLine($"Is Desktop App: {isDesktopApp}");
        }

        public override async Task BeforeInsert(Korisnici entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Password);
        }

        


        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }


        public override IQueryable<Korisnici> AddInclude(IQueryable<Korisnici> query, KorisniciSearchObject? search = null)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("KorisniciUloges.Uloga");
            }
            return base.AddInclude(query, search);
        }

        /*public static bool IsDesktopApp()
        {
            // Provjerite operativni sustav
            if (Environment.OSVersion.Platform == PlatformID.Win32NT ||
                Environment.OSVersion.Platform == PlatformID.Win32Windows)
            {
                return true; // Windows računalo
            }
            else if (Environment.OSVersion.Platform == PlatformID.MacOSX)
            {
                return false; // macOS
            }
            else if (Environment.OSVersion.Platform == PlatformID.Unix)
            {
                return false; // Unix-based sustavi (Linux)
            }


            return false;
        }*/

        public async Task<Model.Korisnici> Login(string username, string password)
        {
            var entity = await _context.Korisnicis.Include("KorisniciUloges.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            var appType = _httpContextAccessor.HttpContext?.Request?.Headers["App-Type"].ToString();
            Console.WriteLine($"App-Type HEADER: {appType}");

            if (appType == "Desktop" && entity.KorisniciUloges.All(u => u.UlogaId != 1 && u.UlogaId != 2))
                return null; // Desktop prijava dozvoljena samo ulogama s ID 1 ili 2

            if (appType == "Mobile" && entity.KorisniciUloges.All(u => u.UlogaId != 3))
                return null; // Mobilna prijava dozvoljena samo ulogama s ID 3


            return _mapper.Map<Model.Korisnici>(entity);
        }

        public async Task<bool> UpdatePassword(int userId, string newPassword)
        {
            var entity = await _context.Korisnicis.FindAsync(userId);

            if (entity == null)
            {
                return false; // Korisnik nije pronađen
            }

            // Koristi postojeću sol za ažuriranje
            string existingSalt = entity.LozinkaSalt;

            // Generiši novi hash sa postojećom solju i novom lozinkom
            entity.LozinkaHash = GenerateHash(existingSalt, newPassword);

            await _context.SaveChangesAsync();

            return true; // Uspješno ažurirano
        }

        /*public async Task PayMembershipAsync(int userId, CancellationToken cancellationToken = default)
        {
            var user = await base.GetByIdAsync(userId, cancellationToken);

           // if (user == null)
           //     throw new NotFoundResult();
            if (user.KorisniciUloges.FirstOrDefault().UlogaId != 3)
            {
                throw new Exception("Only customers can pay mebership");
            }
            //if (user.IsActiveMembership)
            //    throw new Exception("Membership is already activated");

            DateTime date = DateTime.Now;

            user.PurchaseDate = date;

            var exp = date.AddYears(1);
            user.ExpirationDate = exp;

            base.Update(user);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
        }*/
    }


}

