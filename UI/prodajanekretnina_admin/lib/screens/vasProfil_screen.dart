import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:crypto/crypto.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';

import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';

import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';

import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/screens/izmjena_lozinke_screen.dart';
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
  // late KupciProvider _kupciProvider;
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
  late SearchResult<Korisnik> data;
  String? selectedImagePath;
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
    // _kupciProvider = context.read<KupciProvider>();
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
      //var tmpKupciData = await _kupciProvider?.get(null);
      setState(() {
        isLoading = false;
        // kupcidata = tmpKupciData!;
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
              future: _korisniciProvider.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String bajtovii;

                  String username = Authorization.username ?? "";

                  // Podaci su dohvaćeni, možete ih koristiti
                  Korisnik? kora = korisnikk();
                  bajtovii = kora!.bajtoviSlike.toString();
                  bytes = base64.decode(bajtovii ?? '');
                  print("bytes $bytes");
                  // Inicijalizacija kontrolera s podacima korisnika
                  _korisnickoImeController.text =
                      kora.korisnickoIme.toString();
                  _emailController.text = kora.email.toString();
                  _telefonController.text = kora.telefon.toString();
                  // _passwordController.text = kora!.password.toString();
                  // _passwordPotvrdaController.text =
                  //kora!.passwordPotvrda.toString();
                  _imeController.text = kora.ime.toString();
                  _prezimeController.text = kora.prezime.toString();
                  // Vratite željeni widget koji koristi inicijalizirane kontrolere
                  return _formBuild();
                } else {
                  // Podaci se još uvijek dohvaćaju
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      title: 'Postavke Vašeg profila',
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

  int? kupacId() {
    List<dynamic> filteredData =
        kupcidata.where((kupac) => kupac.korisnickoIme == username).toList();

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
    List<dynamic> filteredData = data.result.where((korisnik) {
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
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        child: Card(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _image != null
                    ? Center(
                        child: Column(
                          children: [
                            // White container with text

                            // Image container with border
                            Container(
                              width: 250,
                              height: 250,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                              ),
                              child: ClipOval(
                                child: Image.file(
                                  _image!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: bytes.isNotEmpty
                            ? ClipOval(
                                child: Image.memory(
                                  bytes,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'ime',
                          controller: _imeController,
                          decoration: const InputDecoration(labelText: 'Ime'),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'prezime',
                          controller: _prezimeController,
                          decoration: const InputDecoration(labelText: 'Prezime'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'email',
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'telefon',
                          controller: _telefonController,
                          decoration: const InputDecoration(labelText: 'Telefon'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'korisnickoIme',
                          controller: _korisnickoImeController,
                          decoration:
                              const InputDecoration(labelText: 'Korisničko ime'),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'password',
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Stara lozinka',
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: FormBuilderField(
                        name: 'imageId',
                        builder: ((field) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Odaberite sliku',
                              errorText: field.errorText,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                      4.0), // Smanjite vrednost za manje zaobljenje
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.photo),
                                  title: const Text(
                                    "Odaberite sliku",
                                    style: TextStyle(
                                        fontSize:
                                            14), // Postavite željenu veličinu fonta
                                  ),
                                  trailing: const Icon(Icons.file_upload),
                                  onTap: () async {
                                    selectedImagePath =
                                        await pickAndEncodeImage();
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 680),
                    child: ElevatedButton(
                      onPressed: () {
                        dynamic matchingKorisnik = data.result.firstWhere(
                          (korisnik) => korisnik.korisnickoIme == username,
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
                      child: const Text(
                        'Izmjena lozinke',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        Authorization.password = _passwordController.text;
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Greška!"),
                            content: const Text(
                                "Neispravna lozinka ili korisničko ime, pokušajte ponovo"),
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
                        'ime': _formKey.currentState?.fields['ime']?.value,
                        'prezime':
                            _formKey.currentState?.fields['prezime']?.value,
                        'email': _formKey.currentState?.fields['email']?.value,
                        'telefon':
                            _formKey.currentState?.fields['telefon']?.value,
                        'korisnickoIme': _formKey
                            .currentState?.fields['korisnickoIme']?.value,
                        'password':
                            _formKey.currentState?.fields['password']?.value,
                        'passwordPotvrda':
                            _formKey.currentState?.fields['password']?.value,
                      };

                      if (selectedImagePath != null &&
                          selectedImagePath!.isNotEmpty) {
                        // Dodajte podatke o slici zahtevu
                        request['bajtoviSlike'] = selectedImagePath;
                      }
                      int? korId = korisnikId();
                      Korisnik insertedKorisnik =
                          await _korisniciProvider.update(korId!, request);

                      int? insertedKorisnikId;
                      insertedKorisnikId = insertedKorisnik.korisnikId;
                      _formKey.currentState?.reset();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Uspješno sačuvane izmjene"),
                            content: Text("Vaš račun je uspješno ažuriran."),
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
                                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 82, 120, 150),
                      // Postavite željenu boju ovdje
                    ),
                    child: const Text(
                      'Sačuvaj izmjene',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
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
        _image = File(pickedFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
            });
      return base64Image.toString();
    } else {
      print('No image selected.');
      return ''; // or handle accordingly
    }
  }
}
