import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/kategorijeNekretnina.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/kategorijeNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/models/tipAkcije.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class NekretnineDetaljiScreen extends StatefulWidget {
  Nekretnina? nekretnina;
  Grad? grad;

  NekretnineDetaljiScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<NekretnineDetaljiScreen> createState() =>
      _NekretnineDetaljiScreenState();
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

class _NekretnineDetaljiScreenState extends State<NekretnineDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  late KategorijeNekretninaProvider _kategorijeNekretninaProvider;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late TipAkcijeProvider _tipAkcijeProvider;

  SearchResult<NekretninaTipAkcije>? nekretninaTipAkcijeResult;
  SearchResult<TipAkcije>? tipAkcijeResult;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  bool samostalnaJedinicaChecked = false;
  bool visejedinicnaChecked = false;
  bool isCkecked = false;
  bool isLoading = true;
  bool isOdobrena = true;
  bool novogradnjaChecked = false;
  bool namjestenChecked = false;
  bool parkingMjestoChecked = false;
  SearchResult<Korisnik>? korisniciResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
  SearchResult<KategorijaNekretnine>? kategorijeResult;
  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  Future<void> loadInitialData() async {
  try {
    // Učitavanje podataka iz providera
    nekretninaTipAkcijeResult = await _nekretninaTipAkcijeProvider.get();
    tipAkcijeResult = await _tipAkcijeProvider.get();
    kategorijeResult = await _kategorijeNekretninaProvider.get();
    tipoviResult = await _tipoviNekretninaProvider.get();
    lokacijeResult = await _lokacijeProvider.get();
    gradoviResult = await _gradoviProvider.get();
    drzaveResult = await _drzaveProvider.get();
    korisniciResult = await _korisniciProvider.get();
    nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
    // Dobavljanje tipAkcijeId iz međutabele
    final tipAkcijeId = getTipAkcije();

    print("Učitan tipAkcijeId: $tipAkcijeId");

    // Postavljanje _initialValue mape
    
      _initialValue = {
        'naziv': widget.nekretnina?.naziv?.toString(),
        'cijena': widget.nekretnina?.cijena?.toString(),
        'datumDodavanja': widget.nekretnina?.datumDodavanja.toString(),
        'datumIzmjene': widget.nekretnina?.datumIzmjene?.toString(),
        'isOdobrena': true,
        'kategorijaId': widget.nekretnina?.kategorijaId?.toString(),
        'korisnikId': widget.nekretnina?.korisnikId?.toString(),
        'lokacijaId': widget.nekretnina?.lokacijaId?.toString(),
        'tipNekretnineId': widget.nekretnina?.tipNekretnineId?.toString(),
        'nekretninaId': widget.nekretnina?.nekretninaId?.toString(),
        'gradId': lokacija?.gradId.toString(),
        'korisnikAgentId': agent?.korisnikId.toString(),
        'tipAkcijeId': tipAkcijeId?.toString(),
        'naziv': widget.nekretnina?.naziv?.toString(),
        'detaljanOpis': widget.nekretnina?.detaljanOpis?.toString(),
        'kvadratura': widget.nekretnina?.kvadratura?.toString(),
        'novogradnja': widget.nekretnina?.novogradnja,
        'brojSoba': widget.nekretnina?.brojSoba?.toString(),
        'parkingMjesto': widget.nekretnina?.parkingMjesto,
        'brojSpavacihSoba': widget.nekretnina?.brojSpavacihSoba?.toString(),
        'namjesten': widget.nekretnina?.namjesten,
        'sprat': widget.nekretnina?.sprat?.toString(),
        'brojUgovora': widget.nekretnina?.brojUgovora?.toString(),
      };

      isLoading = false;
    setState(() {
      isLoading = false;
    });
  } catch (e) {
    print("Greška pri učitavanju podataka: $e");
    // Po želji: obradi grešku
    setState(() {
      isLoading = false;
    });
  }
}

  @override
void initState() {
  super.initState();
  _nekretninaTipAkcijeProvider = NekretninaTipAkcijeProvider();
  _tipAkcijeProvider = TipAkcijeProvider();
  _nekretnineProvider = NekretnineProvider();
    _kategorijeNekretninaProvider = KategorijeNekretninaProvider();
    _korisniciProvider = context.read<KorisniciProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _kategorijeNekretninaProvider =
        context.read<KategorijeNekretninaProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _drzaveProvider = context.read<DrzaveProvider>();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
     

  loadInitialData();
}


  NekretninaTipAkcije? nekTipAk;
  void getnekTipAk() {
    var nekretninaId = widget.nekretnina?.nekretninaId;
    if (nekretninaId != null && nekretninaTipAkcijeResult != null) {
      nekTipAk = nekretninaTipAkcijeResult?.result.firstWhere(
        (nekTipAk) => nekTipAk.nekretninaId == nekretninaId,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      korisniciResult = await _korisniciProvider.get();
      print(korisniciResult);
      tipoviResult = await _tipoviNekretninaProvider.get();
      print(tipoviResult);
      lokacijeResult = await _lokacijeProvider.get();
      print(lokacijeResult);
      kategorijeResult = await _kategorijeNekretninaProvider.get();
      print(kategorijeResult);
      gradoviResult = await _gradoviProvider.get();
      print(gradoviResult);
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
      print('nekrAgenti $nekretninaAgentiResult');
      nekretninaTipAkcijeResult = await _nekretninaTipAkcijeProvider.get();
      print('nekretninaTipAkcijeResult $nekretninaTipAkcijeResult');
      tipAkcijeResult = await _tipAkcijeProvider.get();
      print('tipAkcijeResult $tipAkcijeResult');

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

  Future<void> uploadImageToApi(
    String? base64Image,
    int? nekretninaId,
  ) async {
    print('BASE64: $base64Image');

    try {
      String apiUrl =
          'http://localhost:7189/Slike';
      String username = Authorization.username ?? "";
      String password = Authorization.password ?? "";

      Map<String, dynamic> requestBody = {
        'imageBase64': base64Image,
        'nekretninaId':
            nekretninaId, 
      };

      String jsonBody = jsonEncode(requestBody);

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$username:$password'))}',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Image upload failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }
  }

  Future<void> insertData(Map<dynamic, dynamic> request) async {
    try {
      // Insert the property data
      if (widget.nekretnina == null) {
        var insertedProperty = await _nekretnineProvider.insert(request);
        print('Insert Result: $insertedProperty');
print("_base64Imagee: $_base64Image");
        if (_base64Image != null) {
          await uploadImageToApi(_base64Image, insertedProperty.nekretninaId);
          // Include nekretninaId and korisnikAgentId in the request
          request['nekretninaId'] = insertedProperty.nekretninaId;
          var agentId = request['korisnikAgentId'];
          var tipAkcijeId = request['tipAkcijeId'];

          if (agentId != null) {
            // Assuming _nekretninaAgentiProvider has an appropriate insert method
            await _nekretninaAgentiProvider.insert(request);
          }
          if (tipAkcijeId != null) {
            // Assuming _nekretninaAgentiProvider has an appropriate insert method
            await _nekretninaTipAkcijeProvider.insert(request);
          }
        }
        else {
          print("Ulazim u ELSE blok");
          await uploadImageToApi(_base64Image, insertedProperty.nekretninaId);
          // Include nekretninaId and korisnikAgentId in the request
          request['nekretninaId'] = insertedProperty.nekretninaId;
          var agentId = request['korisnikAgentId'];
          var tipAkcijeId = request['tipAkcijeId'];

          if (agentId != null) {
            // Assuming _nekretninaAgentiProvider has an appropriate insert method
            await _nekretninaAgentiProvider.insert(request);
          }
          if (tipAkcijeId != null) {
            // Assuming _nekretninaAgentiProvider has an appropriate insert method
            await _nekretninaTipAkcijeProvider.insert(request);
          }
        }
      } 
       
    } catch (e) {
      print('Error during insertData: $e');
    }
  }
String formatDateForDotNet(DateTime date) {
  final formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
  final milliseconds = date.millisecond.toString().padLeft(3, '0');
  final microRemainder = (date.microsecond % 1000).toString().padLeft(3, '0');

  // Napravi sedam cifara: 3 (ms) + 3 (micro) + 1 (0) = 7 ukupno
  final fractionalSeconds = "$milliseconds$microRemainder" + "0";

  return "${formatter.format(date)}.$fractionalSeconds";
}

  final TextEditingController _nazivController = TextEditingController();
  final TextEditingController _detaljanOpisController = TextEditingController();
  final TextEditingController _cijenaController = TextEditingController();
  final TextEditingController _kvadraturaController = TextEditingController();
  final TextEditingController _brojSobaController = TextEditingController();
  final TextEditingController _brojSpavacihSobaController = TextEditingController();
  final TextEditingController _brojSpratovaController = TextEditingController();
  final TextEditingController _brojUgovoraController = TextEditingController();
  final TextEditingController _datumDodavanjaController = TextEditingController();
  final TextEditingController _datumIzmjeneController = TextEditingController();
  void _provjeriPolja() {
    if (_detaljanOpisController.text.isEmpty ||
        _cijenaController.text.isEmpty ||
        _kvadraturaController.text.isEmpty ||
        _nazivController.text.isEmpty) {
      // Jedno ili više polja nisu popunjena, prikažite alert.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Upozorenje'),
            content: const Text('Molimo vas da popunite sva polja.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
     
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
    return const Center(child: CircularProgressIndicator()); 
    }
    return MasterScreenWidget(
      title: widget.nekretnina?.naziv.toString() ?? "",
      child: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _formBuild(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
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
        if (_base64Image == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Nedostaje slika'),
                content: Text('Dodavanje slike je obavezno. Molimo odaberite sliku.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }

                          
                          _formKey.currentState?.saveAndValidate();
                          print(
                              "Form data before API call: ${_formKey.currentState?.value}");
                          print(_formKey.currentState?.value['Naziv']);

                          

                          var requestForm =
                              new Map.from(_formKey.currentState!.value);


                               var request = {
      'cijena': _cijenaController.text,
      'datumDodavanja': DateTime.now().toIso8601String(),
      'datumIzmjene':DateTime.now().toIso8601String() ,
      'isOdobrena': true,
      'kategorijaId': requestForm['kategorijaId'],
      'korisnikId': requestForm['korisnikId'],
      'lokacijaId': requestForm['lokacijaId'],
      'tipNekretnineId': requestForm['tipNekretnineId'],
      'nekretninaId': requestForm['nekretninaId'],
      'gradId': requestForm['gradId'],
      'korisnikAgentId': requestForm['korisnikAgentId'],
      'tipAkcijeId': requestForm['tipAkcijeId'],
      'naziv': _nazivController.text,
      'detaljanOpis': _detaljanOpisController.text,
     'kvadratura': int.tryParse(_kvadraturaController.text) ?? 0,
      'novogradnja': novogradnjaNotifier.value,
      'brojSoba': 3,
      'parkingMjesto': parkingMjestoNotifier.value,
      'brojSpavacihSoba': 3,
      'namjesten': namjestenNotifier.value,
      'sprat': 3,
      'brojUgovora': 3333,
    };

                              

                  request['slika'] = _base64Image;


                          request['parkingMjesto'] = parkingMjestoNotifier.value;

                          print("requestic: ${request['slika']}");

                          try {
                            print('u foru');
                            print("Naziv: ${_nazivController.text}");
                              print("Detaljan opis: ${_detaljanOpisController.text}");
                              print("Kvadratura: ${_kvadraturaController.text}");

                                                          if (widget.nekretnina == null) {
                                var result = await insertData(request);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Uspješno'),
                                      content: const Text('Nekretnina je uspješno dodana.'),
                                      actions: [
                                        TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // zatvori dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => NekretnineDetaljiScreen()),
                                  );
                                },
                                child: const Text('OK'),
                              ),

                                      ],
                                    );
                                  },
                                );
                              } else {
                              var result = await _nekretnineProvider.update(
                                  widget.nekretnina!.nekretninaId!, request);
                              await uploadImageToApi(_base64Image,
                                  widget.nekretnina!.nekretninaId!);
                              print("Update Result: $result");
                            }
                            _initialValue = {
                              'cijena': "",
                              'datumDodavanja': "",
                              'datumIzmjene': "",
                              'isOdobrena': "",
                              'kategorijaId': "",
                              'korisnikId': "",
                              'lokacijaId': "",
                              'tipNekretnineId': "",
                              'nekretninaId': "",
                              'gradId': "",
                              'nekretninaId': "",
                              'korisnikAgentId': "",
                              'tipAkcijeId': "",
                              'naziv': "",
                              'detaljanOpis': "",
                              'kvadratura': "",
                              'novogradnja': "",
                              'brojSoba': "",
                              'parkingMjesto': "",
                              'brojSpavacihSoba': "",
                              'namjesten': "",
                              'sprat': "",
                              'brojUgovora': "",
                            };
                            /*Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NekretnineDetaljiScreen(),
                              ),
                            );*/
                          } on Exception catch (e) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("OK"))
                                      ],
                                    ));
                            /*}*/
                          }
                        },
                        child: Text("Sačuvaj"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  NekretninaTipAkcije? nta;
  TipAkcije? ta;
  int? getTipAkcije() {
    
    if (nekretninaTipAkcijeResult != null) {
      nta = nekretninaTipAkcijeResult?.result.firstWhere(
        (nta) => nta.nekretninaId == widget.nekretnina?.nekretninaId,
      );

      ta = tipAkcijeResult?.result
          .firstWhere((e) => e.tipAkcijeId == nta!.tipAkcijeId);
        print("tip akcijeee");
        print(ta?.tipAkcijeId);
      return ta?.tipAkcijeId;
      
    }
    return null;
  }

  ValueNotifier<bool> parkingMjestoNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> novogradnjaNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> namjestenNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> slikaNotifier = ValueNotifier<bool>(false);
  final bool _autoValidate = false;
  FormBuilder _formBuild() {
    return FormBuilder(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        initialValue: _initialValue,
        child: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Center(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        height: 500,
                        decoration: const BoxDecoration(
                            /*border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(255, 255, 255, 0.6),*/
                            ),

                        //padding: EdgeInsets.all(16.0), // Add your desired padding value
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 10),
                                const SizedBox(height: 20),
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                    ), // Dodaj lijevu marginu
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Card(
                                        color:
                                            const Color.fromARGB(255, 246, 244, 244),
                                        child: SingleChildScrollView(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 1.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 151, 176, 197),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                8.0),
                                                        topRight:
                                                            Radius.circular(
                                                                8.0),
                                                      ), // Adjust the radius as needed
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(10.0),

                                                    width: 800,
                                                    height:
                                                        60, // Set the background color to white
                                                    
                                                  ),
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      VerticalDivider(
                                                        width: 7.0,
                                                        color: Colors.blue,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            'Trebate izabrati agenta za nekretninu kako biste dodali nekretninu.',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                    height: 80,
                                                    child: SingleChildScrollView(
                                                      child: FormBuilderDropdown<String>(
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Prazno polje";
                                                          }
                                                          return null;
                                                        },
                                                        name: 'korisnikAgentId',
                                                        decoration: InputDecoration(
                                                          labelText: 'Agent*',
                                                          hintText: 'Odaberite agenta',
                                                        ),
                                                        onChanged: (newValue) {
                                                          _formKey.currentState?.fields['korisnikAgentId']?.didChange(newValue);
                                                        },
                                                        items: korisniciResult?.result
                                                                .map((Korisnik k) => DropdownMenuItem<String>(
                                                                      alignment: AlignmentDirectional.center,
                                                                      value: k.korisnikId.toString(),
                                                                      child: Text(k.ime.toString()),
                                                                    ))
                                                                .toList() ??
                                                            [],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const Divider(
                                                  color: Colors.black,
                                                  height:
                                                      10, // Adjust the height of the line
                                                  thickness:
                                                      0.2, // Adjust the thickness of the line
                                                ),
                                               
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: FutureBuilder<
                                                          SearchResult<Slika>>(
                                                        future: SlikeProvider()
                                                            .get(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const CircularProgressIndicator();
                                                          } else if (snapshot
                                                              .hasData) {
                                                            SearchResult<Slika>?
                                                                slike =
                                                                snapshot.data;

                                                            if (slike != null &&
                                                                slike.result
                                                                    .isNotEmpty &&
                                                                widget.nekretnina !=
                                                                    null) {
                                                              // Create a list of image URLs from the data
                                                              List<String> imageUrls = slike
                                                                  .result
                                                                  .where((slika) =>
                                                                      slika
                                                                          .nekretninaId ==
                                                                      widget
                                                                          .nekretnina!
                                                                          .nekretninaId)
                                                                  .map((slika) =>
                                                                      slika
                                                                          .bajtoviSlike ??
                                                                      "")
                                                                  .toList();

                                                              // Check if there are images to display in the carousel
                                                              if (imageUrls
                                                                  .isNotEmpty) {
                                                                return CarouselSlider(
                                                                  options:
                                                                      CarouselOptions(
                                                                    height:
                                                                        300.0, // Adjust the height of the slider as needed
                                                                    autoPlay:
                                                                        true, // Enable auto-playing of images
                                                                    enlargeCenterPage:
                                                                        true,
                                                                    viewportFraction:
                                                                        0.8, // Adjust the size of the images
                                                                    aspectRatio:
                                                                        16 / 9,
                                                                  ),
                                                                  items: imageUrls
                                                                      .map(
                                                                          (imageUrl) {
                                                                    return Builder(
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AspectRatio(
                                                                          aspectRatio:
                                                                              16 / 9, // Set the desired aspect ratio
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 5.0),
                                                                            child:
                                                                                imageFromBase64String(imageUrl),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }).toList(),
                                                                );
                                                              } else {
                                                                return const Text('');
                                                              }
                                                            } else {
                                                              return const Text('');
                                                            }
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return const Text(
                                                                'Greška prilikom dobavljanja slika');
                                                          } else {
                                                            return const Text('');
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                
                                                _image != null
                                                    ? Center(
                                                        child: Column(
                                                          children: [
                                                            // White container with text
                                                            Container(
                                                              width: 300,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white, // Choose your border color
                                                                  width:
                                                                      2.0, // Choose your border width
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8.0),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              
                                                            ),
                                                            // Image container with border
                                                            Container(
                                                              width: 300,
                                                              height: 300,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          8.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8.0),
                                                                ), // Optional: Add border radius
                                                                image:
                                                                    DecorationImage(
                                                                  image: FileImage(
                                                                      _image!),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0,
                                        left: 5.0), // Dodaj lijevu marginu
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Card(
                                        color: const Color.fromARGB(
                                            255, 246, 244, 244),
                                        child: SingleChildScrollView(
                                          child: Column(children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.all(20.0),
                                              child: Text(
                                                "OPŠTE INFORMACIJE",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
  children: [
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FormBuilderTextField(
          controller: _nazivController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Naziv",
            border: OutlineInputBorder(),
          ),
          name: "naziv",
          onChanged: (newValue) {
            _formKey.currentState?.fields['naziv']?.didChange(newValue);
          },
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FormBuilderDropdown<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          name: 'korisnikId',
          decoration: const InputDecoration(
            labelText: 'Vlasnik',
            hintText: 'Odaberite vlasnika',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          onChanged: (newValue) {
            _formKey.currentState?.fields['korisnikId']?.didChange(newValue);
          },
          items: korisniciResult?.result
                  .map((k) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: k.korisnikId.toString(),
                        child: Text(k.ime.toString()),
                      ))
                  .toList() ??
              [],
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FormBuilderDropdown<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          name: 'lokacijaId',
          decoration: const InputDecoration(
            labelText: 'Lokacija',
            hintText: 'Odaberite lokaciju',
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            _formKey.currentState?.fields['lokacijaId']?.didChange(newValue);
          },
          items: lokacijeResult?.result
                  .map((lokacija) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: lokacija.lokacijaId.toString(),
                        child: Text(lokacija.ulica.toString()),
                      ))
                  .toList() ??
              [],
        ),
      ),
    ),
  ],
),
SizedBox(height: 10), 
                                                  Row(
  children: [
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FormBuilderDropdown<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          name: 'kategorijaId',
          decoration: const InputDecoration(
            labelText: 'Kategorija nekretnine',
            hintText: 'Odaberite kategoriju',
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            _formKey.currentState?.fields['kategorijaId']?.didChange(newValue);
          },
          items: kategorijeResult?.result.map((k) => DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            value: k.kategorijaId.toString(),
            child: Text(k.naziv.toString()),
          )).toList() ?? [],
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FormBuilderDropdown<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          name: 'tipAkcijeId',
          decoration: const InputDecoration(
            labelText: 'Tip akcije',
            hintText: 'Odaberite tip akcije',
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            _formKey.currentState?.fields['tipAkcijeId']?.didChange(newValue);
          },
          items: tipAkcijeResult?.result.map((k) => DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            value: k.tipAkcijeId.toString(),
            child: Text(k.naziv.toString()),
          )).toList() ?? [],
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FormBuilderDropdown<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          name: 'tipNekretnineId',
          decoration: const InputDecoration(
            labelText: 'Tip nekretnine',
            hintText: 'Odaberite tip nekretnine',
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            _formKey.currentState?.fields['tipNekretnineId']?.didChange(newValue);
          },
          items: tipoviResult?.result.map((k) => DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            value: k.tipNekretnineId.toString(),
            child: Text(k.nazivTipa.toString()),
          )).toList() ?? [],
        ),
      ),
    ),
  ],
), SizedBox(height: 10),Row(
  children: [
    const SizedBox(width: 10),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FormBuilderTextField(
          controller: _brojSobaController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            if (int.tryParse(value) == null) {
              return "Unesite validan broj";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Broj soba",
          ),
          name: "brojSoba",
          keyboardType: TextInputType.number,
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FormBuilderTextField(
          controller: _brojSpavacihSobaController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            if (int.tryParse(value) == null) {
              return "Unesite validan broj";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Broj spavaćih soba",
          ),
          name: "brojSpavacihSoba",
          keyboardType: TextInputType.number,
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FormBuilderTextField(
          controller: _brojSpratovaController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            if (int.tryParse(value) == null) {
              return "Unesite validan broj";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Broj spratova",
          ),
          name: "brojSpratova",
          keyboardType: TextInputType.number,
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: FormBuilderTextField(
          controller: _cijenaController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Cijena",
          ),
          name: "cijena",
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: FormBuilderTextField(
          controller: _kvadraturaController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }

            // Validacija da unos bude broj
            if (int.tryParse(value) == null) {
              return "Unesite validan broj";
            }

            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Kvadratura",
          ),
          name: "kvadratura",
          keyboardType: TextInputType.number, // Tastatura za unos brojeva
        ),
      ),
    ),
    const SizedBox(width: 10),
  ],
),

            SizedBox(height: 10),                                      
                                                      
                                                    

                              Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    
    Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: FormBuilderTextField(
          controller: _detaljanOpisController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Prazno polje";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Detaljan opis",
          ),
          name: "detaljanOpis",
          maxLines: 2, // Omogućava unos više linija
        ),
      ),
    ),
  ],
),

                                                  
SizedBox(height: 10),

                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 50.0,
                                                                    right: 40),
                                                            child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                child:
                                                                    FormBuilderField(
                                                                  name:
                                                                      'imageId',
                                                                  builder:
                                                                      ((field) {
                                                                    return InputDecorator(
                                                                      decoration: InputDecoration(
                                                                        border:InputBorder.none,
                                                                         
                                                                          errorText:
                                                                              field.errorText),
                                                                      child:
                                                                          ElevatedButton.icon(
                          onPressed: getImage,
                          icon: const Icon(Icons.image),
                          label: const Text("Odaberi sliku"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 108, 171, 178),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                                                                    );
                                                                  }),
                                                                ))),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  const Divider(
                                                    color: Colors.black,
                                                    height:
                                                        10, // Adjust the height of the line
                                                    thickness:
                                                        0.2, // Adjust the thickness of the line
                                                  ),
                                                  const SizedBox(height: 30),
                                                  
                                                 
                                                  
                                                  const Text(
                                                    "DODATNE FUNKCIONALNOSTI",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                      left: 190,
                                                                      right:
                                                                          60),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(Icons
                                                                      .weekend),
                                                                 ValueListenableBuilder(
                                                                    valueListenable: namjestenNotifier,
                                                                    builder:(context, value, _){ return Checkbox(
                                                                    // Checkbox for the first Card
                                                                    // Add your checkbox logic here
                                                                    value:
                                                                        namjestenNotifier.value,
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                              namjestenNotifier.value = value ?? true;
                                                                              _initialValue['namjesten'] =
                                                                            namjestenNotifier.value;
                                                                      /*setState(
                                                                          () {
                                                                        namjestenChecked =
                                                                            value ??
                                                                                true;

                                                                        _initialValue['namjesten'] =
                                                                            namjestenChecked;
                                                                      });*/
                                                                    },
                                                                  );}),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          60),
                                                              child: Row(
                                                                  children: [
                                                                    const Icon(Icons
                                                                        .label),
                                                                   ValueListenableBuilder(
                                                                    valueListenable: novogradnjaNotifier,
                                                                    builder:(context, value, _){ return Checkbox(
                                                                     
                                                                      value:
                                                                          novogradnjaNotifier.value,
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                                novogradnjaNotifier.value = value ?? true;
                                                                                _initialValue['novogradnja'] =
                                                                              novogradnjaNotifier.value;
                                                                       
                                                                      },
                                                                    );}),
                                                                  ]),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(Icons
                                                                      .car_rental), 
                                                               
                                                                  ValueListenableBuilder(
                                                                    valueListenable: parkingMjestoNotifier,
                                                                    builder:(context, value, _){ return Checkbox(
                                                                      value: parkingMjestoNotifier
                                                                          .value,
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        parkingMjestoNotifier
                                                                                .value =
                                                                            value ??
                                                                                false;
                                                                        _initialValue[
                                                                            'parkingMjesto'] = parkingMjestoNotifier
                                                                                .value
                                                                            ? '1'
                                                                            : '2';
                                                                      },
                                                                    );},
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                        const SizedBox(height: 40),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ]),
                        ))))));
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

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      }
    });
  }

  Widget buildImageColumn(int nekretninaId) {
    return FutureBuilder<SearchResult<Slika>>(
      future: SlikeProvider().get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SearchResult<Slika>? slike = snapshot.data;

          if (slike != null && slike.result.isNotEmpty) {
            return Column(
              children: slike.result
                  .where((slika) => slika.nekretninaId == nekretninaId)
                  .map((slika) {
                print(slika.bajtoviSlike);
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: imageFromBase64String(slika.bajtoviSlike ?? ""),
                );
              }).toList(),
            );
          } else {
            return const Text('');
          }
        } else if (snapshot.hasError) {
          return const Text('Greška prilikom dobavljanja slika');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
