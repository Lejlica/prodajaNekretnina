import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izvještaj o prodaji nekretnine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOwnerCard(),
              SizedBox(height: 20),
              _buildRealEstateContainer(),
              SizedBox(height: 20),
              _buildCourtContainer(),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: generatePDF,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Postavi plavu boju buttona
                    onPrimary: Colors.white, // Postavi bijelu boju slova
                  ),
                  child: Text('Generiši Izvještaj'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOwnerCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informacije o Vlasniku',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ownerController,
              decoration: InputDecoration(labelText: 'Vlasnik'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: adresaVlasnikaController,
              decoration: InputDecoration(labelText: 'Adresa vlasnika'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRealEstateContainer() {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informacije o Nekretnini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: adresaNekrentineController,
              decoration: InputDecoration(labelText: 'Adresa nekretnine'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: kvadraturaController,
              decoration: InputDecoration(labelText: 'Kvadratura nekretnine'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Grad'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Cijena'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourtContainer() {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informacije o Sudu, Kantonu i Gradu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Datum'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: sudacController,
              decoration: InputDecoration(labelText: 'Sudac'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: satiController,
              decoration: InputDecoration(labelText: 'Sati'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: kantonController,
              decoration: InputDecoration(labelText: 'Kanton'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: brojController,
              decoration: InputDecoration(labelText: 'Broj ugovora'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: bankaController,
              decoration: InputDecoration(labelText: 'Banka'),
            ),
          ],
        ),
      ),
    );
  }
}
