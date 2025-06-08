using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using ProdajaNekretnina;
using ProdajaNekretnina.Model.SearchObjects;
using ProdajaNekretnina.Services;
using ProdajaNekretnina.Services.Database;
using ProdajaNekretnina.Services.NekretnineStateMachine;


var builder = WebApplication.CreateBuilder(args);


builder.Services.AddHttpContextAccessor();//dodano pokusaj autentifikacije
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<INekretnineService, NekretnineService>();
builder.Services.AddTransient<IDrzavaService, DrzavaService>();
builder.Services.AddTransient<IGradService, GradService>();
builder.Services.AddTransient<IObilazakService, ObilazakService>();
builder.Services.AddTransient<IKategorijaService, KategorijaService>();
builder.Services.AddTransient<ILokacijaService, LokacijaService>();
builder.Services.AddTransient<ITipService, TipService>();
builder.Services.AddTransient<ISlikaService, SlikaService>();
builder.Services.AddTransient<IAgentService, AgentService>();
builder.Services.AddTransient<IStatusService, StatusService>();
builder.Services.AddTransient<IUlogeService, UlogeService>();
builder.Services.AddTransient<IKorisnikUlogeService, KorisnikUlogeService>();
builder.Services.AddTransient<ITipAkcijeService, TipAkcijeService>();
builder.Services.AddTransient<IKomentariAgentimaService, KomentariAgentimaService>();
builder.Services.AddTransient<IProblemService, ProblemiService>();
builder.Services.AddTransient<IRecenzijaService, RecenzijaService>();
builder.Services.AddTransient<IKupciService, KupciService>();
builder.Services.AddTransient<IKorisnikNekretninaWishService, KorisnikNekretninaService>();
builder.Services.AddTransient<INekretninaTipAkcijeService, NekretninaTipAkcijeService>();
builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialNekretninaState>();
builder.Services.AddTransient<DraftNekretninaState>();
builder.Services.AddTransient<ActiveNekretninaState>();
builder.Services.AddTransient<INekretninaAgentiService,NekretninaAgentiService>();
builder.Services.AddTransient<IKorisnikAgencijaService, KorisnikAgencijaService>();
builder.Services.AddTransient<IAgencijaService, AgencijaService>();
builder.Services.AddTransient<IKupovinaService, KupovinaService>();
builder.Services.AddTransient<IReccomendResultService, ReccomendService>();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
            },
            new string[]{}
    } });

});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<SeminarskiNekretnineContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(ITipService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors(builder =>
{
    builder.AllowAnyOrigin()
           .AllowAnyMethod()
           .AllowAnyHeader();
});


app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
