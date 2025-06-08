using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

using ProdajaNekretnina.Services.Database;

namespace ProdajaNekretnina.Services.Database;

public partial class SeminarskiNekretnineContext : DbContext
{
    public SeminarskiNekretnineContext()
    {
    }

    public SeminarskiNekretnineContext(DbContextOptions<SeminarskiNekretnineContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Agencija> Agencijas { get; set; }

    public virtual DbSet<Drzava> Drzavas { get; set; }

    public virtual DbSet<Grad> Grads { get; set; }

    public virtual DbSet<Kategorije> Kategorijes { get; set; }

    public virtual DbSet<KomentariAgentima> KomentariAgentimas { get; set; }

    public virtual DbSet<Korisnici> Korisnicis { get; set; }

    public virtual DbSet<KorisniciUloge> KorisniciUloges { get; set; }

    public virtual DbSet<Kupci> Kupcis { get; set; }

    public virtual DbSet<Lokacija> Lokacijas { get; set; }

    public virtual DbSet<Nekretnina> Nekretninas { get; set; }

    public virtual DbSet<Obilazak> Obilazaks { get; set; }
 

    public virtual DbSet<Problem> Problems { get; set; }

    public virtual DbSet<Recenzija> Recenzijas { get; set; }

    public virtual DbSet<Slika> Slikas { get; set; }

    public virtual DbSet<Status> Statuses { get; set; }

    public virtual DbSet<TipNekretnine> TipNekretnines { get; set; }

    public virtual DbSet<Uloge> Uloges { get; set; }
    public virtual DbSet<Agent> Agents { get; set; }
    public virtual DbSet<NekretninaAgenti> NekretninaAgentis { get; set; }
    public virtual DbSet<NekretninaTipAkcije> NekretninaTipAkcijes { get; set; }
    public virtual DbSet<KorisnikAgencija> KorisnikAgencijas { get; set; }
    public virtual DbSet<ReccomendResult> ReccomendResults { get; set; }
    public virtual DbSet<KorisnikNekretninaWish> KorisnikNekretninaWishes { get; set; }
    public virtual DbSet<Kupovina> Kupovine { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=db;Database=200120;User=sa;Password=YourStrong@Passw0rd;MultipleActiveResultSets=True;Encrypt=False;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Agencija>(entity =>
        {
            entity.ToTable("Agencija");

            entity.HasIndex(e => e.KorisnikId, "IX_Agencija_KorisnikId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Agencijas).HasForeignKey(d => d.KorisnikId);
        });

        modelBuilder.Entity<Drzava>(entity =>
        {
            entity.ToTable("Drzava");
        });

        modelBuilder.Entity<ReccomendResult>(entity =>
        {
            entity.ToTable("ReccomendResult");
        });

        modelBuilder.Entity<Grad>(entity =>
        {
            entity.ToTable("Grad");

            entity.HasIndex(e => e.DrzavaId, "IX_Grad_DrzavaId");

            entity.HasOne(d => d.Drzava).WithMany(p => p.Grads).HasForeignKey(d => d.DrzavaId);
        });

        modelBuilder.Entity<Kategorije>(entity =>
        {
            entity.HasKey(e => e.KategorijaId);

            entity.ToTable("Kategorije");
        });

        modelBuilder.Entity<KomentariAgentima>(entity =>
        {
            entity.ToTable("KomentariAgentima");

            entity.HasIndex(e => e.KorisnikId, "IX_KomentariAgentima_KorisnikId");

            entity.HasIndex(e => e.KupacId, "IX_KomentariAgentima_KupacId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KomentariAgentimas).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Kupac).WithMany(p => p.KomentariAgentimas).HasForeignKey(d => d.KupacId);
        });

        modelBuilder.Entity<Korisnici>(entity =>
        {
            entity.HasKey(e => e.KorisnikId);

            entity.ToTable("Korisnici");
        });

        modelBuilder.Entity<KorisniciUloge>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogaId);

            entity.ToTable("KorisniciUloge");

            entity.HasIndex(e => e.KorisnikId, "IX_KorisniciUloge_KorisnikId");

            entity.HasIndex(e => e.UlogaId, "IX_KorisniciUloge_UlogaId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisniciUloges).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisniciUloges).HasForeignKey(d => d.UlogaId);
        });

        modelBuilder.Entity<Kupci>(entity =>
        {
            entity.HasKey(e => e.KupacId);

            entity.ToTable("Kupci");
        });

        modelBuilder.Entity<Lokacija>(entity =>
        {
            entity.ToTable("Lokacija");

            entity.HasIndex(e => e.DrzavaId, "IX_Lokacija_DrzavaId");

            entity.HasIndex(e => e.GradId, "IX_Lokacija_GradId");

            entity.HasOne(d => d.Drzava).WithMany(p => p.Lokacijas).HasForeignKey(d => d.DrzavaId);

            entity.HasOne(d => d.Grad).WithMany(p => p.Lokacijas)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Nekretnina>(entity =>
        {
            entity.ToTable("Nekretnina");

            entity.HasIndex(e => e.KategorijaId, "IX_Nekretnina_KategorijaId");

            entity.HasIndex(e => e.KorisnikId, "IX_Nekretnina_KorisnikId");

            entity.HasIndex(e => e.LokacijaId, "IX_Nekretnina_LokacijaId");

            entity.HasIndex(e => e.TipNekretnineId, "IX_Nekretnina_TipNekretnineId");

            //entity.HasOne(d => d.Kategorija).WithMany(p => p.Nekretninas).HasForeignKey(d => d.KategorijaId);

           // entity.HasOne(d => d.Korisnik).WithMany(p => p.Nekretninas).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Lokacija).WithMany(p => p.Nekretninas).HasForeignKey(d => d.LokacijaId);

           // entity.HasOne(d => d.TipNekretnine).WithMany(p => p.Nekretninas).HasForeignKey(d => d.TipNekretnineId);
        });

        modelBuilder.Entity<Obilazak>(entity =>
        {
            entity.ToTable("Obilazak");

            entity.HasIndex(e => e.KorisnikId, "IX_Obilazak_KorisnikId");

            entity.HasIndex(e => e.NekretninaId, "IX_Obilazak_NekretninaId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Obilazaks).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Nekretnina).WithMany(p => p.Obilazaks)
                .HasForeignKey(d => d.NekretninaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Problem>(entity =>
        {
            entity.ToTable("Problem");

            entity.HasIndex(e => e.KorisnikId, "IX_Problem_KorisnikId");

            entity.HasIndex(e => e.NekretninaId, "IX_Problem_NekretninaId");

            entity.HasIndex(e => e.StatusId, "IX_Problem_StatusId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Problems).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Nekretnina).WithMany(p => p.Problems)
                .HasForeignKey(d => d.NekretninaId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Status).WithMany(p => p.Problems).HasForeignKey(d => d.StatusId);
        });

        modelBuilder.Entity<Recenzija>(entity =>
        {
            entity.ToTable("Recenzija");

            entity.HasIndex(e => e.KorisnikId, "IX_Recenzija_KorisnikId");

            entity.HasIndex(e => e.KupacId, "IX_Recenzija_KupacId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Recenzijas).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Kupac).WithMany(p => p.Recenzijas).HasForeignKey(d => d.KupacId);
        });

        modelBuilder.Entity<Slika>(entity =>
        {
            entity.ToTable("Slika");

            entity.HasIndex(e => e.NekretninaId, "IX_Slika_NekretninaId");

            entity.HasOne(d => d.Nekretnina).WithMany(p => p.Slikas).HasForeignKey(d => d.NekretninaId);
        });

        modelBuilder.Entity<Status>(entity =>
        {
            entity.ToTable("Status");
        });

        modelBuilder.Entity<TipNekretnine>(entity =>
        {
            entity.ToTable("TipNekretnine");
        });

        modelBuilder.Entity<Uloge>(entity =>
        {
            entity.HasKey(e => e.UlogaId);

            entity.ToTable("Uloge");
        });
        modelBuilder.Entity<Agent>(entity =>
        {
            entity.ToTable("Agent");

            entity.HasIndex(e => e.KorisnikId, "IX_Agent_KorisnikId");

            

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Agents).HasForeignKey(d => d.KorisnikId);

        });

        modelBuilder.Entity<NekretninaAgenti>(entity =>
        {
            entity.ToTable("NekretninaAgenti");

            entity.HasIndex(e => e.KorisnikId, "IX_NekretninaAgenti_KorisnikId");
            entity.HasIndex(e => e.NekretninaId, "IX_NekretninaAgenti_NekretninaId");


            entity.HasOne(d => d.Korisnik).WithMany(p => p.NekretninaAgentis).HasForeignKey(d => d.KorisnikId);
            entity.HasOne(d => d.Nekretnina).WithMany(p => p.NekretninaAgentis).HasForeignKey(d => d.NekretninaId);
        });
        modelBuilder.Entity<NekretninaTipAkcije>(entity =>
        {
            entity.ToTable("NekretninaTipAkcije");

            entity.HasIndex(e => e.NekretninaId, "IX_NekretninaTipAkcije_NekretninaId");
            entity.HasIndex(e => e.TipAkcijeId, "IX_NekretninaTipAkcije_TipAkcijeId");


            entity.HasOne(d => d.Nekretnina).WithMany(p => p.NekretninaTipAkcijes).HasForeignKey(d => d.NekretninaId);
            entity.HasOne(d => d.TipAkcije).WithMany(p => p.NekretninaTipAkcijes).HasForeignKey(d => d.TipAkcijeId);
        });
        modelBuilder.Entity<KorisnikNekretninaWish>(entity =>
        {
            entity.ToTable("KorisnikNekretninaWish");

            entity.HasIndex(e => e.KorisnikId, "IX_KorisnikNekretninaWish_KorisnikId");

            entity.HasIndex(e => e.NekretninaId, "IX_KorisnikNekretninaWish_NekretninaId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikNekretninaWishs).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Nekretnina).WithMany(p => p.KorisnikNekretninaWishs).HasForeignKey(d => d.NekretninaId);
        });
        modelBuilder.Entity<KorisnikAgencija>(entity =>
        {
            entity.ToTable("KorisnikAgencija");

            entity.HasIndex(e => e.KorisnikId, "IX_KorisnikAgencija_KorisnikId");

            entity.HasIndex(e => e.AgencijaId, "IX_KorisnikAgencija_AgencijaId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikAgencijas).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Agencija).WithMany(p => p.KorisnikAgencijas).HasForeignKey(d => d.AgencijaId);
        });
        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
