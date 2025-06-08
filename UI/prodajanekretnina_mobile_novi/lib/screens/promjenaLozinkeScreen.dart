import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_mobile_novi/models/drzave.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:crypto/crypto.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/models/lokacije.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';
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
  List<dynamic> data = [];
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _passwordOldController = TextEditingController();
    _passwordPotvrdaController = TextEditingController();

    _initialValue = {};

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _korisniciProvider?.get(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                 
                  return _formBuild();
                } else {
                
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

  Korisnik? korisnikk(String username) {
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

  int? korisnikId(String username) {
    List<dynamic> filteredData =
        data!.where((korisnik) => korisnik.korisnickoIme == username).toList();

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


  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    Korisnik? kora = korisnikk(Authorization.username.toString());
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
                        name: 'password',
                        controller: _passwordOldController,
                        decoration: InputDecoration(labelText: 'Stara lozinka'),
                        obscureText: true,
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Nova lozinka'),
                        obscureText: true,
                      ),
                      FormBuilderTextField(
                        name: 'passwordPotvrda',
                        controller: _passwordPotvrdaController,
                        decoration:
                            InputDecoration(labelText: 'Potvrdite lozinku'),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            Authorization.password =
                                _passwordOldController.text;
                          } catch (e) {
                            // Prikazi alert za neispravnu prethodnu lozinku
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

                          try {
                            int? korId = korisnikId(Authorization.username.toString());
                            bool success =
                                await _korisniciProvider.updatePassword(
                              korId!,
                              _passwordController.text,
                              request,
                            );
                            print("Success ${success}");
                            if (success == false) {
                          
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
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            ),
                                          );
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                            
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
                          } catch (error) {
                         
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Greška'),
                                  content: Text(
                                      '2Došlo je do greške prilikom ažuriranja lozinke. ${error}'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); 
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
                      )

                    
                    ])))));
  }

  Future<String> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
  
      Uint8List imageBytes = await pickedFile.readAsBytes();

  
      String base64Image = base64Encode(imageBytes);

      return base64Image.toString();
    } else {
      print('No image selected.');
      return ''; 
    }
  }
}
