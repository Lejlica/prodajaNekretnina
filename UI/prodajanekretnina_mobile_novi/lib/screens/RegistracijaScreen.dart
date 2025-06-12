import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_mobile_novi/models/drzave.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/models/lokacije.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnikUloge.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikUloge_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile_novi/main.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class RegistracijaScreen extends StatefulWidget {
  Nekretnina? nekretnina;
  Grad? grad;

  RegistracijaScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<RegistracijaScreen> createState() => _RegistracijaScreenState();
}


class _RegistracijaScreenState extends State<RegistracijaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late KorisnikUlogeProvider _korisnikUlogeProvider;

  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
  SearchResult<KorisnikUloge>? korisnikUlogeResult;
  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  List<dynamic> data = [];
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  @override
  void initState() {
    super.initState();

    _initialValue = {
      'cijena': widget.nekretnina?.cijena?.toString(),
      'datumDodavanja': widget.nekretnina?.datumDodavanja.toString(),
      'datumIzmjene': widget.nekretnina?.datumIzmjene?.toString(),
      'isOdobrena': widget.nekretnina?.isOdobrena?.toString(),
      'kategorijaId': widget.nekretnina?.kategorijaId?.toString(),
      'korisnikId': widget.nekretnina?.korisnikId?.toString(),
      'lokacijaId': widget.nekretnina?.lokacijaId?.toString(),
      'tipNekretnineId': widget.nekretnina?.tipNekretnineId?.toString(),
      'nekretninaId': widget.nekretnina?.nekretninaId?.toString(),
      'gradId': lokacija?.gradId.toString(),
      'nekretninaId': widget.nekretnina?.nekretninaId.toString(),
      'korisnikAgentId': agent?.korisnikId.toString()
    };

 

    _korisniciProvider = context.read<KorisniciProvider>();
_korisnikUlogeProvider=context.read<KorisnikUlogeProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      var tmpKorisniciData = await _korisniciProvider?.get(null);

      setState(() {
        isLoading = false;
        data = tmpKorisniciData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  String convertBytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  @override
Widget build(BuildContext context) {
  return MasterScreenWidget(
    title: 'Registracija',
    child: SingleChildScrollView( // Omogućava skrolovanje cijelog sadržaja
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _formBuild(),
      ),
    ),
  );
}


 FormBuilder _formBuild() {
  String username = Authorization.username ?? "";

  return FormBuilder(
    key: _formKey,
    initialValue: _initialValue,
    child: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 4,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Registracija',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E88E5),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              _buildTextField('ime', 'Ime', Icons.person),
              _buildTextField('prezime', 'Prezime', Icons.person_outline),
              _buildTextField('email', 'Email', Icons.email),
              _buildTextField('telefon', 'Telefon', Icons.phone),
              _buildTextField('korisnickoIme', 'Korisničko ime', Icons.account_circle),
              _buildTextField('password', 'Lozinka', Icons.lock, obscure: true),
              _buildTextField('passwordPotvrda', 'Potvrdite lozinku', Icons.lock_outline, obscure: true),

              SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () async {
                  if (!_formKey.currentState!.saveAndValidate()) {
    // Ako bilo koje polje nije validno, ne nastavljamo
    return;
  }
                  if (_formKey.currentState?.fields['password']?.value !=
                      _formKey.currentState?.fields['passwordPotvrda']?.value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Lozinke se ne poklapaju!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  print("formkey ${_formKey.currentState?.fields['korisnickoIme']?.value}");
                  List<dynamic> korisniciData = data!
                      .where((korisnik) =>
                          korisnik.korisnickoIme ==
                          _formKey.currentState?.fields['korisnickoIme']?.value)
                      .toList();

                  if (korisniciData.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Odabrano korisnicko ime nije dostupno. Molimo izaberite drugo.",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  Map<String, dynamic> request = {
                    'ime': _formKey.currentState?.fields['ime']?.value,
                    'prezime': _formKey.currentState?.fields['prezime']?.value,
                    'email': _formKey.currentState?.fields['email']?.value,
                    'telefon': _formKey.currentState?.fields['telefon']?.value,
                    'korisnickoIme': _formKey.currentState?.fields['korisnickoIme']?.value,
                    'password': _formKey.currentState?.fields['password']?.value,
                    'passwordPotvrda': _formKey.currentState?.fields['passwordPotvrda']?.value,
                  };

                  String base64Image = await pickAndEncodeImage();

                  if (base64Image.isNotEmpty) {
                    request['bajtoviSlike'] = base64Image;
                  }

                  Korisnik insertedKorisnik = await _korisniciProvider.insert(request);
                  int? insertedKorisnikId;

                  if (insertedKorisnik != null) {
                    insertedKorisnikId = insertedKorisnik.korisnikId;
                    _formKey.currentState?.reset();

                    Map<String, dynamic> korisnikUlogaRequest = {
                      "korisnikId": insertedKorisnikId,
                      "ulogaId": 3,
                    };

                    try {
                      await _korisnikUlogeProvider.insert(korisnikUlogaRequest);
                    } catch (e) {
                      print("Greška prilikom dodavanja uloge korisniku: $e");
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(width: 10),
        Text("Registracija uspješna!"),
      ],
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.all(16),
  ),
);
Future.delayed(Duration(seconds: 2), () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );
});
                  }
                },
                icon: Icon(Icons.app_registration),
                label: Text('Registruj se'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget _buildTextField(String name, String label, IconData icon,
    {bool obscure = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: FormBuilderTextField(
      name: name,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Polje "$label" je obavezno.';
        }
        if (name == 'email' && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Unesite validan email (npr. korisnik@example.com)';
        }
        if (name == 'telefon' && !RegExp(r'^\+?\d{6,15}$').hasMatch(value)) {
          return 'Unesite validan broj telefona (npr. 987654321)';
        }
        if (name == 'password' || name == 'passwordPotvrda') {
          if (value.length < 4) {
            return 'Lozinka mora imati najmanje 4 karaktera.';
          }
        }
        return null; 
      },
    ),
  );
}



  Lokacija? lokacija;
  void getGrad() {
    var lokacijaId = widget.nekretnina?.lokacijaId;
    if (lokacijaId != null &&
        lokacijeResult != null &&
        lokacijeResult?.result != null) {
      lokacija = lokacijeResult?.result.firstWhere(
        (lokacija) => lokacija.lokacijaId == lokacijaId,
      );
    }
  }

  NekretninaAgenti? agent;
  void getAgent() {
    var nekretninaId = widget.nekretnina?.nekretninaId;
    if (nekretninaId != null &&
        nekretninaAgentiResult != null &&
        nekretninaAgentiResult?.result != null) {
      agent = nekretninaAgentiResult?.result.firstWhere(
        (agent) => agent.nekretninaId == nekretninaId,
      );
    }
  }

  Future<String> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Read the file as bytes
      Uint8List imageBytes = await pickedFile.readAsBytes();

      // Convert the bytes to base64
      String base64Image = base64Encode(imageBytes);

      return base64Image.toString();
    } else {
      print('No image selected.');
      return ''; // or handle accordingly
    }
  }
}
