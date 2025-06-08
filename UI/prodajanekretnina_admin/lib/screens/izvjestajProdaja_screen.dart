import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController sudacController = TextEditingController();
  final TextEditingController kantonController = TextEditingController();
  final TextEditingController brojController = TextEditingController();
  final TextEditingController bankaController = TextEditingController();
  final TextEditingController adresaVlasnikaController =
      TextEditingController();
  final TextEditingController adresaNekrentineController =
      TextEditingController();
  final TextEditingController kvadraturaController = TextEditingController();
  final TextEditingController satiController = TextEditingController();

  MyHomePage({super.key});
  Future<void> generatePDF() async {
    final pdf = pw.Document();

    final fontData =
        await rootBundle.load("assets/fonts/RobotoMono-Regular.ttf");
    final ttfFont = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Bosna i Hercegovina\nFederacija Bosne i Hercegovine\n${kantonController.text} županija/kanton\nOpćinski sud u ${cityController.text}',
              style: pw.TextStyle(font: ttfFont, fontSize: 10),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Broj: ${brojController.text}\n${cityController.text}, ${dateController.text} godine',
              style: pw.TextStyle(font: ttfFont, fontSize: 10),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Općinski sud u ${cityController.text} po sucu ${sudacController.text} u ovršnom postupku tražitelja ovrhe ${bankaController.text}, ${cityController.text}, zastupan po zakonskom zastupniku,  radi isplate, vr.sp. ${priceController.text} KM, dana ${dateController.text} godine donio je slijedeći',
              style: pw.TextStyle(font: ttfFont, fontSize: 12),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'ZAKLJUČAK',
                style: pw.TextStyle(
                  font: ttfFont,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'o prodaji nepokretnosti',
                style: pw.TextStyle(
                  font: ttfFont,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'I\nOdređuje se prvo ročište za prodaju nekretnine u vlasništvu vlasnika ${ownerController.text}, ${adresaVlasnikaController.text}, ${cityController.text}, stan na nivou I, u ${adresaNekrentineController.text}, površine ${kvadraturaController.text},\n datuma ${dateController.text}, u ${satiController.text} sati.',
              style: pw.TextStyle(font: ttfFont, fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'II\nNa osnovu provedenog vještačenja po stalnom sudskom vještaku građevinske struke ${sudacController.text}, utvrđuje se da je ukupna vrijednost nekretnine ${priceController.text} KM',
              style: pw.TextStyle(font: ttfFont, fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'VII\nKupac nekretnine ne može biti osoba navedeno u čl. 88. Zakona o ovršnom postupku F BiH',
              style: pw.TextStyle(font: ttfFont, fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'VIII\nOvaj zaključak objavit će se na našoj web stranici, a stranka može, o svom trošku, zaključak objaviti i u sredstvima javnog informiranja, te mu se s toga u prilogu dostavljaju dva primjerka ovog Zaključka.',
              style: pw.TextStyle(font: ttfFont, fontSize: 12),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Sudac:\n${sudacController.text}',
              style: pw.TextStyle(
                  font: ttfFont, fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'PRAVNA POUKA:\nProtiv ovog zaključka nije dozvoljen pravni lijek.',
              style: pw.TextStyle(
                  font: ttfFont, fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    final output = Directory.systemTemp;
    final file = File("${output.path}/property_report.pdf");

    try {
      await file.writeAsBytes(await pdf.save());
      print("PDF uspešno sačuvan na: ${file.path}");
      OpenFile.open(file.path, type: "application/pdf");
    } catch (e) {
      print("Greška prilikom čuvanja PDF-a: $e");
    }
  }
void clearForm() {
  ownerController.clear();
  cityController.clear();
  priceController.clear();
  dateController.clear();
  sudacController.clear();
  kantonController.clear();
  brojController.clear();
  bankaController.clear();
  adresaVlasnikaController.clear();
  adresaNekrentineController.clear();
  kvadraturaController.clear();
  satiController.clear();
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Izvještaj o prodaji nekretnine'),
    ),
    body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOwnerCard(),
        const SizedBox(height: 12),
        _buildRealEstateContainer(),
        const SizedBox(height: 12),
        _buildCourtContainer(),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton.icon(
  onPressed: () async {
  await generatePDF(); // prvo generiši PDF
  clearForm();         // zatim očisti formu
},

  icon: const Icon(Icons.picture_as_pdf, size: 20),
  label: const Text(
    'Generiši izvještaj',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    backgroundColor: Colors.indigo, // elegantnija nijansa plave
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 6,
    shadowColor: Colors.black45,
  ),
),

        ),
      ],
    ),
  ),
),

  );
}

 Widget _buildOwnerCard() {
  return Center(
    child: Container(
      width: 600,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
  children: const [
    Icon(Icons.person, color: Color(0xFFBFA06B)),
    SizedBox(width: 8),
    Text(
      'Informacije o vlasniku',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  ],
),

              const SizedBox(height: 10),

              // Prvi red: Ime i prezime vlasnika + Adresa vlasnika
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ownerController,
                      decoration: const InputDecoration(
                        labelText: 'Ime i prezime vlasnika nekretnine',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: adresaVlasnikaController,
                      decoration: const InputDecoration(
                        labelText: 'Adresa vlasnika',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildRealEstateContainer() {
  return Center(
    child: Container(
      width: 600,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
  children: const [
    Icon(Icons.home_work, color: Color(0xFFBFA06B)),
    SizedBox(width: 8),
    Text(
      'Informacije o nekretnini',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  ],
),

              const SizedBox(height: 10),

              // Prvi red: Adresa i Kvadratura
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: adresaNekrentineController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Adresa nekretnine',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: kvadraturaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kvadratura nekretnine',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Drugi red: Grad i Cijena
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Grad',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cijena',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildCourtContainer() {
  return Center(
    child: Container(
      width: 600,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
  children: const [
    Icon(Icons.location_city, color: Color(0xFFBFA06B)),
    SizedBox(width: 8),
    Text(
      'Informacije o sudu, kantonu i gradu',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  ],
),

              const SizedBox(height: 10),

              // Prvi red: Datum, Sudac i Sati
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Datum',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: sudacController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sudac',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: satiController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sati',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Drugi red: Kanton, Broj ugovora i Banka
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: kantonController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kanton',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: brojController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Broj ugovora',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: bankaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Banka',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


}
