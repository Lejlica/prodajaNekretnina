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
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_mobile/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/screens/PaymentScreen.dart';
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

class UnesiClientPaypalPodatkeScreen extends StatefulWidget {
  Kupci? korisnik;
  Nekretnina? nekretnina;
  UnesiClientPaypalPodatkeScreen({Key? key, this.korisnik, this.nekretnina})
      : super(key: key);

  @override
  State<UnesiClientPaypalPodatkeScreen> createState() =>
      _UnesiClientPaypalPodatkeScreenState();
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

class _UnesiClientPaypalPodatkeScreenState
    extends State<UnesiClientPaypalPodatkeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  TextEditingController clientIdController = TextEditingController();
  TextEditingController clientSecretController = TextEditingController();
  late KupciProvider _kupciProvider;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;

  late NekretninaAgentiProvider _nekretninaAgentiProvider;

  late TextEditingController _passwordController;

  late TextEditingController _passwordOldController;
  late TextEditingController _passwordPotvrdaController;

  bool isLoading = true;
  List<dynamic> kupcidata = [];
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

    _passwordController = TextEditingController();
    _passwordOldController = TextEditingController();
    _passwordPotvrdaController = TextEditingController();

    _initialValue = {};

    _nekretnineProvider = NekretnineProvider();

    _korisniciProvider = context.read<KorisniciProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _kupciProvider = context.read<KupciProvider>();
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
                  // Podaci su dohvaćeni, možete ih koristiti

                  // Inicijalizacija kontrolera s podacima korisnika

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
      title: 'Informacije o paypal nalogu',
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

  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
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
                      FormBuilderTextField(
                        name: 'clientId',
                        controller: clientIdController,
                        decoration:
                            InputDecoration(labelText: 'Unesite vaš ClientId'),
                        obscureText: true,
                      ),
                      FormBuilderTextField(
                        name: 'clientSecret',
                        controller: clientSecretController,
                        decoration: InputDecoration(
                            labelText: 'Unesite vaš ClientSecret'),
                        obscureText: true,
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Vaša lozinka',
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> request = {
                              'ime': widget.korisnik?.ime,
                              'prezime': widget.korisnik?.prezime,
                              'email': widget.korisnik?.email,
                              'korisnickoIme': widget.korisnik?.korisnickoIme,
                              'password': _formKey
                                  .currentState?.fields['password']?.value,
                              'passwordPotvrda': _formKey
                                  .currentState?.fields['password']?.value,
                              'clientId': _formKey
                                  .currentState?.fields['clientId']?.value,
                              'clientSecret': _formKey
                                  .currentState?.fields['clientSecret']?.value,
                            };

                            int? kupId = kupacId();

                            Kupci insertedKupac =
                                await _kupciProvider.update(kupId!, request);

                            if (insertedKupac != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PaymentPage(
                                    
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text('Spremi'))

                      /* ElevatedButton(
                        onPressed: () async {
                          try {
                            Authorization.password =
                                _passwordOldController.text;
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("Greška!"),
                                content: Text(
                                    "Neispravna prethodna lozinka, pokušajte ponovo"),
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
                            'ime': widget.korisnik?.ime,
                            'prezime': widget.korisnik?.prezime,
                            'email': widget.korisnik?.email,
                            'telefon': widget.korisnik?.telefon,
                            'korisnickoIme': widget.korisnik?.korisnickoIme,
                            'password': _formKey
                                .currentState?.fields['password']?.value,
                            'passwordPotvrda': _formKey
                                .currentState?.fields['passwordPotvrda']?.value,
                          };
                          request.forEach((key, value) {
                            print('$key: $value');
                          });
                          try {
                            int? korId = korisnikId();
                            await _korisniciProvider.updatePassword(
                              korId!,
                              _passwordController.text,
                              request,
                            );
                            // Uspješno izvršena promjena lozinke, prikaži success alert
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Uspješno'),
                                  content:
                                      Text('Lozinka je uspješno ažurirana.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Zatvori alert
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (error) {
                            // Došlo je do greške, prikaži error alert
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Greška'),
                                  content: Text(
                                      'Došlo je do greške prilikom ažuriranja lozinke.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Zatvori alert
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('Sačuvaj izmjene'),
                      )*/
                    ])))));
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
