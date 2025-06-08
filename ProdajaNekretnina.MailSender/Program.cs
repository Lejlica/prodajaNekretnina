using ProdajaNekretnina.MailPublisher.Services;
using ProdajaNekretnina.MailSender.Services;
using Serilog;
using Serilog.Events;
using Serilog.Configuration;
using Microsoft.Extensions.Configuration;
using ProdajaNekretnina.MailPublisher.Config;

var builder = WebApplication.CreateBuilder(args);
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)

    .CreateLogger();

builder.Host.UseSerilog();

builder.Services.Configure<SMTPConfiguration>(builder.Configuration.GetSection("Mail"));
builder.Services.Configure<RabbitConfiguration>(builder.Configuration.GetSection("RabbitMQ"));

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddSingleton<IEmailService, EmailService>();
builder.Services.AddSingleton<IMailSenderService, MailSenderService>();

//builder.Services.AddSingleton<IMailSenderService, EmailSenderService>();

var app = builder.Build();

var emailService = app.Services.GetRequiredService<IMailSenderService>();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
