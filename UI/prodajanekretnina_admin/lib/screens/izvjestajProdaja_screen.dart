import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:open_file/open_file.dart';

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
final _formKey = GlobalKey<FormState>();


   final imePrezimeRegex = RegExp(r"^[A-Za-zČčĆćŽžŠšĐđ\s]+$");
  final adresaRegex = RegExp(r"^[A-Za-z0-9ČčĆćŽžŠšĐđ\s,-]+$");
  final brojRegex = RegExp(r"^[0-9]+$");
  final cijenaRegex = RegExp(r"^[0-9]+$");
  final gradRegex = RegExp(r"^[A-Za-zČčĆćŽžŠšĐđ\s]+$");
  final sudacRegex = RegExp(r"^[A-Za-zČčĆćŽžŠšĐđ\s]+$");
  final satiRegex = RegExp(r"^[0-9A-Za-zČčĆćŽžŠšĐđ\s:]+$");
  final kantonRegex = RegExp(r"^[A-Za-z0-9ČčĆćŽžŠšĐđ\s]+$");
  final bankaRegex = RegExp(r"^[A-Za-z0-9ČčĆćŽžŠšĐđ\s]+$");
  final brojUgovoraRegex = RegExp(r"^[A-Za-z0-9]+$");

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
      openFile(file.path);
      //OpenFile.open(file.path, type: "application/pdf");
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
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOwnerCard(),
          const SizedBox(height: 12),
          _buildRealEstateContainer(),
          const SizedBox(height: 12),
          _buildCourtContainer(),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await generatePDF();
                  clearForm();
                }
              },
              icon: const Icon(Icons.picture_as_pdf, size: 20),
              label: const Text(
                'Generiši izvještaj',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: Colors.indigo,
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
                    child:   _buildTextField(
                controller: ownerController,
                label: 'Ime i prezime vlasnika',
                invalidMessage: 'Unesite validno ime i prezime (samo slova i razmaci)',
                regex: imePrezimeRegex,
              ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                controller: adresaVlasnikaController,
                invalidMessage: 'Unesite validnu adresu (samo slova, brojevi i razmaci)',
                label: 'Adresa vlasnika',
                regex: adresaRegex,
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
                    child: _buildTextField(
                controller: adresaNekrentineController,
                label: 'Adresa nekrentine',
                regex: adresaRegex,
                invalidMessage: 'Unesite validnu adresu (samo slova, brojevi i razmaci)',
                keyboardType: TextInputType.number,
              ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child:  _buildTextField(
                controller: kvadraturaController,
                label: 'Kvadratura',
                regex: brojRegex,
                invalidMessage: 'Unesite validnu kvadraturu (samo brojevi)',
                keyboardType: TextInputType.number,
              ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Drugi red: Grad i Cijena
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                controller: cityController,
                label: 'Grad',
                regex: gradRegex,
                invalidMessage: 'Unesite validan grad (samo slova)',
                keyboardType: TextInputType.number,
              ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                controller: priceController,
                label: 'Cijena (KM)',
                regex: cijenaRegex,
                invalidMessage: 'Unesite validnu cijenu (samo brojevi)',
                keyboardType: TextInputType.number,
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
                    child: _buildTextField(
                controller: sudacController,
                label: 'Ime i prezime suca',
                regex: sudacRegex,
                invalidMessage: 'Unesite validno ime i prezime suca (samo slova i razmaci)',
                keyboardType: TextInputType.number,
              ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                controller: satiController,
                label: 'U koliko sati je zakazano',
                regex: satiRegex,
                invalidMessage: 'Unesite validno vrijeme (npr. 14:30h)',
                keyboardType: TextInputType.number,
              ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Drugi red: Kanton, Broj ugovora i Banka
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                controller: kantonController,
                label: 'Kanton',
                regex: kantonRegex,
                invalidMessage: 'Unesite validan kanton (npr. "Kanton 10")',
                keyboardType: TextInputType.number,
              ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                controller: brojController,
                label: 'Broj ugovora',
                regex: brojUgovoraRegex,
                invalidMessage: 'Unesite validan broj ugovora (npr. "12345")',
                keyboardType: TextInputType.number,
              ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                controller: bankaController,
                label: 'Banka',
                regex: bankaRegex,
                invalidMessage: 'Unesite validnu banku (npr. "NLB Banka")',
                keyboardType: TextInputType.number,
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
Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required RegExp regex,
  required String invalidMessage,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Polje ne smije biti prazno';
        }
        if (!regex.hasMatch(value)) {
          return invalidMessage;
        }
        return null;
      },
    ),
  );
}
Future<void> openFile(String filePath) async {
  final Uri uri = Uri.file(filePath);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Ne mogu otvoriti fajl: $filePath';
  }
}



}
