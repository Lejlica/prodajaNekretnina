import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_admin/models/agencija.dart';
import 'dart:ui';  // za ImageFilter
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
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
import 'package:prodajanekretnina_admin/providers/agencije_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/main.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
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
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  late AgencijaProvider _agencijeProvider;
  String? selectedImagePath;
  late KorisniciUlogeProvider _korisniciUlogeProvider;
  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
SearchResult<Agencija>? agencijeResult;
SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
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

   

    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciUlogeProvider = KorisniciUlogeProvider();
    _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
    _agencijeProvider = context.read<AgencijaProvider>();
   
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      
      var tmpKorisniciData = await _korisniciProvider.get();
korisniciUlogeResult = await _korisniciUlogeProvider.get();
      print(korisniciUlogeResult);
      agencijeResult = await _agencijeProvider.get();
      korisnikAgencijaResult =
          await _korisnikAgencijaProvider.get();
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
 String selectedAgencijaId = '';
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Registracija'),
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        // Pozadinska slika sa blur efektom
        Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
        ),
        // Blur efekt preko slike
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0), // prozirni sloj da blur radi
          ),
        ),
        // Glavni sadržaj forme
        _formBuild(),
      ],
    ),
    endDrawer: null,
  );
}


  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
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
                                  decoration: const BoxDecoration(
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
                                    color: const Color.fromARGB(255, 255, 255, 255), // Choose your default profile picture color
                                  ),
                                  child: const Icon(
                                    Icons.account_circle,
                                    size: 150,
                                    color: Color.fromARGB(255, 169, 176, 243), // Choose the color of the icon
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        children: [
                          Expanded(
  child: FormBuilderTextField(
    name: 'ime',
    decoration: InputDecoration(
      labelText: 'Ime',
      prefixIcon: const Icon(Icons.person, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Prazno polje";
      }
      return null;
    },
  ),
),

                          const SizedBox(width: 100),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'prezime',
                               decoration: InputDecoration(
      labelText: 'Prezime',
      prefixIcon: const Icon(Icons.person_outline, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
                               validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Prazno polje";
                                                          }
                                                          return null;
                                                        },
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
    decoration: InputDecoration(
      labelText: 'Email',
      prefixIcon: const Icon(Icons.email, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Polje ne smije biti prazno";
      }
      // Regex za osnovnu provjeru email formata
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return "Unesite ispravan email (npr. primjer@domena.com)";
      }
      return null;
    },
  ),
),

                          const SizedBox(width: 100),
                          Expanded(
  child: FormBuilderTextField(
    name: 'telefon',
     decoration: InputDecoration(
      labelText: 'Telefon',
      prefixIcon: const Icon(Icons.phone, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Polje ne smije biti prazno";
      }
      final phoneRegex = RegExp(r'^(?:\+387|0)?[ \-]?(?:[0-9]{2})[ \-]?[0-9]{3}[ \-]?[0-9]{3,4}$');
      if (!phoneRegex.hasMatch(value)) {
        return "Unesite ispravan broj telefona (npr. +38761234567 ili 061234567)";
      }
      return null;
    },
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
    name: 'password',
    obscureText: true, // Prikaz točkica umjesto slova
     decoration: InputDecoration(
      labelText: 'Lozinka',
      prefixIcon: const Icon(Icons.password, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Polje ne smije biti prazno";
      }
      if (value.length < 4) {
        return "Lozinka mora sadržavati najmanje 4 znaka";
      }
      return null;
    },
  ),
),

                          const SizedBox(width: 100),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'passwordPotvrda',
                              obscureText: true,
                               decoration: InputDecoration(
      labelText: 'Potvrda lozinke',
      prefixIcon: const Icon(Icons.password_outlined, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
                                  validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Prazno polje";
                                                          }
                                                          return null;
                                                        },
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
                               decoration: InputDecoration(
      labelText: 'Korisničko ime',
      prefixIcon: const Icon(Icons.account_circle_outlined, color: Color.fromARGB(255, 92, 83, 58)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
      ),
    ),
                                   validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Prazno polje";
                                                          }
                                                          return null;
                                                        },
                            ),
                          ),
                          const SizedBox(width: 100),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
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
                                    child: Container(
                                      decoration: BoxDecoration(
    // ili bilo koja boja pozadine
    border: Border.all(
      color: Colors.grey, // boja ivice
      width: 1.0, // debljina ivice
    ),
    borderRadius: BorderRadius.circular(8.0), // zaobljenje ivica
  ),
                                      child: ListTile(
                                        leading: const Icon(Icons.photo),
                                        title: const Text("Odaberite sliku"),
                                        trailing: const Icon(Icons.file_upload),
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

                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: () async {
                          final isValid = _formKey.currentState?.saveAndValidate() ?? false;

        if (!isValid) {
          // Ako forma nije validna, prikaži upozorenje
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Upozorenje'),
                content: Text('Molimo vas da popunite sva polja.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }
                          if (_formKey
                                  .currentState?.fields['password']?.value !=
                              _formKey.currentState?.fields['passwordPotvrda']
                                  ?.value) {
                            AlertDialog(
                              title: const Text("Upozorenje"),
                              content: const Text("Lozinke se ne poklapaju!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                            return;
                          }
                          print(
                              "formkey ${_formKey.currentState?.fields['korisnickoIme']?.value}");
                          List<dynamic> korisniciData = data
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
                              title: const Text("Greška"),
                              content: const Text(
                                  "Odabrano korisnicko ime nije dostupno. Molimo izaberite drugo."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
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
                                                  if (insertedKorisnikId != null) {
                                                    showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Potvrda"),
                                  content: SingleChildScrollView(
                                    child: FormBuilderDropdown<String>(
                                      name: 'korisnikAgencijaId',
                                      decoration: InputDecoration(
                                        labelText: 'Agencija*',
                                        suffix: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            _formKey.currentState!
                                                .fields['korisnikAgencijaId']
                                                ?.reset();
                                          },
                                        ),
                                        hintText: 'Odaberite agenciju',
                                      ),
                                      onChanged: (newValue) {
                                        _formKey.currentState
                                            ?.fields['korisnikAgencijaId']
                                            ?.didChange(newValue);
                                        selectedAgencijaId = newValue ?? '';
                                      },
                                      items: agencijeResult?.result
                                              .map((Agencija k) =>
                                                  DropdownMenuItem(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    value:
                                                        k.agencijaId.toString(),
                                                    child: Text(
                                                        k.naziv.toString()),
                                                  ))
                                              .toList() ??
                                          [],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Map<String, dynamic>
                                            korisnikAgencijaRequest = {
                                          'korisnikId': insertedKorisnikId,
                                          'agencijaId': selectedAgencijaId,
                                        };

                                        _korisnikAgencijaProvider
                                            .insert(korisnikAgencijaRequest);

                                        Navigator.of(context).pop();
                                        Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                                        
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                            // Uspješna registracija, preusmeravanje na LoginPage
                            
                          }
                        },
                         icon: const Icon(
    Icons.person_add,
    color: Colors.white,
  ),
  label: const Text(
    'Registruj se',
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.1,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF5A67D8),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
  ),)
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
