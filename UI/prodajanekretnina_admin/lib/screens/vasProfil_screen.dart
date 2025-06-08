import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  late TextEditingController _imeController;
  late TextEditingController _prezimeController;
  late TextEditingController _telefonController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
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

    _korisniciProvider = context.read<KorisniciProvider>();
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

                 
                  Korisnik? kora = korisnikk();
                  bajtovii = kora!.bajtoviSlike.toString();
                  bytes = base64.decode(bajtovii ?? '');
                  print("bytes $bytes");
                  
                  _korisnickoImeController.text =
                      kora.korisnickoIme.toString();
                  _emailController.text = kora.email.toString();
                  _telefonController.text = kora.telefon.toString();
                 
                  _imeController.text = kora.ime.toString();
                  _prezimeController.text = kora.prezime.toString();
                  
                  return _formBuild();
                } else {
               
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
                      SizedBox(
                        height: 16,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'ime',
                          controller: _imeController,
                          decoration: InputDecoration(
        labelText: 'Ime',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'prezime',
                          controller: _prezimeController,
                          decoration: InputDecoration(
        labelText: 'Prezime',
        prefixIcon: Icon(Icons.person_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'email',
                          controller: _emailController,
                          decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'telefon',
                          controller: _telefonController,
                          decoration: InputDecoration(
        labelText: 'Telefon',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'korisnickoIme',
                          controller: _korisnickoImeController,
                          decoration: InputDecoration(
        labelText: 'Korisničko ime',
        prefixIcon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'password',
                          controller: _passwordController,
                          decoration: InputDecoration(
        labelText: 'Lozinka',
        prefixIcon: Icon(Icons.password),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: FormBuilderField(
  name: 'imageId',
  builder: (field) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Odaberite sliku',
        
        errorText: field.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      child: InkWell(
        onTap: () async {
          selectedImagePath = await pickAndEncodeImage();
          setState(() {});
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            
            
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: const [
              Icon(Icons.image_outlined),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Odaberite sliku",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.upload_file_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  },
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
                    child: ElevatedButton.icon(
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
                      icon: const Icon(Icons.lock_reset, size: 20),
  label: const Text(
    'Izmjena lozinke',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
                      style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey, // Zlatna boja
    foregroundColor: Colors.black87,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 3,
  ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      String? enteredPassword = _formKey.currentState?.fields['password']?.value;

  if (enteredPassword == null || enteredPassword.trim().isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Greška!"),
        content: const Text("Da biste izvrsili promjene unesite Vasu lozinku!"),
        actions: [
          TextButton(
            child: const Text("Uredu"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
    return; // Prekini izvršavanje ako je prazno
  }
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
                      ).then((_) async {
  // Ovdje se izvršava kod nakon što se zatvori dijalog
  await initForm(); // ponovo učitaj podatke
  setState(() {});  // osvježi UI
});
                                        },
                    
                     icon: const Icon(Icons.save_alt, size: 20),
  label: const Text(
    'Sačuvaj izmjene',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo, // Zlatna
    foregroundColor: Colors.white, // Tekst i ikona
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
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
      return ''; 
    }
  }
}
