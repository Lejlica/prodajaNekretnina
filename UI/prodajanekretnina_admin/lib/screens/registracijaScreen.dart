import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';

import 'package:prodajanekretnina_admin/models/korisnici.dart';

import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/models/korisnici_uloge.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';

import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_uloge_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_admin/main.dart';

import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class RegistracijaScreen extends StatefulWidget {
  Nekretnina? nekretnina;
  Grad? grad;

  RegistracijaScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<RegistracijaScreen> createState() => _RegistracijaScreenState();
}

/*Future<Uint8List?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Read the selected image as bytes
    Uint8List? bytes = await pickedFile.readAsBytes();
    return bytes;
  }

  return null;
}*/

class _RegistracijaScreenState extends State<RegistracijaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  String? selectedImagePath;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;
  late KorisniciUlogeProvider _korisniciUlogeProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;

  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  List<dynamic> data = [];
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<KorisniciUloge>? korisniciUlogeResult;
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

    _nekretnineProvider = NekretnineProvider();

    _korisniciProvider = context.read<KorisniciProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _korisniciUlogeProvider = KorisniciUlogeProvider();
    _gradoviProvider = context.read<GradoviProvider>();
    _drzaveProvider = context.read<DrzaveProvider>();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      
      var tmpKorisniciData = await _korisniciProvider?.get();
korisniciUlogeResult = await _korisniciUlogeProvider.get();
      print(korisniciUlogeResult);
      setState(() {
        isLoading = false;
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
    return Scaffold(
      appBar: AppBar(
        // Postavite svojstva AppBar-a prema potrebi
        title: Text('Registracija'),
      ),
      body: _formBuild(),
      endDrawer: null, // Ovo će onemogućiti otvaranje bočnog menija
    );
  }

  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
          padding: EdgeInsets.all(40.0),
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    // Rows containing pairs of form fields
                    _image != null
                        ? Center(
                            child: Column(
                              children: [
                                // White container with text
                                Container(
                                  width: 300,
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Vaša profilna slika', // Replace with the actual property name
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Image container with border
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.file(
                                      _image!,
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                // Default profile picture container
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        150), // Half of the width/height
                                    color: Colors
                                        .grey, // Choose your default profile picture color
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 150,
                                    color: Colors
                                        .white, // Choose the color of the icon
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'ime',
                              decoration: InputDecoration(labelText: 'Ime'),
                            ),
                          ),
                          SizedBox(width: 100),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'prezime',
                              decoration: InputDecoration(labelText: 'Prezime'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'email',
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                          ),
                          SizedBox(width: 100),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'telefon',
                              decoration: InputDecoration(labelText: 'Telefon'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'password',
                              obscureText:
                                  true, // Set this to true to display dots
                              decoration: InputDecoration(labelText: 'Lozinka'),
                            ),
                          ),
                          SizedBox(width: 100),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'passwordPotvrda',
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Potvrdite lozinku'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'korisnickoIme',
                              decoration:
                                  InputDecoration(labelText: 'Korisničko ime'),
                            ),
                          ),
                          SizedBox(width: 100),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: FormBuilderField(
                                name: 'imageId',
                                builder: ((field) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Odaberite sliku',
                                      errorText: field.errorText,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.photo),
                                        title: Text("Odaberite sliku"),
                                        trailing: Icon(Icons.file_upload),
                                        onTap: () async {
                                          selectedImagePath =
                                              await pickAndEncodeImage();
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey
                                  .currentState?.fields['password']?.value !=
                              _formKey.currentState?.fields['passwordPotvrda']
                                  ?.value) {
                            AlertDialog(
                              title: Text("Upozorenje"),
                              content: Text("Lozinke se ne poklapaju!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                            return;
                          }
                          print(
                              "formkey ${_formKey.currentState?.fields['korisnickoIme']?.value}");
                          List<dynamic> korisniciData = data!
                              .where((korisnik) =>
                                  korisnik.korisnickoIme ==
                                  _formKey.currentState?.fields['korisnickoIme']
                                      ?.value)
                              .toList();
                          if (korisniciData.isNotEmpty) {
                            print(
                                "Korisnici Data kor ${korisniciData[0].korisnickoIme}, formkey ${_formKey.currentState?.fields['korisnickoIme']?.value}");
                          }

                          if (korisniciData.isNotEmpty) {
                            AlertDialog(
                              title: Text("Greška"),
                              content: Text(
                                  "Odabrano korisnicko ime nije dostupno. Molimo izaberite drugo."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          }

                          Map<String, dynamic> request = {
                            'ime': _formKey.currentState?.fields['ime']?.value,
                            'prezime':
                                _formKey.currentState?.fields['prezime']?.value,
                            'email':
                                _formKey.currentState?.fields['email']?.value,
                            'telefon':
                                _formKey.currentState?.fields['telefon']?.value,
                            'korisnickoIme': _formKey
                                .currentState?.fields['korisnickoIme']?.value,
                            'password': _formKey
                                .currentState?.fields['password']?.value,
                            'passwordPotvrda': _formKey
                                .currentState?.fields['passwordPotvrda']?.value,
                          };

                          /* String base64Image = await pickAndEncodeImage();
            
                              if (base64Image.isNotEmpty) {
                                // Dodajte podatke o slici zahtevu
                                request['bajtoviSlike'] = base64Image;
                              }*/
                          if (selectedImagePath != null &&
                              selectedImagePath!.isNotEmpty) {
                            // Dodajte podatke o slici zahtevu
                            request['bajtoviSlike'] = selectedImagePath;
                          }

                          Korisnik insertedKorisnik =
                              await _korisniciProvider.insert(request);
                          int? insertedKorisnikId;
                          if (insertedKorisnik != null) {
                            insertedKorisnikId = insertedKorisnik.korisnikId;
                            _formKey.currentState?.reset();

                            if (insertedKorisnikId != -1) {
                              Map<String, dynamic> ulogeRequest = {
                                'korisnikId': insertedKorisnikId,
                                'ulogaId': 1,
                              };

                              // Call the insert method from korisniciUlogeProvider
                              _korisniciUlogeProvider.insert(ulogeRequest);
                            }

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Registracija uspješna"),
                                  content: Text(
                                      "Vaš račun je uspješno registriran."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Uredu"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          if (insertedKorisnikId != null) {
                            // Uspješna registracija, preusmeravanje na LoginPage
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        },
                        child: Text('Registruj se')),
                  ])))),
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

  File? _image;
  String? _base64Image;
  Future<String> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Read the file as bytes
      Uint8List imageBytes = await pickedFile.readAsBytes();

      // Convert the bytes to base64
      String base64Image = base64Encode(imageBytes);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          _base64Image = base64Encode(_image!.readAsBytesSync());
        }
      });
      return base64Image.toString();
    } else {
      print('No image selected.');
      return ''; // or handle accordingly
    }
  }
}
