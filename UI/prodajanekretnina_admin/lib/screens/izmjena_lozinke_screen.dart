import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:crypto/crypto.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';


class promjenaLozinkeScreen extends StatefulWidget {
  Korisnik? korisnik;

  promjenaLozinkeScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<promjenaLozinkeScreen> createState() => _promjenaLozinkeScreenState();
}

class _promjenaLozinkeScreenState extends State<promjenaLozinkeScreen> {
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

  late TextEditingController _passwordController;

  late TextEditingController _passwordOldController;
  late TextEditingController _passwordPotvrdaController;

  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;

  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  late SearchResult<Korisnik> data;
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
      var tmpKorisniciData = await _korisniciProvider.get();

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
    _nekretnineProvider = context.read<NekretnineProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Izmjena lozinke"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 1050),
          child: Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, 
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.5, 
                      child: Image.asset(
                        "assets/images/pswd.jpg",
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.5, // Set the width for the FutureBuilder
                        child: FutureBuilder(
                          future: _korisniciProvider.get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              
                              return _formBuild();
                            } else {
                              
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String username = Authorization.username ?? "";
  Korisnik? korisnikk() {
    print('Username: $username');
    print('datica: $data');
    List<dynamic> filteredData = data.result.where((korisnik) {
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
    List<dynamic> filteredData = data.result
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].korisnikId;
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

 
  bool _passwordsMatch = true;
  final bool _passwordsMatchh = false;
  bool arePasswordsMatching() {
    return _passwordController.text == _passwordPotvrdaController.text;
  }

  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    Korisnik? kora = korisnikk();
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30),
            child: Container(
              height: 500,
              width: 300,
              decoration: const BoxDecoration(
                 
                  ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const Text(
                      "Promjena lozinke",
                      style: TextStyle(
                        fontSize: 20.0, 
                        fontWeight:
                            FontWeight.bold, 
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      controller: _passwordOldController,
                      decoration: const InputDecoration(labelText: 'Stara lozinka'),
                      obscureText: true,
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Nova lozinka'),
                      obscureText: true,
                    ),
                    FormBuilderTextField(
                      name: 'passwordPotvrda',
                      controller: _passwordPotvrdaController,
                      decoration:
                          const InputDecoration(labelText: 'Potvrdite lozinku'),
                      obscureText: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (!_passwordsMatch)
                      const Text(
                        'Lozinke se ne poklapaju',
                        style: TextStyle(color: Colors.red),
                      ),
                    Row(children: [
                      Expanded(
                          child: ElevatedButton.icon(
                        onPressed: () async {
                          _passwordOldController.text = '';
                          _passwordController.text = '';
                          _passwordPotvrdaController.text = '';
                        },
                        
                        icon: const Icon(Icons.cancel, size: 20),
  label: const Text(
    'Odustani',
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey, // Zlatna
    foregroundColor: Colors.white, // Tekst i ikona
    padding: const EdgeInsets.symmetric(horizontal:8, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
  ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            _passwordsMatch = arePasswordsMatching();
                            try {
                              Authorization.password =
                                  _passwordOldController.text;
                            } catch (e) {
                              // Prikazi alert za neispravnu prethodnu lozinku
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Greška!"),
                                  content: const Text(
                                      "Neispravna prethodna lozinka, pokušajte ponovo"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Uredu"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            Map<String, dynamic> request = {
                              'ime': widget.korisnik?.ime,
                              'prezime': widget.korisnik?.prezime,
                              'email': widget.korisnik?.email,
                              'telefon': widget.korisnik?.telefon,
                              'korisnickoIme': widget.korisnik?.korisnickoIme,
                              'password': _formKey
                                  .currentState?.fields['password']?.value,
                              'passwordPotvrda': _formKey.currentState
                                  ?.fields['passwordPotvrda']?.value,
                            };

                            try {
                              int? korId = korisnikId();
                              bool success =
                                  await _korisniciProvider.updatePassword(
                                korId!,
                                _passwordController.text,
                                request,
                              );
                              print("Success $success");
                              if (success == true) {
                                _formKey.currentState?.reset();
                                _passwordPotvrdaController.clear();
  
                               
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Uspješno'),
                                      content: const Text(
                                          'Lozinka je uspješno ažurirana.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Zatvori alert
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Ažuriranje lozinke nije uspjelo, prikaži odgovarajući alert
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Greška'),
                                      content: const Text(
                                          'Došlo je do greške prilikom ažuriranja lozinke.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Zatvori alert
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } catch (error) {
                              // Došlo je do greške, prikaži error alert
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Greška'),
                                    content: Text(
                                        '2Došlo je do greške prilikom ažuriranja lozinke. $error'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Zatvori alert
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                           icon: const Icon(Icons.save_alt, size: 20),
  label: const Text(
    'Sačuvaj izmjene',
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo, // Zlatna
    foregroundColor: Colors.white, // Tekst i ikona
    padding: const EdgeInsets.symmetric(horizontal:8, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
  ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
