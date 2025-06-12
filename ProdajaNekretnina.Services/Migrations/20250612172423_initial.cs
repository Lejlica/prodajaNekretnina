using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace ProdajaNekretnina.Services.Migrations
{
    /// <inheritdoc />
    public partial class initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Drzava",
                columns: table => new
                {
                    DrzavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Drzava", x => x.DrzavaId);
                });

            migrationBuilder.CreateTable(
                name: "Kategorije",
                columns: table => new
                {
                    KategorijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kategorije", x => x.KategorijaId);
                });

            migrationBuilder.CreateTable(
                name: "Korisnici",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    BrojUspjesnoProdanihNekretnina = table.Column<int>(type: "int", nullable: true),
                    RejtingKupaca = table.Column<float>(type: "real", nullable: true),
                    BajtoviSlike = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnici", x => x.KorisnikId);
                });

            migrationBuilder.CreateTable(
                name: "Kupci",
                columns: table => new
                {
                    KupacId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumRegistracije = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false),
                    ClientId = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ClientSecret = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kupci", x => x.KupacId);
                });

            migrationBuilder.CreateTable(
                name: "ReccomendResult",
                columns: table => new
                {
                    NekretninaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PrvaNekretninaId = table.Column<int>(type: "int", nullable: false),
                    DrugaNekretninaId = table.Column<int>(type: "int", nullable: false),
                    TrecaNekretninaId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ReccomendResult", x => x.NekretninaId);
                });

            migrationBuilder.CreateTable(
                name: "Status",
                columns: table => new
                {
                    StatusId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Status", x => x.StatusId);
                });

            migrationBuilder.CreateTable(
                name: "TipAkcije",
                columns: table => new
                {
                    TipAkcijeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TipAkcije", x => x.TipAkcijeId);
                });

            migrationBuilder.CreateTable(
                name: "TipNekretnine",
                columns: table => new
                {
                    TipNekretnineId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivTipa = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OpisTipa = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TipNekretnine", x => x.TipNekretnineId);
                });

            migrationBuilder.CreateTable(
                name: "Uloge",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloge", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DrzavaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.GradId);
                    table.ForeignKey(
                        name: "FK_Grad_Drzava_DrzavaId",
                        column: x => x.DrzavaId,
                        principalTable: "Drzava",
                        principalColumn: "DrzavaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Agencija",
                columns: table => new
                {
                    AgencijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Logo = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KontaktOsoba = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumDodavanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumAzuriranja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Agencija", x => x.AgencijaId);
                    table.ForeignKey(
                        name: "FK_Agencija_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Agent",
                columns: table => new
                {
                    AgentId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Agent", x => x.AgentId);
                    table.ForeignKey(
                        name: "FK_Agent_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KomentariAgentima",
                columns: table => new
                {
                    KomentariAgentimaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    KupacId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KomentariAgentima", x => x.KomentariAgentimaId);
                    table.ForeignKey(
                        name: "FK_KomentariAgentima_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KomentariAgentima_Kupci_KupacId",
                        column: x => x.KupacId,
                        principalTable: "Kupci",
                        principalColumn: "KupacId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Recenzija",
                columns: table => new
                {
                    RecenzijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    VrijednostZvjezdica = table.Column<float>(type: "real", nullable: false),
                    KupacId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recenzija", x => x.RecenzijaId);
                    table.ForeignKey(
                        name: "FK_Recenzija_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Recenzija_Kupci_KupacId",
                        column: x => x.KupacId,
                        principalTable: "Kupci",
                        principalColumn: "KupacId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KorisniciUloge",
                columns: table => new
                {
                    KorisnikUlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisniciUloge", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Uloge_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Uloge",
                        principalColumn: "UlogaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Lokacija",
                columns: table => new
                {
                    LokacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PostanskiBroj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Ulica = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    GradId = table.Column<int>(type: "int", nullable: false),
                    DrzavaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lokacija", x => x.LokacijaId);
                    table.ForeignKey(
                        name: "FK_Lokacija_Drzava_DrzavaId",
                        column: x => x.DrzavaId,
                        principalTable: "Drzava",
                        principalColumn: "DrzavaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Lokacija_Grad_GradId",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "GradId");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikAgencija",
                columns: table => new
                {
                    KorisnikAgencijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    AgencijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikAgencija", x => x.KorisnikAgencijaId);
                    table.ForeignKey(
                        name: "FK_KorisnikAgencija_Agencija_AgencijaId",
                        column: x => x.AgencijaId,
                        principalTable: "Agencija",
                        principalColumn: "AgencijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisnikAgencija_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "Nekretnina",
                columns: table => new
                {
                    NekretninaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsOdobrena = table.Column<bool>(type: "bit", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    TipNekretnineId = table.Column<int>(type: "int", nullable: false),
                    KategorijaId = table.Column<int>(type: "int", nullable: false),
                    LokacijaId = table.Column<int>(type: "int", nullable: false),
                    DatumDodavanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Cijena = table.Column<float>(type: "real", nullable: false),
                    StateMachine = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Kvadratura = table.Column<int>(type: "int", nullable: false),
                    BrojSoba = table.Column<int>(type: "int", nullable: false),
                    BrojSpavacihSoba = table.Column<int>(type: "int", nullable: false),
                    Namjesten = table.Column<bool>(type: "bit", nullable: false),
                    Novogradnja = table.Column<bool>(type: "bit", nullable: false),
                    Sprat = table.Column<int>(type: "int", nullable: false),
                    ParkingMjesto = table.Column<bool>(type: "bit", nullable: false),
                    BrojUgovora = table.Column<int>(type: "int", nullable: false),
                    DetaljanOpis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nekretnina", x => x.NekretninaId);
                    table.ForeignKey(
                        name: "FK_Nekretnina_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Nekretnina_Lokacija_LokacijaId",
                        column: x => x.LokacijaId,
                        principalTable: "Lokacija",
                        principalColumn: "LokacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Nekretnina_TipNekretnine_TipNekretnineId",
                        column: x => x.TipNekretnineId,
                        principalTable: "TipNekretnine",
                        principalColumn: "TipNekretnineId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KorisnikNekretninaWish",
                columns: table => new
                {
                    KorisnikNekretninaWishId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    NekretninaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikNekretninaWish", x => x.KorisnikNekretninaWishId);
                    table.ForeignKey(
                        name: "FK_KorisnikNekretninaWish_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisnikNekretninaWish_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "Kupovine",
                columns: table => new
                {
                    KupovinaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NekretninaId = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IsPaid = table.Column<bool>(type: "bit", nullable: false),
                    IsConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    PayPalPaymentId = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kupovine", x => x.KupovinaId);
                    table.ForeignKey(
                        name: "FK_Kupovine_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_Kupovine_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId");
                });

            migrationBuilder.CreateTable(
                name: "NekretninaAgenti",
                columns: table => new
                {
                    NekretninaAgentiID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NekretninaId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NekretninaAgenti", x => x.NekretninaAgentiID);
                    table.ForeignKey(
                        name: "FK_NekretninaAgenti_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_NekretninaAgenti_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "NekretninaTipAkcije",
                columns: table => new
                {
                    NekretninaTipAkcijeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NekretninaId = table.Column<int>(type: "int", nullable: false),
                    TipAkcijeId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NekretninaTipAkcije", x => x.NekretninaTipAkcijeId);
                    table.ForeignKey(
                        name: "FK_NekretninaTipAkcije_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_NekretninaTipAkcije_TipAkcije_TipAkcijeId",
                        column: x => x.TipAkcijeId,
                        principalTable: "TipAkcije",
                        principalColumn: "TipAkcijeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Obilazak",
                columns: table => new
                {
                    ObilazakId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumObilaska = table.Column<DateTime>(type: "datetime2", nullable: false),
                    VrijemeObilaska = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NekretninaId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    isOdobren = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Obilazak", x => x.ObilazakId);
                    table.ForeignKey(
                        name: "FK_Obilazak_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Obilazak_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId");
                });

            migrationBuilder.CreateTable(
                name: "Problem",
                columns: table => new
                {
                    ProblemId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumPrijave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsVecPrijavljen = table.Column<bool>(type: "bit", nullable: false),
                    DatumNastankaProblema = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumRjesenja = table.Column<DateTime>(type: "datetime2", nullable: true),
                    OpisRjesenja = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    StatusId = table.Column<int>(type: "int", nullable: false),
                    NekretninaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Problem", x => x.ProblemId);
                    table.ForeignKey(
                        name: "FK_Problem_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Problem_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId");
                    table.ForeignKey(
                        name: "FK_Problem_Status_StatusId",
                        column: x => x.StatusId,
                        principalTable: "Status",
                        principalColumn: "StatusId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Slika",
                columns: table => new
                {
                    SlikaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BajtoviSlike = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    NekretninaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Slika", x => x.SlikaId);
                    table.ForeignKey(
                        name: "FK_Slika_Nekretnina_NekretninaId",
                        column: x => x.NekretninaId,
                        principalTable: "Nekretnina",
                        principalColumn: "NekretninaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Drzava",
                columns: new[] { "DrzavaId", "Naziv" },
                values: new object[,]
                {
                    { 1, "BiH" },
                    { 2, "Saudijska Arabija" }
                });

            migrationBuilder.InsertData(
                table: "Kategorije",
                columns: new[] { "KategorijaId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Samostalna jednica", "samostalna" },
                    { 2, "Visejedinicna", "visejedinicna" },
                    { 3, "Etazirana", "etazirana" }
                });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "KorisnikId", "BajtoviSlike", "BrojUspjesnoProdanihNekretnina", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "RejtingKupaca", "Status", "Telefon" },
                values: new object[,]
                {
                    { 1, null, 3, "nedzma@gmail.com", "Nedzma", "admin", "sev5R8XFlYf19eoHmVQ6F42LbFU=", "JCb9vvndMHMdyGx//v/JAg==", "Tabak", 5f, true, "123123123" },
                    { 2, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 6, 0, 10, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 30, 16, 0, 2, 1, 5, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 5, 33, 19, 97, 161, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 255, 196, 0, 26, 17, 0, 2, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 49, 81, 18, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 57, 247, 81, 174, 242, 161, 186, 26, 38, 76, 116, 243, 221, 36, 230, 229, 165, 168, 86, 7, 62, 218, 226, 220, 96, 185, 121, 65, 65, 32, 2, 20, 253, 164, 189, 244, 53, 14, 31, 255, 217 }, 7, "sadzid@gmail.com", "Sadzid", "agent", "pBAyxd0eFkTx1cCDulcJ0BtG3xA=", "VeRqUN240e4wbKSR29j16Q==", "Maric", 4.5f, true, "123123123" },
                    { 3, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 6, 0, 10, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 30, 16, 0, 2, 1, 5, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 5, 33, 19, 97, 161, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 255, 196, 0, 26, 17, 0, 2, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 49, 81, 18, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 57, 247, 81, 174, 242, 161, 186, 26, 38, 76, 116, 243, 221, 36, 230, 229, 165, 168, 86, 7, 62, 218, 226, 220, 96, 185, 121, 65, 65, 32, 2, 20, 253, 164, 189, 244, 53, 14, 31, 255, 217 }, 0, "asad@gmail.com", "Asad", "stranka", "wg2XVVhmnLgojEPxH16OGOS0JPA=", "ej0ozWpZnNpfVicem0Yykg==", "Tabak", 0f, true, "123123123" },
                    { 4, null, 23, "zejd@gmail.com", "Zejd", "zejd", "ZFyhh2GWQZ1+ExBnGO7ZVH8LXkY=", "jU9tXRky/91o5rqeMqJLiw==", "Maric", 0f, true, "123123123" },
                    { 5, null, 0, "selma@gmail.com", "Selma", "selma", "0xjQ8VCH/vuQIeBWZ4gc6GXR9nA=", "jxmFfP2rCcNiJu/kB0gTdUw==", "Baralija", 0f, true, "123123123" },
                    { 6, null, 0, "amna@gmail.com", "Amna", "amna", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Baralija", 0f, true, "123123123" },
                    { 7, null, 15, "ensar@gmail.com", "Ensar", "ensar", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", 0f, true, "123123123" },
                    { 8, null, 12, "azra@gmail.com", "Azra", "azra", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", 0f, true, "123123123" },
                    { 9, null, 21, "adisa@gmail.com", "Adisa", "adisa", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", 0f, true, "123123123" },
                    { 10, null, 29, "semsudin@gmail.com", "Semsudin", "semsudin", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", 0f, true, "123123123" },
                    { 11, null, 30, "zijad@gmail.com", "Zijad", "zijad", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Maric", 0f, true, "123123123" },
                    { 12, null, 25, "mersija@gmail.com", "Mersija", "mersija", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Maric", 0f, true, "123123123" },
                    { 13, null, 7, "hazim@gmail.com", "Hazim", "hazim", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", 0f, true, "123123123" }
                });

            migrationBuilder.InsertData(
                table: "Kupci",
                columns: new[] { "KupacId", "ClientId", "ClientSecret", "DatumRegistracije", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Status" },
                values: new object[,]
                {
                    { 1, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "nedzma@gmail.com", "Nedzma", "admin", "sev5R8XFlYf19eoHmVQ6F42LbFU=", "JCb9vvndMHMdyGx//v/JAg==", "Tabak", true },
                    { 2, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "sadzid@gmail.com", "Sadzid", "agent", "pBAyxd0eFkTx1cCDulcJ0BtG3xA=", "VeRqUN240e4wbKSR29j16Q==", "Maric", true },
                    { 3, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "asad@gmail.com", "Asad", "stranka", "wg2XVVhmnLgojEPxH16OGOS0JPA=", "ej0ozWpZnNpfVicem0Yykg==", "Tabak", true },
                    { 4, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "zejd@gmail.com", "Zejd", "zejd", "ZFyhh2GWQZ1+ExBnGO7ZVH8LXkY=", "jU9tXRky/91o5rqeMqJLiw==", "Maric", true },
                    { 5, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "selma@gmail.com", "Selma", "selma", "0xjQ8VCH/vuQIeBWZ4gc6GXR9nA=", "jxmFfP2rCcNiJu/kB0gTdUw==", "Baralija", true },
                    { 6, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "amna@gmail.com", "Amna", "amna", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Baralija", true },
                    { 7, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ensar@gmail.com", "Ensar", "ensar", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", true },
                    { 8, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "azra@gmail.com", "Azra", "azra", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", true },
                    { 9, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "adisa@gmail.com", "Adisa", "adisa", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", true },
                    { 10, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "semsudin@gmail.com", "Semsudin", "semsudin", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", true },
                    { 11, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "zijad@gmail.com", "Zijad", "zijad", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Maric", true },
                    { 12, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "mersija@gmail.com", "Mersija", "mersija", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Maric", true },
                    { 13, "nijePostavljen", "nijePostavljen", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "hazim@gmail.com", "Hazim", "hazim", "qjDD3Nty/Q0tZkDwqr7mZqBWTmE=", "5/PBVv9eWBSApe7SVx+BUA==", "Lizde", true }
                });

            migrationBuilder.InsertData(
                table: "Status",
                columns: new[] { "StatusId", "Opis" },
                values: new object[,]
                {
                    { 1, "U toku" },
                    { 2, "Procesiran" },
                    { 3, "Zavrsen" },
                    { 4, "Na cekanju" }
                });

            migrationBuilder.InsertData(
                table: "TipAkcije",
                columns: new[] { "TipAkcijeId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Prodaja" },
                    { 2, "Iznajmljivanje" }
                });

            migrationBuilder.InsertData(
                table: "TipNekretnine",
                columns: new[] { "TipNekretnineId", "NazivTipa", "OpisTipa" },
                values: new object[,]
                {
                    { 1, "Stan", "Za stanovanje" },
                    { 2, "Kuca", "Za stanovanje" },
                    { 3, "Poslovni prostor", "Za poslovanje" },
                    { 4, "Zemljiste", "Za gradnju" },
                    { 5, "Apartman", "Za iznajmljivanje" }
                });

            migrationBuilder.InsertData(
                table: "Uloge",
                columns: new[] { "UlogaId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Admin", "admin" },
                    { 2, "Agent", "agent" },
                    { 3, "Stranka", "stranka" }
                });

            migrationBuilder.InsertData(
                table: "Agencija",
                columns: new[] { "AgencijaId", "Adresa", "DatumAzuriranja", "DatumDodavanja", "Email", "KontaktOsoba", "KorisnikId", "Logo", "Naziv", "Opis", "Telefon" },
                values: new object[,]
                {
                    { 1, "Zlatna Ulica 12, Sarajevo", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "kontakt@goldenrealestate.ba", "Nedzma Tabak", 1, "logo", "Golden Real Estate", "Agencija specijalizovana za luksuzne nekretnine.", "+387 33 123 456" },
                    { 2, "Marsala Tita, Mostar", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "kontakt@agencija.ba", "Ensar Lizde", 7, "logo", "Agencija za prodaju nekretnina", "Agencija specijalizovana za luksuzne nekretnine.", "+387 33 123 456" }
                });

            migrationBuilder.InsertData(
                table: "Grad",
                columns: new[] { "GradId", "DrzavaId", "Naziv" },
                values: new object[,]
                {
                    { 1, 1, "Mostar" },
                    { 2, 1, "Sarajevo" },
                    { 3, 1, "Tuzla" },
                    { 4, 2, "Rijad" }
                });

            migrationBuilder.InsertData(
                table: "KomentariAgentima",
                columns: new[] { "KomentariAgentimaId", "Datum", "KorisnikId", "KupacId", "Sadrzaj" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 2, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 6, "Preporučujem suradnju!" },
                    { 3, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 4, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 5, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 6, "Preporučujem suradnju!" },
                    { 6, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 7, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 8, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 6, "Preporučujem suradnju!" },
                    { 9, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 10, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 11, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 6, "Preporučujem suradnju!" },
                    { 12, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 13, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 14, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 6, "Preporučujem suradnju!" },
                    { 15, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 16, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 11, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 17, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 11, 6, "Preporučujem suradnju!" },
                    { 18, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 11, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 19, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 20, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, 6, "Preporučujem suradnju!" },
                    { 21, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, 5, "Usluga na vrhunskom nivou. Svaka cast!" },
                    { 22, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, 3, "Vrlo profesionalan i usluzan agent. Preporucujem!" },
                    { 23, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, 6, "Preporučujem suradnju!" },
                    { 24, new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, 5, "Usluga na vrhunskom nivou. Svaka cast!" }
                });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "KorisnikUlogaId", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8419), 1, 1 },
                    { 2, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8488), 2, 2 },
                    { 3, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8495), 3, 3 },
                    { 4, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8500), 4, 2 },
                    { 5, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8505), 5, 3 },
                    { 6, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8509), 6, 3 },
                    { 7, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8513), 7, 1 },
                    { 8, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8518), 8, 2 },
                    { 9, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8522), 9, 2 },
                    { 10, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8527), 10, 2 },
                    { 11, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8531), 11, 2 },
                    { 12, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8535), 12, 2 },
                    { 13, new DateTime(2025, 6, 12, 19, 24, 23, 459, DateTimeKind.Local).AddTicks(8540), 13, 2 }
                });

            migrationBuilder.InsertData(
                table: "Recenzija",
                columns: new[] { "RecenzijaId", "KorisnikId", "KupacId", "VrijednostZvjezdica" },
                values: new object[,]
                {
                    { 1, 2, 5, 4.5f },
                    { 2, 2, 6, 2.5f }
                });

            migrationBuilder.InsertData(
                table: "KorisnikAgencija",
                columns: new[] { "KorisnikAgencijaId", "AgencijaId", "KorisnikId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 1, 2 },
                    { 3, 1, 4 },
                    { 4, 2, 7 },
                    { 5, 2, 8 },
                    { 6, 2, 9 },
                    { 7, 2, 10 },
                    { 8, 1, 11 },
                    { 9, 1, 12 },
                    { 10, 2, 13 }
                });

            migrationBuilder.InsertData(
                table: "Lokacija",
                columns: new[] { "LokacijaId", "DrzavaId", "GradId", "PostanskiBroj", "Ulica" },
                values: new object[,]
                {
                    { 1, 1, 2, "71000", "Zmaja od Bosne 12" },
                    { 2, 1, 1, "88000", "Kralja Tomislava 5" },
                    { 3, 1, 3, "78000", "Tuzlanska" },
                    { 4, 1, 3, "78000", "Brcanska Malta" }
                });

            migrationBuilder.InsertData(
                table: "Nekretnina",
                columns: new[] { "NekretninaId", "BrojSoba", "BrojSpavacihSoba", "BrojUgovora", "Cijena", "DatumDodavanja", "DatumIzmjene", "DetaljanOpis", "IsOdobrena", "KategorijaId", "KorisnikId", "Kvadratura", "LokacijaId", "Namjesten", "Naziv", "Novogradnja", "ParkingMjesto", "Sprat", "StateMachine", "TipNekretnineId" },
                values: new object[,]
                {
                    { 1, 5, 3, 12345, 250000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Prostrana kuca sa velikim dvoristem u mirnom dijelu grada.", true, 1, 3, 180, 1, true, "Moderna Porodicna Kuca", false, true, 2, "draft", 1 },
                    { 2, 4, 1, 12345, 350000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Prostrani stan sa velikom okucnicom u centru grada.", true, 2, 3, 280, 1, true, "Stan na dan", false, true, 2, "draft", 2 },
                    { 3, 7, 4, 10000, 500000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Moderna villa u centru sarajeva. Za dodatne informacije javiti se na mail.", true, 2, 3, 180, 2, true, "Villa u centru Sarajeva", true, true, 2, "draft", 2 },
                    { 4, 0, 0, 12300, 20000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Iznajmljuje se poslovni prostor. Za dodatne informacije javiti se na mail.", false, 1, 3, 200, 3, false, "Poslovni prostor", true, true, 1, "draft", 2 },
                    { 5, 0, 0, 12300, 4000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Iznajmljuje se garaza. Za dodatne informacije javiti se na mail.", false, 3, 3, 200, 3, false, "Garaza", true, true, 1, "draft", 2 },
                    { 6, 0, 0, 12300, 600000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Prodaje se moderno uredjena kuca. Za dodatne informacije javiti se na mail.", false, 2, 3, 200, 4, false, "Kuca sa okucnicom", true, true, 1, "draft", 2 },
                    { 7, 0, 0, 12300, 600000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Prodaje se moderno uredjen stan. Za dodatne informacije javiti se na mail.", true, 2, 3, 200, 2, false, "Stan sa bazenom", true, true, 1, "draft", 2 },
                    { 8, 3, 1, 12300, 600000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Prodaje se moderno uredjena vikendica. Za dodatne informacije javiti se na mail.", false, 2, 5, 100, 2, true, "Vikendica prostrana", true, true, 1, "draft", 2 },
                    { 9, 3, 1, 12300, 502000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Prodaje se moderno uredjen stan. Za dodatne informacije javiti se na mail.", false, 2, 6, 100, 4, true, "Stan Ilidza", true, true, 1, "draft", 2 },
                    { 10, 3, 1, 12300, 700000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), " Za dodatne informacije javiti se na mail.", false, 2, 6, 100, 3, true, "Moderna kuca sa dva sprata", true, true, 1, "draft", 2 },
                    { 11, 3, 1, 12300, 705000f, new DateTime(2025, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), " Za dodatne informacije javiti se na mail.", false, 2, 3, 100, 1, true, "Trospratna kuca prodaja", true, true, 1, "draft", 2 }
                });

            migrationBuilder.InsertData(
                table: "KorisnikNekretninaWish",
                columns: new[] { "KorisnikNekretninaWishId", "KorisnikId", "NekretninaId" },
                values: new object[,]
                {
                    { 1, 3, 1 },
                    { 2, 3, 2 },
                    { 3, 3, 3 },
                    { 4, 3, 7 },
                    { 5, 5, 3 }
                });

            migrationBuilder.InsertData(
                table: "NekretninaAgenti",
                columns: new[] { "NekretninaAgentiID", "KorisnikId", "NekretninaId" },
                values: new object[,]
                {
                    { 1, 2, 1 },
                    { 2, 2, 2 },
                    { 3, 2, 3 },
                    { 4, 3, 7 },
                    { 5, 3, 8 },
                    { 6, 11, 9 },
                    { 7, 12, 10 },
                    { 8, 12, 11 }
                });

            migrationBuilder.InsertData(
                table: "NekretninaTipAkcije",
                columns: new[] { "NekretninaTipAkcijeId", "NekretninaId", "TipAkcijeId" },
                values: new object[,]
                {
                    { 1, 1, 2 },
                    { 2, 2, 1 },
                    { 3, 3, 2 },
                    { 4, 4, 2 },
                    { 5, 5, 1 },
                    { 6, 6, 1 },
                    { 7, 7, 2 },
                    { 8, 8, 2 },
                    { 9, 9, 1 },
                    { 10, 10, 2 },
                    { 11, 11, 1 }
                });

            migrationBuilder.InsertData(
                table: "Obilazak",
                columns: new[] { "ObilazakId", "DatumObilaska", "KorisnikId", "NekretninaId", "VrijemeObilaska", "isOdobren" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 1, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true },
                    { 2, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 2, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true },
                    { 3, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 3, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 4, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 7, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 5, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 7, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 6, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 1, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 7, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 7, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 8, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 2, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 9, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 3, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false },
                    { 10, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 2, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false }
                });

            migrationBuilder.InsertData(
                table: "Problem",
                columns: new[] { "ProblemId", "DatumNastankaProblema", "DatumPrijave", "DatumRjesenja", "IsVecPrijavljen", "KorisnikId", "NekretninaId", "Opis", "OpisRjesenja", "StatusId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false, 3, 1, "Prokišnjava krov na spratu.", "", 1 },
                    { 2, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false, 3, 2, "Vrata se ne mogu otvoriti.", "", 1 },
                    { 3, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false, 3, 3, "Ne radi grijanje.", "", 4 },
                    { 4, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false, 5, 7, "Potrebno obaviti sanitarizaciju.", "", 4 }
                });

            migrationBuilder.InsertData(
                table: "Slika",
                columns: new[] { "SlikaId", "BajtoviSlike", "NekretninaId" },
                values: new object[,]
                {
                    { 1, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 3, 2, 2, 2, 2, 2, 3, 2, 2, 2, 3, 3, 3, 3, 4, 6, 4, 4, 4, 4, 4, 8, 6, 6, 5, 6, 9, 8, 10, 10, 9, 8, 9, 9, 10, 12, 15, 12, 10, 11, 14, 11, 9, 9, 13, 17, 13, 14, 15, 16, 16, 17, 16, 10, 12, 18, 19, 18, 16, 19, 15, 16, 16, 16, 255, 219, 0, 67, 1, 3, 3, 3, 4, 3, 4, 8, 4, 4, 8, 16, 11, 9, 11, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 255, 192, 0, 17, 8, 0, 21, 0, 31, 3, 1, 34, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 25, 0, 0, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 5, 6, 8, 4, 255, 196, 0, 44, 16, 0, 1, 4, 2, 1, 3, 1, 6, 7, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 17, 18, 0, 7, 33, 19, 8, 20, 34, 49, 81, 97, 21, 35, 65, 66, 145, 161, 193, 255, 196, 0, 24, 1, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 1, 3, 6, 255, 196, 0, 39, 17, 0, 1, 2, 5, 3, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 18, 33, 5, 6, 49, 81, 113, 35, 65, 129, 193, 225, 240, 241, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 173, 251, 59, 224, 86, 249, 54, 49, 97, 99, 6, 178, 226, 108, 104, 243, 12, 98, 135, 211, 233, 150, 29, 244, 212, 225, 248, 84, 225, 252, 178, 2, 136, 90, 70, 137, 74, 190, 221, 57, 160, 118, 158, 61, 201, 160, 126, 145, 98, 198, 170, 225, 196, 198, 122, 205, 134, 220, 244, 34, 62, 66, 182, 22, 21, 197, 65, 176, 83, 229, 194, 0, 255, 0, 121, 251, 49, 147, 87, 57, 135, 66, 94, 77, 221, 90, 88, 213, 210, 229, 34, 52, 100, 91, 74, 49, 215, 103, 52, 199, 10, 80, 5, 40, 9, 81, 9, 37, 39, 145, 240, 145, 244, 234, 15, 47, 127, 58, 178, 176, 106, 239, 183, 115, 168, 170, 113, 102, 36, 199, 69, 179, 51, 44, 162, 56, 168, 168, 18, 20, 212, 160, 151, 82, 148, 165, 64, 0, 158, 63, 184, 114, 0, 130, 119, 209, 135, 112, 87, 210, 129, 37, 5, 155, 163, 113, 234, 255, 0, 144, 172, 232, 84, 19, 201, 155, 49, 55, 63, 87, 246, 35, 238, 98, 115, 48, 236, 46, 73, 6, 192, 215, 194, 163, 132, 227, 49, 227, 32, 174, 95, 226, 113, 152, 75, 139, 41, 10, 36, 165, 231, 194, 182, 57, 241, 240, 157, 124, 31, 126, 150, 185, 111, 105, 102, 98, 207, 241, 190, 187, 166, 142, 183, 208, 210, 162, 69, 106, 106, 158, 121, 208, 65, 42, 80, 41, 79, 13, 1, 196, 248, 81, 254, 199, 79, 108, 223, 20, 205, 46, 243, 155, 41, 212, 108, 77, 149, 92, 26, 175, 100, 1, 13, 217, 9, 228, 152, 108, 252, 189, 37, 130, 148, 158, 107, 43, 248, 124, 157, 0, 124, 242, 78, 95, 246, 139, 200, 178, 254, 214, 95, 99, 153, 101, 189, 114, 162, 204, 158, 80, 185, 53, 193, 183, 33, 48, 219, 190, 234, 182, 214, 150, 139, 170, 218, 181, 164, 242, 88, 223, 47, 227, 83, 75, 185, 107, 165, 212, 164, 205, 42, 181, 203, 185, 195, 118, 227, 183, 196, 60, 212, 54, 38, 154, 52, 149, 84, 201, 90, 47, 181, 36, 36, 12, 185, 183, 14, 239, 128, 73, 39, 140, 55, 156, 85, 25, 191, 154, 168, 6, 182, 107, 113, 167, 70, 67, 137, 80, 102, 92, 118, 222, 71, 47, 144, 58, 88, 58, 241, 244, 250, 244, 206, 195, 112, 39, 114, 142, 223, 189, 149, 184, 253, 27, 112, 26, 46, 199, 114, 161, 116, 137, 83, 47, 4, 130, 71, 37, 33, 196, 40, 104, 141, 142, 58, 59, 243, 189, 244, 116, 117, 133, 211, 84, 103, 84, 120, 133, 224, 57, 100, 220, 207, 136, 95, 123, 88, 230, 121, 193, 238, 179, 85, 120, 254, 70, 186, 38, 69, 13, 115, 200, 48, 125, 84, 45, 43, 49, 219, 73, 37, 65, 205, 171, 194, 124, 108, 157, 120, 249, 157, 147, 152, 123, 145, 221, 78, 225, 100, 222, 231, 77, 145, 229, 18, 109, 99, 69, 81, 113, 148, 206, 1, 242, 218, 181, 175, 5, 123, 63, 169, 241, 190, 142, 142, 159, 176, 43, 47, 22, 41, 107, 180, 37, 203, 119, 143, 255, 217 }, 1 },
                    { 2, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 11, 0, 20, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 22, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 4, 255, 196, 0, 34, 16, 0, 2, 2, 1, 3, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 17, 49, 0, 18, 33, 4, 5, 20, 81, 35, 65, 209, 255, 196, 0, 23, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 2, 5, 255, 196, 0, 28, 17, 1, 0, 2, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 17, 18, 3, 33, 65, 49, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 22, 235, 36, 151, 182, 164, 19, 31, 140, 73, 184, 80, 167, 31, 126, 199, 28, 94, 128, 184, 230, 190, 69, 215, 216, 19, 162, 117, 19, 151, 105, 6, 248, 88, 42, 51, 181, 238, 25, 227, 159, 220, 235, 74, 63, 101, 174, 37, 242, 0, 0, 73, 36, 204, 104, 85, 38, 5, 99, 26, 54, 216, 113, 32, 151, 113, 228, 89, 23, 154, 57, 215, 62, 150, 71, 166, 24, 179, 95, 114, 134, 54, 153, 97, 40, 12, 106, 138, 66, 250, 211, 114, 222, 213, 122, 102, 175, 100, 96, 34, 44, 99, 108, 118, 163, 208, 58, 13, 151, 182, 30, 89, 255, 217 }, 2 },
                    { 3, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 11, 0, 20, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 22, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 4, 255, 196, 0, 34, 16, 0, 2, 2, 1, 3, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 17, 49, 0, 18, 33, 4, 5, 20, 81, 35, 65, 209, 255, 196, 0, 23, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 2, 5, 255, 196, 0, 28, 17, 1, 0, 2, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 17, 18, 3, 33, 65, 49, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 22, 235, 36, 151, 182, 164, 19, 31, 140, 73, 184, 80, 167, 31, 126, 199, 28, 94, 128, 184, 230, 190, 69, 215, 216, 19, 162, 117, 19, 151, 105, 6, 248, 88, 42, 51, 181, 238, 25, 227, 159, 220, 235, 74, 63, 101, 174, 37, 242, 0, 0, 73, 36, 204, 104, 85, 38, 5, 99, 26, 54, 216, 113, 32, 151, 113, 228, 89, 23, 154, 57, 215, 62, 150, 71, 166, 24, 179, 95, 114, 134, 54, 153, 97, 40, 12, 106, 138, 66, 250, 211, 114, 222, 213, 122, 102, 175, 100, 96, 34, 44, 99, 108, 118, 163, 208, 58, 13, 151, 182, 30, 89, 255, 217 }, 3 },
                    { 4, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 11, 0, 19, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 23, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 5, 4, 255, 196, 0, 38, 16, 0, 2, 0, 5, 3, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 3, 4, 18, 33, 17, 19, 49, 5, 6, 34, 50, 67, 81, 113, 147, 209, 255, 196, 0, 24, 1, 1, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0, 1, 5, 255, 196, 0, 29, 17, 0, 2, 2, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 3, 19, 4, 33, 65, 81, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 29, 173, 87, 53, 105, 102, 168, 119, 84, 14, 162, 228, 228, 147, 142, 61, 177, 16, 87, 225, 168, 82, 187, 43, 208, 117, 89, 204, 93, 203, 53, 64, 150, 46, 219, 26, 146, 195, 131, 136, 74, 114, 76, 84, 154, 26, 221, 77, 203, 19, 179, 74, 153, 242, 179, 18, 71, 206, 145, 55, 203, 154, 232, 58, 145, 22, 150, 150, 76, 129, 100, 164, 177, 91, 44, 3, 28, 199, 61, 231, 201, 244, 154, 13, 219, 90, 153, 97, 80, 241, 225, 0, 98, 51, 100, 223, 163, 76, 208, 42, 230, 233, 233, 253, 75, 249, 5, 73, 177, 219, 63, 255, 217 }, 4 },
                    { 5, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 3, 2, 2, 2, 2, 2, 3, 2, 2, 2, 3, 3, 3, 3, 4, 6, 4, 4, 4, 4, 4, 8, 6, 6, 5, 6, 9, 8, 10, 10, 9, 8, 9, 9, 10, 12, 15, 12, 10, 11, 14, 11, 9, 9, 13, 17, 13, 14, 15, 16, 16, 17, 16, 10, 12, 18, 19, 18, 16, 19, 15, 16, 16, 16, 255, 219, 0, 67, 1, 3, 3, 3, 4, 3, 4, 8, 4, 4, 8, 16, 11, 9, 11, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 255, 192, 0, 17, 8, 0, 17, 0, 25, 3, 1, 34, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 27, 0, 0, 2, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 5, 9, 2, 3, 6, 8, 255, 196, 0, 52, 16, 0, 1, 3, 3, 1, 4, 6, 8, 7, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 0, 5, 6, 17, 7, 18, 33, 49, 8, 19, 20, 34, 53, 65, 23, 24, 35, 55, 85, 87, 115, 148, 116, 117, 145, 178, 179, 209, 210, 255, 196, 0, 25, 1, 0, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 0, 1, 4, 6, 255, 196, 0, 40, 17, 0, 1, 3, 3, 2, 3, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 4, 3, 5, 17, 18, 33, 97, 129, 177, 49, 50, 51, 52, 81, 82, 98, 145, 240, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 110, 91, 58, 79, 226, 91, 70, 186, 59, 138, 226, 81, 39, 174, 234, 227, 239, 182, 203, 175, 144, 168, 189, 74, 10, 64, 112, 172, 3, 169, 86, 247, 117, 62, 122, 18, 116, 229, 81, 187, 106, 190, 95, 241, 108, 89, 55, 124, 125, 86, 149, 93, 100, 78, 76, 22, 24, 236, 234, 144, 234, 30, 222, 32, 164, 160, 36, 106, 116, 74, 143, 233, 207, 149, 37, 112, 12, 23, 35, 194, 176, 87, 140, 102, 49, 169, 179, 156, 90, 146, 171, 243, 114, 148, 219, 177, 52, 111, 146, 66, 25, 42, 238, 148, 133, 106, 79, 16, 52, 231, 165, 62, 49, 172, 114, 222, 97, 91, 230, 223, 238, 115, 37, 56, 153, 232, 113, 215, 218, 158, 243, 157, 98, 59, 46, 241, 72, 223, 0, 146, 87, 237, 8, 60, 8, 243, 215, 133, 44, 125, 210, 246, 227, 165, 161, 193, 187, 131, 128, 1, 229, 146, 58, 45, 16, 224, 91, 92, 205, 117, 112, 231, 113, 206, 62, 177, 186, 136, 232, 239, 152, 109, 19, 42, 137, 145, 220, 182, 137, 123, 154, 45, 240, 158, 109, 72, 76, 232, 129, 12, 166, 59, 104, 89, 117, 198, 2, 16, 56, 36, 161, 90, 240, 58, 232, 71, 2, 1, 172, 61, 21, 236, 119, 231, 181, 175, 239, 209, 253, 214, 203, 21, 186, 93, 182, 97, 153, 139, 55, 34, 241, 58, 227, 26, 91, 6, 36, 185, 59, 177, 97, 41, 111, 157, 197, 151, 116, 113, 194, 148, 163, 154, 18, 130, 60, 181, 28, 171, 204, 94, 164, 121, 143, 199, 236, 159, 116, 207, 248, 162, 209, 149, 42, 59, 116, 200, 97, 36, 251, 183, 61, 80, 110, 20, 169, 84, 120, 49, 176, 7, 196, 109, 193, 88, 78, 208, 60, 2, 119, 210, 164, 161, 240, 214, 191, 51, 31, 193, 69, 20, 226, 217, 224, 126, 244, 10, 166, 247, 154, 187, 12, 143, 220, 142, 75, 248, 71, 63, 113, 170, 247, 162, 138, 226, 239, 62, 103, 146, 146, 123, 66, 255, 217 }, 5 },
                    { 6, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 6, 0, 10, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 30, 16, 0, 2, 1, 5, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 5, 33, 19, 97, 161, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 255, 196, 0, 26, 17, 0, 2, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 49, 81, 18, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 57, 247, 81, 174, 242, 161, 186, 26, 38, 76, 116, 243, 221, 36, 230, 229, 165, 168, 86, 7, 62, 218, 226, 220, 96, 185, 121, 65, 65, 32, 2, 20, 253, 164, 189, 244, 53, 14, 31, 255, 217 }, 6 },
                    { 7, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 8, 0, 11, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 32, 16, 0, 1, 2, 6, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 4, 0, 2, 5, 17, 18, 65, 33, 34, 49, 193, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 255, 196, 0, 26, 17, 1, 0, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 65, 3, 4, 19, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 58, 156, 229, 202, 74, 204, 91, 164, 177, 152, 27, 155, 92, 251, 174, 96, 60, 214, 118, 40, 21, 145, 244, 234, 175, 202, 99, 42, 124, 249, 111, 168, 31, 98, 189, 222, 73, 174, 184, 159, 255, 217 }, 7 },
                    { 8, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 6, 0, 10, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 30, 16, 0, 2, 1, 5, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 5, 33, 19, 97, 161, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 255, 196, 0, 26, 17, 0, 2, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 49, 81, 18, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 57, 247, 81, 174, 242, 161, 186, 26, 38, 76, 116, 243, 221, 36, 230, 229, 165, 168, 86, 7, 62, 218, 226, 220, 96, 185, 121, 65, 65, 32, 2, 20, 253, 164, 189, 244, 53, 14, 31, 255, 217 }, 8 },
                    { 9, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 8, 0, 11, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 32, 16, 0, 1, 2, 6, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 4, 0, 2, 5, 17, 18, 65, 33, 34, 49, 193, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 255, 196, 0, 26, 17, 1, 0, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 65, 3, 4, 19, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 58, 156, 229, 202, 74, 204, 91, 164, 177, 152, 27, 155, 92, 251, 174, 96, 60, 214, 118, 40, 21, 145, 244, 234, 175, 202, 99, 42, 124, 249, 111, 168, 31, 98, 189, 222, 73, 174, 184, 159, 255, 217 }, 9 },
                    { 10, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 3, 2, 2, 2, 2, 2, 3, 2, 2, 2, 3, 3, 3, 3, 4, 6, 4, 4, 4, 4, 4, 8, 6, 6, 5, 6, 9, 8, 10, 10, 9, 8, 9, 9, 10, 12, 15, 12, 10, 11, 14, 11, 9, 9, 13, 17, 13, 14, 15, 16, 16, 17, 16, 10, 12, 18, 19, 18, 16, 19, 15, 16, 16, 16, 255, 219, 0, 67, 1, 3, 3, 3, 4, 3, 4, 8, 4, 4, 8, 16, 11, 9, 11, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 255, 192, 0, 17, 8, 0, 21, 0, 31, 3, 1, 34, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 25, 0, 0, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 5, 6, 8, 4, 255, 196, 0, 44, 16, 0, 1, 4, 2, 1, 3, 1, 6, 7, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 17, 18, 0, 7, 33, 19, 8, 20, 34, 49, 81, 97, 21, 35, 65, 66, 145, 161, 193, 255, 196, 0, 24, 1, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 1, 3, 6, 255, 196, 0, 39, 17, 0, 1, 2, 5, 3, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 18, 33, 5, 6, 49, 81, 113, 35, 65, 129, 193, 225, 240, 241, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 173, 251, 59, 224, 86, 249, 54, 49, 97, 99, 6, 178, 226, 108, 104, 243, 12, 98, 135, 211, 233, 150, 29, 244, 212, 225, 248, 84, 225, 252, 178, 2, 136, 90, 70, 137, 74, 190, 221, 57, 160, 118, 158, 61, 201, 160, 126, 145, 98, 198, 170, 225, 196, 198, 122, 205, 134, 220, 244, 34, 62, 66, 182, 22, 21, 197, 65, 176, 83, 229, 194, 0, 255, 0, 121, 251, 49, 147, 87, 57, 135, 66, 94, 77, 221, 90, 88, 213, 210, 229, 34, 52, 100, 91, 74, 49, 215, 103, 52, 199, 10, 80, 5, 40, 9, 81, 9, 37, 39, 145, 240, 145, 244, 234, 15, 47, 127, 58, 178, 176, 106, 239, 183, 115, 168, 170, 113, 102, 36, 199, 69, 179, 51, 44, 162, 56, 168, 168, 18, 20, 212, 160, 151, 82, 148, 165, 64, 0, 158, 63, 184, 114, 0, 130, 119, 209, 135, 112, 87, 210, 129, 37, 5, 155, 163, 113, 234, 255, 0, 144, 172, 232, 84, 19, 201, 155, 49, 55, 63, 87, 246, 35, 238, 98, 115, 48, 236, 46, 73, 6, 192, 215, 194, 163, 132, 227, 49, 227, 32, 174, 95, 226, 113, 152, 75, 139, 41, 10, 36, 165, 231, 194, 182, 57, 241, 240, 157, 124, 31, 126, 150, 185, 111, 105, 102, 98, 207, 241, 190, 187, 166, 142, 183, 208, 210, 162, 69, 106, 106, 158, 121, 208, 65, 42, 80, 41, 79, 13, 1, 196, 248, 81, 254, 199, 79, 108, 223, 20, 205, 46, 243, 155, 41, 212, 108, 77, 149, 92, 26, 175, 100, 1, 13, 217, 9, 228, 152, 108, 252, 189, 37, 130, 148, 158, 107, 43, 248, 124, 157, 0, 124, 242, 78, 95, 246, 139, 200, 178, 254, 214, 95, 99, 153, 101, 189, 114, 162, 204, 158, 80, 185, 53, 193, 183, 33, 48, 219, 190, 234, 182, 214, 150, 139, 170, 218, 181, 164, 242, 88, 223, 47, 227, 83, 75, 185, 107, 165, 212, 164, 205, 42, 181, 203, 185, 195, 118, 227, 183, 196, 60, 212, 54, 38, 154, 52, 149, 84, 201, 90, 47, 181, 36, 36, 12, 185, 183, 14, 239, 128, 73, 39, 140, 55, 156, 85, 25, 191, 154, 168, 6, 182, 107, 113, 167, 70, 67, 137, 80, 102, 92, 118, 222, 71, 47, 144, 58, 88, 58, 241, 244, 250, 244, 206, 195, 112, 39, 114, 142, 223, 189, 149, 184, 253, 27, 112, 26, 46, 199, 114, 161, 116, 137, 83, 47, 4, 130, 71, 37, 33, 196, 40, 104, 141, 142, 58, 59, 243, 189, 244, 116, 117, 133, 211, 84, 103, 84, 120, 133, 224, 57, 100, 220, 207, 136, 95, 123, 88, 230, 121, 193, 238, 179, 85, 120, 254, 70, 186, 38, 69, 13, 115, 200, 48, 125, 84, 45, 43, 49, 219, 73, 37, 65, 205, 171, 194, 124, 108, 157, 120, 249, 157, 147, 152, 123, 145, 221, 78, 225, 100, 222, 231, 77, 145, 229, 18, 109, 99, 69, 81, 113, 148, 206, 1, 242, 218, 181, 175, 5, 123, 63, 169, 241, 190, 142, 142, 159, 176, 43, 47, 22, 41, 107, 180, 37, 203, 119, 143, 255, 217 }, 10 },
                    { 11, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 255, 219, 0, 67, 0, 14, 10, 11, 13, 11, 9, 14, 13, 12, 13, 16, 15, 14, 17, 22, 36, 23, 22, 20, 20, 22, 44, 32, 33, 26, 36, 52, 46, 55, 54, 51, 46, 50, 50, 58, 65, 83, 70, 58, 61, 78, 62, 50, 50, 72, 98, 73, 78, 86, 88, 93, 94, 93, 56, 69, 102, 109, 101, 90, 108, 83, 91, 93, 89, 255, 219, 0, 67, 1, 15, 16, 16, 22, 19, 22, 42, 23, 23, 42, 89, 59, 50, 59, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 255, 192, 0, 17, 8, 0, 6, 0, 10, 3, 1, 17, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 255, 196, 0, 30, 16, 0, 2, 1, 5, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 0, 3, 4, 5, 33, 19, 97, 161, 255, 196, 0, 21, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 255, 196, 0, 26, 17, 0, 2, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 17, 49, 81, 18, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 57, 247, 81, 174, 242, 161, 186, 26, 38, 76, 116, 243, 221, 36, 230, 229, 165, 168, 86, 7, 62, 218, 226, 220, 96, 185, 121, 65, 65, 32, 2, 20, 253, 164, 189, 244, 53, 14, 31, 255, 217 }, 11 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Agencija_KorisnikId",
                table: "Agencija",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Agent_KorisnikId",
                table: "Agent",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Grad_DrzavaId",
                table: "Grad",
                column: "DrzavaId");

            migrationBuilder.CreateIndex(
                name: "IX_KomentariAgentima_KorisnikId",
                table: "KomentariAgentima",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KomentariAgentima_KupacId",
                table: "KomentariAgentima",
                column: "KupacId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_KorisnikId",
                table: "KorisniciUloge",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_UlogaId",
                table: "KorisniciUloge",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikAgencija_AgencijaId",
                table: "KorisnikAgencija",
                column: "AgencijaId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikAgencija_KorisnikId",
                table: "KorisnikAgencija",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikNekretninaWish_KorisnikId",
                table: "KorisnikNekretninaWish",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikNekretninaWish_NekretninaId",
                table: "KorisnikNekretninaWish",
                column: "NekretninaId");

            migrationBuilder.CreateIndex(
                name: "IX_Kupovine_KorisnikId",
                table: "Kupovine",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Kupovine_NekretninaId",
                table: "Kupovine",
                column: "NekretninaId");

            migrationBuilder.CreateIndex(
                name: "IX_Lokacija_DrzavaId",
                table: "Lokacija",
                column: "DrzavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Lokacija_GradId",
                table: "Lokacija",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Nekretnina_KategorijaId",
                table: "Nekretnina",
                column: "KategorijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Nekretnina_KorisnikId",
                table: "Nekretnina",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Nekretnina_LokacijaId",
                table: "Nekretnina",
                column: "LokacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Nekretnina_TipNekretnineId",
                table: "Nekretnina",
                column: "TipNekretnineId");

            migrationBuilder.CreateIndex(
                name: "IX_NekretninaAgenti_KorisnikId",
                table: "NekretninaAgenti",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_NekretninaAgenti_NekretninaId",
                table: "NekretninaAgenti",
                column: "NekretninaId");

            migrationBuilder.CreateIndex(
                name: "IX_NekretninaTipAkcije_NekretninaId",
                table: "NekretninaTipAkcije",
                column: "NekretninaId");

            migrationBuilder.CreateIndex(
                name: "IX_NekretninaTipAkcije_TipAkcijeId",
                table: "NekretninaTipAkcije",
                column: "TipAkcijeId");

            migrationBuilder.CreateIndex(
                name: "IX_Obilazak_KorisnikId",
                table: "Obilazak",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Obilazak_NekretninaId",
                table: "Obilazak",
                column: "NekretninaId");

            migrationBuilder.CreateIndex(
                name: "IX_Problem_KorisnikId",
                table: "Problem",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Problem_NekretninaId",
                table: "Problem",
                column: "NekretninaId");

            migrationBuilder.CreateIndex(
                name: "IX_Problem_StatusId",
                table: "Problem",
                column: "StatusId");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzija_KorisnikId",
                table: "Recenzija",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzija_KupacId",
                table: "Recenzija",
                column: "KupacId");

            migrationBuilder.CreateIndex(
                name: "IX_Slika_NekretninaId",
                table: "Slika",
                column: "NekretninaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Agent");

            migrationBuilder.DropTable(
                name: "Kategorije");

            migrationBuilder.DropTable(
                name: "KomentariAgentima");

            migrationBuilder.DropTable(
                name: "KorisniciUloge");

            migrationBuilder.DropTable(
                name: "KorisnikAgencija");

            migrationBuilder.DropTable(
                name: "KorisnikNekretninaWish");

            migrationBuilder.DropTable(
                name: "Kupovine");

            migrationBuilder.DropTable(
                name: "NekretninaAgenti");

            migrationBuilder.DropTable(
                name: "NekretninaTipAkcije");

            migrationBuilder.DropTable(
                name: "Obilazak");

            migrationBuilder.DropTable(
                name: "Problem");

            migrationBuilder.DropTable(
                name: "ReccomendResult");

            migrationBuilder.DropTable(
                name: "Recenzija");

            migrationBuilder.DropTable(
                name: "Slika");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "Agencija");

            migrationBuilder.DropTable(
                name: "TipAkcije");

            migrationBuilder.DropTable(
                name: "Status");

            migrationBuilder.DropTable(
                name: "Kupci");

            migrationBuilder.DropTable(
                name: "Nekretnina");

            migrationBuilder.DropTable(
                name: "Korisnici");

            migrationBuilder.DropTable(
                name: "Lokacija");

            migrationBuilder.DropTable(
                name: "TipNekretnine");

            migrationBuilder.DropTable(
                name: "Grad");

            migrationBuilder.DropTable(
                name: "Drzava");
        }
    }
}
