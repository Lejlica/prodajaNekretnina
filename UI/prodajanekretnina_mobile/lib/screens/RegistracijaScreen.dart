import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_mobile/models/drzave.dart';
import 'package:prodajanekretnina_mobile/models/gradovi.dart';

import 'package:prodajanekretnina_mobile/models/korisnici.dart';

import 'package:prodajanekretnina_mobile/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile/models/lokacije.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';

import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';

import 'package:prodajanekretnina_mobile/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

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

  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;

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
      // ignore: sort_child_properties_last
      child: Column(
        children: [
          _formBuild(),
        ],
      ),
      title: 'Registracija',
    );
  }

  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
                height: 500,
                decoration: BoxDecoration(
                    // Add your decoration properties here
                    ),
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      FormBuilderTextField(
                        name: 'ime',
                        decoration: InputDecoration(labelText: 'Ime'),
                      ),
                      FormBuilderTextField(
                        name: 'prezime',
                        decoration: InputDecoration(labelText: 'Prezime'),
                      ),
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      FormBuilderTextField(
                        name: 'telefon',
                        decoration: InputDecoration(labelText: 'Telefon'),
                      ),
                      FormBuilderTextField(
                        name: 'korisnickoIme',
                        decoration:
                            InputDecoration(labelText: 'Korisničko ime'),
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        decoration: InputDecoration(labelText: 'Lozinka'),
                      ),
                      FormBuilderTextField(
                        name: 'passwordPotvrda',
                        decoration:
                            InputDecoration(labelText: 'Potvrdite lozinku'),
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
                              Fluttertoast.showToast(
                                msg: "Lozinke se ne poklapaju!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              return;
                            }
                            print(
                                "formkey ${_formKey.currentState?.fields['korisnickoIme']?.value}");
                            List<dynamic> korisniciData = data!
                                .where((korisnik) =>
                                    korisnik.korisnickoIme ==
                                    _formKey.currentState
                                        ?.fields['korisnickoIme']?.value)
                                .toList();
                            if (korisniciData.isNotEmpty) {
                              print(
                                  "Korisnici Data kor ${korisniciData[0].korisnickoIme}, formkey ${_formKey.currentState?.fields['korisnickoIme']?.value}");
                            }

                            if (korisniciData.isNotEmpty) {
                              Fluttertoast.showToast(
                                msg:
                                    "Odabrano korisnicko ime nije dostupno. Molimo izaberite drugo.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              return;
                            }

                            Map<String, dynamic> request = {
                              'ime':
                                  _formKey.currentState?.fields['ime']?.value,
                              'prezime': _formKey
                                  .currentState?.fields['prezime']?.value,
                              'email':
                                  _formKey.currentState?.fields['email']?.value,
                              'telefon': _formKey
                                  .currentState?.fields['telefon']?.value,
                              'korisnickoIme': _formKey
                                  .currentState?.fields['korisnickoIme']?.value,
                              'password': _formKey
                                  .currentState?.fields['password']?.value,
                              'passwordPotvrda': _formKey.currentState
                                  ?.fields['passwordPotvrda']?.value,
                            };
                            String base64Image = await pickAndEncodeImage();

                            if (base64Image.isNotEmpty) {
                              // Add the image data to the request
                              request['bajtoviSlike'] = base64Image;
                            }
                            Korisnik insertedKorisnik =
                                await _korisniciProvider.insert(request);
                            int? insertedKorisnikId;
                            if (insertedKorisnik != null) {
                              insertedKorisnikId = insertedKorisnik.korisnikId;
                              _formKey.currentState?.reset();

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
                          },
                          child: Text('Registruj se'))
                    ])))));
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
