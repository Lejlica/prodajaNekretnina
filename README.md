# Prodaja Nekretnina

## Kredencijali za prijavu

### DESKTOP

#### Uloga: Administrator (Nedžma Tabak)  
- **username:** `admin`  
- **password:** `test`  

#### Uloga: Agent (Sadzid Marić)  
- **username:** `agent`  
- **password:** `test`  

---

### MOBILE

#### Uloga: Stranka (Asad Tabak)  
- **username:** `stranka`  
- **password:** `test`  



## 📲 Slanje zahtjeva za prodaju/iznajmljivanje sa mobilne aplikacije
Slanje zahtjeva za prodaju ili iznajmljivanje vaše nekretnine se vrši preko mobilne aplikacije.  
Nakon što se logirate na mobilnu aplikaciju, idite na **"Dodaj nekretninu"** iz *sideDrawera*.  
Nakon unosa podataka i odabira tipa akcije (`Prodaja` ili `Iznajmljivanje`), zahtjev će biti dodan.

Potrebno je da taj zahtjev odobri **admin** ili **agent** putem desktop aplikacije u sekciji  
**"Zahtjevi → Zahtjevi za prodaju"** ili **"Zahtjevi → Zahtjevi za iznajmljivanje"** iz *sideDrawera*.

---

## 💻 Odobravanje zahtjeva sa desktop aplikacije
Na desktop aplikaciji kliknite na sekciju:
- **"Zahtjevi → Zahtjevi za prodaju"**, ili  
- **"Zahtjevi → Zahtjevi za iznajmljivanje"**  

Odobravanje se vrši klikom na plavu strelicu u `DataListView`, nakon čega se prikazuju detalji o zahtjevu.  
Na dnu ekrana možete odabrati agenta (**obavezno**) i kliknuti na dugme **"Odobri"**.

---

## 🗓️ Zakazivanje obilaska preko mobilne aplikacije
U sekciji **"Lista nekretnina"** na *sideDraweru*, odaberite željenu nekretninu i kliknite na nju.  
Skrolujte do dna do naslova **"Zakazite obilazak"**, odaberite datum i kliknite **"Zakaži obilazak"**.

---

## ✅ Odobravanje obilaska sa desktop aplikacije
Na desktop aplikaciji kliknite na sekciju **"Obilasci"**.  
Odaberite obilazak iz `DataListView-a`, bit ćete preusmjereni na ekran za odobravanje.

---

## 🛠️ Prijavite problem – opisano u sekciji **RabbitMQ** (ispod)

---

# 🤖 Recommender sistem
Prikaz preporučenih nekretnina (na osnovu želja korisnika) implementiran je u mobilnoj aplikaciji u screen-u: prodajanekretnina_mobile_novi/lib/screens/WishListaScreen.dart
Detaljan opis sistema nalazi se u dokumentu **"recommender-dokumentacija"** na Git repozitoriju seminarskog rada.

---

## 💳 Kupovina nekretnina putem PayPal-a

U sekciji **"Nekretnine"** iz *sideDrawera* mobilne aplikacije nalazi se lista svih dostupnih nekretnina.  
Na **dnu svakog card-a** nekretnine nalazi se dugme **"Kupi koristeći PayPal"**.

Klikom na dugme otvara se ekran za unos PayPal podataka.

Koristite sljedeće test kredencijale:

- **Email:** `sb-oj97a27865823@business.example.com`  
- **Password:** `+F<05Os.`  

> 🧪 *Ovo su testni PayPal sandbox podaci za potrebe demonstracije.*

Nakon uspjesne kupovine korisnik ce biti redirektovan ponovo na aplikaciju gdje moze nastaviti koristiti usluge aplikacije.

---

# 📨 RabbitMQ
RabbitMQ komunikacija se koristi prilikom prijave problema na vlastitim objavljenim nekretninama.

🔹 Idite na **"Moje objavljene nekretnine"** iz *sideDrawera*  
🔹 Odaberite željenu nekretninu i kliknite **"Prijavi problem"**  
🔹 Ispunite formu i kliknite na **"Prijavi problem"**

✅ Nakon prijave, bit ćete redirektovani na ekran za slanje email-a agentu (ili nekom drugom) pomoću **RabbitMQ**.  
Potrebno je unijeti email adresu u za to predviđeno polje.

---

> ⚠️ **VAŽNO**  
> Ukoliko nemate nijednu dodanu nekretninu potrebno je prvo dodati nekretninu (**"Dodaj nekretninu"** iz *SideDrawer-a*), zatim prijaviti problem za istu (🔹 Idite na **"Moje objavljene nekretnine"** iz *sideDrawera*  
🔹 Odaberite željenu nekretninu i kliknite **"Prijavi problem"**  
🔹 Ispunite formu i kliknite na **"Prijavi problem"**) kako biste bili redirektovani na ekran za slanje maila preko **RabbitMQ**.



