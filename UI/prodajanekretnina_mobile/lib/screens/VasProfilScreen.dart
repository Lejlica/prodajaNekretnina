import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_mobile/models/drzave.dart';
import 'package:prodajanekretnina_mobile/models/gradovi.dart';
import 'package:crypto/crypto.dart';
import 'package:prodajanekretnina_mobile/models/korisnici.dart';
import 'package:prodajanekretnina_mobile/models/kupci.dart';
import 'package:prodajanekretnina_mobile/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile/models/lokacije.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/kupci.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_mobile/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile/screens/promjenaLozinkeScreen.dart';

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

class VasProfilScreen extends StatefulWidget {
  Nekretnina? nekretnina;
  Grad? grad;
  Korisnik? korisnik;

  VasProfilScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<VasProfilScreen> createState() => _VasProfilScreenState();
}

class _VasProfilScreenState extends State<VasProfilScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  late KupciProvider _kupciProvider;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;

  late NekretninaAgentiProvider _nekretninaAgentiProvider;

  late TextEditingController _imeController;
  late TextEditingController _prezimeController;
  late TextEditingController _telefonController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordPotvrdaController;
  late TextEditingController _korisnickoImeController;
  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;

  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  List<dynamic> data = [];
  List<dynamic> kupcidata = [];
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  @override
  void initState() {
    super.initState();

    _korisnickoImeController = TextEditingController();
    _emailController = TextEditingController();
    _telefonController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordPotvrdaController = TextEditingController();
    _imeController = TextEditingController();
    _prezimeController = TextEditingController();

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
    _kupciProvider = context.read<KupciProvider>();
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
      var tmpKupciData = await _kupciProvider?.get(null);
      setState(() {
        isLoading = false;
        kupcidata = tmpKupciData!;
        data = tmpKorisniciData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  String convertBytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  late Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      // ignore: sort_child_properties_last
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _korisniciProvider?.get(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String bajtovii;

                  String username = Authorization.username ?? "";

                  // Podaci su dohvaćeni, možete ih koristiti
                  Korisnik? kora = korisnikk();
                  bajtovii = kora!.bajtoviSlike.toString();
                  bytes = base64.decode(bajtovii ?? '');
                  print("bytes ${bytes}");
                  // Inicijalizacija kontrolera s podacima korisnika
                  _korisnickoImeController.text =
                      kora!.korisnickoIme.toString();
                  _emailController.text = kora!.email.toString();
                  _telefonController.text = kora!.telefon.toString();
                  // _passwordController.text = kora!.password.toString();
                  // _passwordPotvrdaController.text =
                  //kora!.passwordPotvrda.toString();
                  _imeController.text = kora!.ime.toString();
                  _prezimeController.text = kora!.prezime.toString();
                  // Vratite željeni widget koji koristi inicijalizirane kontrolere
                  return _formBuild();
                } else {
                  // Podaci se još uvijek dohvaćaju
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      title: 'Postavke Vašeg profila',
    );
  }

  Korisnik? korisnikk() {
    print('Username: $username');
    print('datica: $data');
    List<dynamic> filteredData = data!.where((korisnik) {
      print('KorisnickoIme: ${korisnik.korisnickoIme}');
      return korisnik.korisnickoIme == username;
    }).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0];
    } else {
      return null;
    }
  }

  int? korisnikId() {
    List<dynamic> filteredData =
        data!.where((korisnik) => korisnik.korisnickoIme == username).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }

  int? kupacId() {
    List<dynamic> filteredData =
        kupcidata!.where((kupac) => kupac.korisnickoIme == username).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].kupacId;
    } else {
      return null;
    }
  }

  String hashPassword(String password) {
    // Koristite odgovarajući algoritam za hashiranje, npr. SHA-256
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /* Korisnik? kora = korisnikk();
        print("kuki ${kora}");
        _korisnickoImeController =
            TextEditingController(text: kora!.korisnickoIme);
        _emailController = TextEditingController(text: kora!.email);
        _telefonController = TextEditingController(text: kora!.telefon);
        _passwordController = TextEditingController(text: kora!.password);
        _passwordPotvrdaController =
            TextEditingController(text: kora!.passwordPotvrda);
        _imeController = TextEditingController(text: kora!.ime);
        _prezimeController = TextEditingController(text: kora!.prezime);*/
  String? bajtovi() {
    List<dynamic> filteredData = data!.where((korisnik) {
      print('Korisnickooooime: ${korisnik.korisnickoIme}');
      return korisnik.korisnickoIme == username;
    }).toList();

    if (filteredData.isNotEmpty) {
      var bajtoviSlike = filteredData[0].bajtoviSlike;
      print('Bajtovi slike: $bajtoviSlike');
      return bajtoviSlike;
    } else {
      print('Filtered data is empty.');
      return null;
    }
  }

  FormBuilder _formBuild() {
    Korisnik? kora = korisnikk();
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
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: bytes.isNotEmpty
                            ? Image.memory(
                                bytes,
                                width: 300,
                                height: 300,
                                fit: BoxFit.contain,
                              )
                            : Container(),
                      ),
                      FormBuilderTextField(
                        name: 'ime',
                        controller: _imeController,
                        decoration: InputDecoration(labelText: 'Ime'),
                      ),
                      FormBuilderTextField(
                        name: 'prezime',
                        controller: _prezimeController,
                        decoration: InputDecoration(labelText: 'Prezime'),
                      ),
                      FormBuilderTextField(
                        name: 'email',
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      FormBuilderTextField(
                        name: 'telefon',
                        controller: _telefonController,
                        decoration: InputDecoration(labelText: 'Telefon'),
                      ),
                      FormBuilderTextField(
                        name: 'korisnickoIme',
                        controller: _korisnickoImeController,
                        decoration:
                            InputDecoration(labelText: 'Korisničko ime'),
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Stara lozinka',
                        ),
                        obscureText: true,
                      ),

                      /* FormBuilderTextField(
                        name: 'passwordPotvrda',
                        controller: _passwordController,
                        decoration:
                            InputDecoration(labelText: 'Potvrdite lozinku'),
                        obscureText: true,
                      ),*/
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              Authorization.password = _passwordController.text;
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text("Greška!"),
                                  content: Text(
                                      "Neispravna lozinka ili korisničko ime, pokušajte ponovo"),
                                  actions: [
                                    TextButton(
                                      child: Text("Uredu"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

/* {
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
                            }*/

                            /*if (_formKey
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
                            }*/

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
                              /*'passwordPotvrda': _formKey.currentState
                                  ?.fields['passwordPotvrda']?.value,*/
                              'passwordPotvrda': _formKey
                                  .currentState?.fields['password']?.value,
                            };
                            Map<String, dynamic> request2 = {
                              'ime':
                                  _formKey.currentState?.fields['ime']?.value,
                              'prezime': _formKey
                                  .currentState?.fields['prezime']?.value,
                              'email':
                                  _formKey.currentState?.fields['email']?.value,
                              'korisnickoIme': _formKey
                                  .currentState?.fields['korisnickoIme']?.value,
                              'password': _formKey
                                  .currentState?.fields['password']?.value,
                              /*'passwordPotvrda': _formKey.currentState
                                  ?.fields['passwordPotvrda']?.value,*/
                              'passwordPotvrda': _formKey
                                  .currentState?.fields['password']?.value,
                            };
                            String base64Image = await pickAndEncodeImage();

                            if (base64Image.isNotEmpty) {
                              // Add the image data to the request
                              request['bajtoviSlike'] = base64Image;
                            }
                            int? korId = korisnikId();
                            int? kupId = kupacId();
                            Korisnik insertedKorisnik = await _korisniciProvider
                                .update(korId!, request);
                            Kupci insertedKupac =
                                await _kupciProvider.update(kupId!, request2);
                            int? insertedKorisnikId;
                            if (insertedKorisnik != null) {
                              insertedKorisnikId = insertedKorisnik.korisnikId;
                              _formKey.currentState?.reset();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Uspješno sačuvane izmjene"),
                                    content: Text(
                                        "Vaše račun je uspješno ažuriran."),
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
                          child: Text('Sačuvaj izmjene')),
                      ElevatedButton(
                        onPressed: () {
                          dynamic matchingKorisnik = data?.firstWhere(
                            (korisnik) => korisnik.korisnickoIme == username,
                            orElse: () => null,
                          );

                          if (matchingKorisnik != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => promjenaLozinkeScreen(
                                  korisnik: matchingKorisnik,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Izmjena lozinke"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey, // Postavite ovde željenu boju
                        ),
                      ),
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
