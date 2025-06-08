import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_mobile_novi/models/drzave.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:crypto/crypto.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/models/lokacije.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile_novi/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/promjenaLozinkeScreen.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
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
  late KupciProvider _kupciProvider;
  late Uint8List bytes;
  late TextEditingController _imeController;
  late TextEditingController _prezimeController;
  late TextEditingController _telefonController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordPotvrdaController;
  late TextEditingController _korisnickoImeController;
  bool isLoading = true;
ValueNotifier<Uint8List?> _imageBytesNotifier = ValueNotifier<Uint8List?>(null);

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
bool _imageInitialized = false;
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

 
    _kupciProvider = context.read<KupciProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
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
      var korisnik = korisnikk(Authorization.username.toString()); 

    if (korisnik != null &&
        korisnik.bajtoviSlike != null &&
        korisnik.bajtoviSlike!.isNotEmpty) {
      base64Image = korisnik.bajtoviSlike!;
      bytes = base64.decode(base64Image!);
    }
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
    if (snapshot.connectionState == ConnectionState.waiting) {
      
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Došlo je do greške!'));
      } else if (!snapshot.hasData || snapshot.data == null) {
        return Center(child: Text('Korisnik nije pronađen.'));
      }
   else {
      String username = Authorization.username ?? "";
      Korisnik? kora = korisnikk(Authorization.username.toString());

      if (kora == null) {
  return const Center(child: Text('Niste prijavljeni ili korisnik nije pronađen.'));
}

     
     if (!_imageInitialized && kora?.bajtoviSlike != null) {
  bytes = base64.decode(kora!.bajtoviSlike!);
  base64Image = kora.bajtoviSlike!;
  _imageInitialized = true;
}


      _korisnickoImeController.text = kora!.korisnickoIme ?? '';
      _emailController.text = kora.email ?? '';
      _telefonController.text = kora.telefon ?? '';
      _imeController.text = kora.ime ?? '';
      _prezimeController.text = kora.prezime ?? '';

      return _formBuild();
    } 
  },
),

          ],
        ),
      ),
      title: 'Postavke Vašeg profila',
    );
  }

  Korisnik? korisnikk(String username) {
    print('Username: $username');
    print('datica: $data');
    List<dynamic> filteredData = data!.where((korisnik) {
      print('KorisnickoIme: ${korisnik.korisnickoIme}');
      return korisnik.korisnickoIme == username;
    }).toList();

    if (filteredData.isNotEmpty) {
       print('KorisnickoIme: ${filteredData[0].korisnickoIme}');
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
   
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

 
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
    Korisnik? kora = korisnikk(Authorization.username.toString());
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
               
                decoration: BoxDecoration(
                  
                    ),
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      Padding(
  padding: const EdgeInsets.only(top: 20.0),
  child: StatefulBuilder(
  builder: (context, setLocalState) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipOval(
          child: bytes != null
              ? Image.memory(
                  bytes!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 80, color: Colors.white),
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                Uint8List imageBytes = await pickedFile.readAsBytes();
                setLocalState(() {
                  bytes = imageBytes;
                  base64Image = base64Encode(imageBytes);
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  },
),

),


                      FormBuilderTextField(
                        name: 'ime',
                        controller: _imeController,
                        decoration: InputDecoration(
              labelText: 'Ime',
              prefixIcon: Icon(Icons.person),
            ),validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Unesite Vase ime';
          }
          return null;
        },
                      ),
                      FormBuilderTextField(
                        name: 'prezime',
                        controller: _prezimeController,
                        decoration: InputDecoration(
              labelText: 'Prezime',
              prefixIcon: Icon(Icons.person_outline),
            ),validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Unesite Vase prezime';
          }
          return null;
        },
                      ),
                      FormBuilderTextField(
                        name: 'email',
                        controller: _emailController,
                        decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
                      ),
                      FormBuilderTextField(
                        name: 'telefon',
                        controller: _telefonController,
                        decoration: InputDecoration(
              labelText: 'Telefon',
              prefixIcon: Icon(Icons.phone),
            ),
                      ),
                      FormBuilderTextField(
  name: 'korisnickoIme',
  controller: _korisnickoImeController,
  enabled: false,
  decoration: InputDecoration(
    labelText: 'Korisničko ime',
    helperText: 'Ovo polje nije moguće mijenjati',
    prefixIcon: Icon(Icons.account_box),
    filled: true,
    fillColor: Colors.grey.shade200, 
  ),
),


                      FormBuilderTextField(
                        name: 'password',
                        controller: _passwordController,
                        decoration: InputDecoration(
              labelText: 'Lozinka',
              prefixIcon: Icon(Icons.lock),
            ),
                        obscureText: true,
                      ),

                     
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton.icon(
  onPressed: () async {
    try {
      if (_formKey.currentState!.validate()) {
        if (_passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Molimo Vas unesite Vasu lozinku",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          return;
        }

        Authorization.password = _passwordController.text;

        Map<String, dynamic> request = {
          'ime': _formKey.currentState?.fields['ime']?.value,
          'prezime': _formKey.currentState?.fields['prezime']?.value,
          'email': _formKey.currentState?.fields['email']?.value,
          'telefon': _formKey.currentState?.fields['telefon']?.value,
          'korisnickoIme': _formKey.currentState?.fields['korisnickoIme']?.value,
          'password': _formKey.currentState?.fields['password']?.value,
          'passwordPotvrda': _formKey.currentState?.fields['password']?.value,
          'clientId': 'tvojClientId',
          'clientSecret': 'tvojClientSecret',
        };

      
        if (base64Image != null && base64Image!.isNotEmpty) {
  request['bajtoviSlike'] = base64Image;
}


        int? korId = korisnikId();
        int? kupId = kupacId();

        if (korId == null || kupId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Nije moguće pronaći korisnički ID ili kupac ID.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          return;
        }

        await _korisniciProvider.update(korId, request);
        await _kupciProvider.update(kupId, request);

        Navigator.of(context).pushReplacement(
  MaterialPageRoute(
    builder: (context) => VasProfilScreen(),
  ),
);


        _formKey.currentState?.reset();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Vaš račun je uspješno ažuriran.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                
              ],

            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      print("Greška: $e");

      if (e.toString().contains('Unauthorized')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Lozinka ili korisničko ime nije ispravno, pokušajte ponovo.",
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Došlo je do greške prilikom obrade.\n$e",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: Duration(seconds: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  },
  icon: Icon(Icons.save_alt, color: Colors.white),
  label: Text(
    "Sačuvaj izmjene",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF4CAF50), // zelena - osjećaj sigurnosti
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 6,
    shadowColor: Colors.black45,
    textStyle: const TextStyle(
      letterSpacing: 0.5,
    ),
  ),
),
SizedBox(height: 15),



                      ElevatedButton.icon(
                        onPressed: () {
                          dynamic matchingKorisnik = data?.firstWhere(
                            (korisnik) => korisnik.korisnickoIme == Authorization.username,
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
                         icon: Icon(Icons.lock_reset, color: Color(0xFF3F51B5)),
  label: Text(
    "Izmijeni lozinku",
    style: TextStyle(
      color: Color(0xFF3F51B5),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
 
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    foregroundColor: Color(0xFF3F51B5),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 6,
    shadowColor: Colors.black45,
    textStyle: const TextStyle(
      letterSpacing: 0.5,
    ),
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

String base64Image = '';
  Future<String> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
     
      Uint8List imageBytes = await pickedFile.readAsBytes();

     
       base64Image = base64Encode(imageBytes);

      return base64Image.toString();
    } else {
      print('No image selected.');
      return ''; 
    }
  }
}
