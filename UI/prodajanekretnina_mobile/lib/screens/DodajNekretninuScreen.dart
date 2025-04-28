import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile/models/kupci.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/models/korisnici.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:prodajanekretnina_mobile/models/drzave.dart';
import 'package:prodajanekretnina_mobile/models/lokacije.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/providers/komentariAgentima_provider.dart';
import 'package:prodajanekretnina_mobile/screens/AgentDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/utils/util.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'dart:convert';

import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DodajNekretninuScreen extends StatefulWidget {
  final Korisnik? korisnik;

  const DodajNekretninuScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<DodajNekretninuScreen> createState() => _DodajNekretninuScreenState();
}

class _DodajNekretninuScreenState extends State<DodajNekretninuScreen> {
  late KorisnikNekretninaWishProvider _korisnikNekretninaWishProvider;
  late KorisniciProvider _korisniciProvider;
  late NekretnineProvider _nekretnineProvider;
  late LokacijeProvider _lokacijeProvider;
  late GradoviProvider _gradoviProvider;
  late TipoviNekretninaProvider _tipNekretnineProvider;
  late DrzaveProvider _drzaveProvider;
  //late SlikeProvider _slikeProvider;

  List<dynamic> data = [];
  List<dynamic> korisniciData = [];
  List<dynamic> nekretnineData = [];
  List<dynamic> lokacijeData = [];
  List<dynamic> gradoviData = [];
  List<dynamic> drzaveData = [];
  List<dynamic> slikeData = [];
  TextEditingController _propertyTitleController = TextEditingController();
  TextEditingController _propertyDescriptionController =
      TextEditingController();
  TextEditingController _propertyPriceController = TextEditingController();
  TextEditingController _propertykvadraturaController = TextEditingController();
  TextEditingController _propertybrojSobaController = TextEditingController();
  TextEditingController _propertybrojSpavacihSobaController =
      TextEditingController();
  TextEditingController _propertynamjestenController = TextEditingController();
  TextEditingController _propertynovogradnjaController =
      TextEditingController();
  TextEditingController _propertyspratController = TextEditingController();
  TextEditingController _propertyparkingMjestoController =
      TextEditingController();
  TextEditingController _propertybrojUgovoraController =
      TextEditingController();
  TextEditingController _nazivUliceController = TextEditingController();
  TextEditingController _postanskiController = TextEditingController();
  String username = Authorization.username ?? "";

  SearchResult<TipNekretnine>? tipNekretnineResult;
  int userRating = 0;
  late int selectedPropertyTypeId;
  late int selectedDrzavaId;
  late int selectedGradId;
  late Object selectedUlica = '';
  late Object selectedPostanski = '';
  @override
  void initState() {
    super.initState();
    _tipNekretnineProvider = context.read<TipoviNekretninaProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisnikNekretninaWishProvider =
        context.read<KorisnikNekretninaWishProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _drzaveProvider = context.read<DrzaveProvider>();
    //_slikeProvider = context.read<SlikeProvider>();

    initForm();
    selectedDrzavaId = -1;
    selectedPropertyTypeId = -1;
    selectedGradId = -1;
  }

  Future initForm() async {
    try {
      var tmpData = await _korisnikNekretninaWishProvider?.get(null);
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpNekretnineData = await _nekretnineProvider?.get(null);
      var tmpLokacijeData = await _lokacijeProvider?.get(null);
      var tmpGradoviData = await _gradoviProvider?.get(null);
      tipNekretnineResult = await _tipNekretnineProvider.get();
      var tmpdrzaveData = await _drzaveProvider.get();

      setState(() {
        data = tmpData!;
        korisniciData = tmpKorisniciData!;
        nekretnineData = tmpNekretnineData!;
        lokacijeData = tmpLokacijeData!;
        gradoviData = tmpGradoviData!;
        drzaveData = tmpdrzaveData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  int? korisnikId() {
    List<dynamic> filteredData = korisniciData!
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }

  String? lokacijaNekretnine(int nekretninaId) {
    List<dynamic> filteredData = nekretnineData!
        .where((nekretnina) => nekretnina.nekretninaId == nekretninaId)
        .toList();

    List<dynamic> filteredData1 = lokacijeData!
        .where((lokacija) => lokacija.lokacijaId == filteredData[0].lokacijaId)
        .toList();

    List<dynamic> filteredData2 = gradoviData!
        .where((grad) => grad.gradId == filteredData1[0].gradId)
        .toList();

    if (filteredData2.isNotEmpty) {
      return "${filteredData2[0].naziv}, ${filteredData1[0].ulica}, ${filteredData1[0].postanskiBroj}";
    } else {
      return null;
    }
  }

  String? nazivNekretnine(int nekretninaId) {
    List<dynamic> filteredData = nekretnineData!
        .where((nekretnina) => nekretnina.nekretninaId == nekretninaId)
        .toList();

    if (filteredData.isNotEmpty) {
      return "${filteredData[0].naziv}";
    } else {
      return null;
    }
  }

  int? getDohvatiLokaciju(int selectedGradId, int selectedDrzavaId) {
    List<dynamic> filteredData = lokacijeData!
        .where((lokacija) =>
            lokacija.gradId == selectedGradId &&
            lokacija.drzavaId == selectedDrzavaId)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].lokacijaId;
    } else {
      return null;
    }
  }

  void _submitProperty() async {
    // Prepare the property data to send in a request
    DateTime currentDate = DateTime.now();
    String iso8601Date = currentDate.toIso8601String();
    Map<String, dynamic> propertyData = {
      'isOdobrena': false,
      'korisnikId': korisnikId(),
      'tipNekretnineId': selectedPropertyTypeId,
      'kategorijaId': 1,
      'lokacijaId': 1,
      'datumDodavanja': iso8601Date,
      'datumIzmjene': iso8601Date,
      'cijena': double.tryParse(_propertyPriceController.text) ?? 0.0,
      'stateMachine': 'draft',
      'kvadratura': _propertykvadraturaController.text,
      'naziv': _propertyTitleController.text,
      'brojSoba': _propertybrojSobaController.text,
      'brojSpavacihSoba': _propertybrojSpavacihSobaController.text,
      'namjesten': _propertynamjestenController.text?.toLowerCase() == "da"
          ? true
          : false,

      'novogradnja': _propertynovogradnjaController.text?.toLowerCase() == "da"
          ? true
          : false,
      'sprat':
          _propertyspratController.text?.toLowerCase() == "da" ? true : false,
      'parkingMjesto':
          _propertyparkingMjestoController.text?.toLowerCase() == "da"
              ? true
              : false,
      'brojUgovora': _propertybrojUgovoraController.text,
      'detaljanOpis': _propertyDescriptionController.text,
      // Add more fields as needed
    };

    // Send the property data to _nekretnineProvider.insert(request)
    // You may need to handle the HTTP request here or in a separate provider.
    // Example:

    await _nekretnineProvider.insert(propertyData);

    // Clear the input fields after submission
    _propertyTitleController.clear();
    _propertyDescriptionController.clear();
    _propertyPriceController.clear();
    // Clear other input fields as needed
  }

  int? pronadiLokacijaId() {
    for (var lokacija in lokacijeData) {
      print(
          "Drzava ${lokacija.drzavaId}, selectedDrzavaId ${selectedDrzavaId}, Grad ${lokacija.gradId}, selectedGradId ${selectedGradId},Ulica ${lokacija.ulica}, selectedUlica ${selectedUlica}, PB ${lokacija.postanskiBroj}, selectedPostanski ${selectedPostanski}");

      // Pretpostavljam da imate listu lokacija pod nazivom lokacijeData
      if (lokacija.drzavaId == selectedDrzavaId &&
          lokacija.gradId == selectedGradId &&
          lokacija.ulica == selectedUlica &&
          lokacija.postanskiBroj == selectedPostanski) {
        print(
            "Drzava ${lokacija.drzavaId}, Grad ${lokacija.gradId}, Ulica ${lokacija.ulica}, PB ${lokacija.postanskiBroj}");
        print("LokacijaIdd ${lokacija.lokacijaId}");
        return lokacija.lokacijaId;
      }
    }

    return null; // Vraća null ako nema odgovarajućeg podudaranja
  }

  bool novogradnjaChecked = false;
  bool namjestenChecked = false;
  bool parkingChecked = false;
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: "Dodaj nekretninu",
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Wrap(
                                alignment:
                                    WrapAlignment.center, // Centrirajte naslov
                                children: [
                                  Text(
                                    'U formu ispod unesite podatke o Vašoj nekretnini',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _propertyTitleController,
                              decoration: InputDecoration(
                                hintText: 'Naziv nekretnine',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: _propertyPriceController,
                            decoration: InputDecoration(
                              hintText: 'Cijena',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _propertykvadraturaController,
                            decoration: InputDecoration(
                              hintText: 'Kvadratura',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: _propertybrojSobaController,
                            decoration: InputDecoration(
                              hintText: 'Broj soba',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _propertybrojSpavacihSobaController,
                            decoration: InputDecoration(
                              hintText: 'Broj spavaćih soba',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ]),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _propertyspratController,
                              decoration: InputDecoration(
                                hintText: 'Sprat',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _propertybrojUgovoraController,
                              decoration: InputDecoration(
                                hintText: 'Broj ugovora',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: _propertyDescriptionController,
                            decoration: InputDecoration(
                              hintText: 'Detaljan opis',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Checkbox(
                          value: novogradnjaChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              novogradnjaChecked = newValue ?? false;
                            });
                          },
                        ),
                        Text('Novogradnja'),
                        Checkbox(
                          value: namjestenChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              namjestenChecked = newValue ?? false;
                            });
                          },
                        ),
                        Text('Namješten'),
                        Checkbox(
                          value: parkingChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              parkingChecked = newValue ?? false;
                            });
                          },
                        ),
                        Text('Parking'),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton<int>(
                  hint: Text("Odaberite tip nekretnine"),
                  items: tipNekretnineResult?.result.map((tipNekretnine) {
                    return DropdownMenuItem<int>(
                      value: tipNekretnine.tipNekretnineId,
                      child: Text(tipNekretnine.nazivTipa ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPropertyTypeId = value ?? -1;
                    });
                  },
                ),
                DropdownButton<int>(
                  hint: Text("Odaberite drzavu"),
                  items: drzaveData?.map((drzava) {
                    return DropdownMenuItem<int>(
                      value: drzava.drzavaId,
                      child: Text(drzava.naziv ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDrzavaId = value ?? -1;
                    });
                  },
                ),
                DropdownButton<int>(
                  hint: Text("Odaberite grad"),
                  items: gradoviData
                      ?.where((grad) => grad.drzavaId == selectedDrzavaId)
                      .map((grad) {
                    return DropdownMenuItem<int>(
                      value: grad.gradId,
                      child: Text(grad.naziv ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print("Onchange");
                    setState(() {
                      selectedGradId = value ?? -1;
                    });
                  },
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      hint: Text("Odaberite ulicu"),
                      items: lokacijeData
                          ?.where((lokacija) =>
                              lokacija.gradId == selectedGradId &&
                              lokacija.drzavaId == selectedDrzavaId)
                          .map((lokacija) {
                        return DropdownMenuItem<String>(
                          value: lokacija.ulica,
                          child: Text(lokacija.ulica ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUlica = value ?? "nije odabrano";
                        });
                        print("selectedUlica ${selectedUlica}");
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _nazivUliceController,
                        decoration: InputDecoration(
                          hintText: 'Dodaj ulicu',
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      onPressed: () async {
                        Map<String, dynamic> propertyData = {
                          'postanskiBroj': _postanskiController.text,
                          'ulica': _nazivUliceController.text,
                          'gradId': selectedGradId,
                          'drzavaId': selectedDrzavaId,
                        };

                        var result =
                            await _lokacijeProvider.insert(propertyData);

                        var tmpLokacijeData =
                            await _lokacijeProvider?.get(null);
                        setState(() {
                          selectedUlica = _nazivUliceController.text;
                          selectedPostanski = _postanskiController.text;
                          lokacijeData = tmpLokacijeData!;
                        });
                      },
                    ),
                  ],
                ),
                DropdownButton<String>(
                  hint: Text("Odaberite poštanski broj"),
                  items: lokacijeData
                      ?.where((lokacija) =>
                          lokacija.gradId == selectedGradId &&
                          lokacija.drzavaId == selectedDrzavaId &&
                          lokacija.ulica == selectedUlica)
                      .map((lokacija) {
                    return DropdownMenuItem<String>(
                      value: lokacija.postanskiBroj,
                      child: Text(lokacija.postanskiBroj ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPostanski = value ?? "nije odabrano";
                    });
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _postanskiController,
                    decoration: InputDecoration(
                      hintText: 'Dodaj poštanski broj',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.red,
                  onPressed: () async {
// Pronađite lokaciju sa odabranom ulicom
                    var lokacijaSaOdabranomUlicom = lokacijeData?.firstWhere(
                      (lokacija) =>
                          lokacija.gradId == selectedGradId &&
                          lokacija.drzavaId == selectedDrzavaId &&
                          lokacija.ulica == selectedUlica,
                      orElse: () =>
                          null, // Vraća null ako se ne pronađe odgovarajuća lokacija
                    );

// Ako je pronađena odgovarajuća lokacija, dobijte poštanski broj
                    if (lokacijaSaOdabranomUlicom != null) {
                      Map<String, dynamic> propertyData = {
                        'postanskiBroj': _postanskiController.text,
                        'ulica': _nazivUliceController.text.isNotEmpty
                            ? _nazivUliceController.text
                            : selectedUlica ?? '',
                        'gradId': selectedGradId,
                        'drzavaId': selectedDrzavaId,
                      };
                      var result = await _lokacijeProvider.insert(propertyData);
                      // Ovdje možete koristiti postanskiBroj prema vašim potrebama (npr. dodati ga u bazu)
                    } else {
                      // Lokacija sa odabranom ulicom nije pronađena, tretirajte ovu situaciju kako želite
                    }

                    var tmpLokacijeData = await _lokacijeProvider?.get(null);
                    setState(() {
                      selectedUlica = _nazivUliceController.text.isNotEmpty
                          ? _nazivUliceController.text
                          : selectedUlica ?? '';
                      selectedPostanski = _postanskiController.text;
                      lokacijeData = tmpLokacijeData!;
                    });
                  },
                ),

                // Add more input fields for other property details
                SizedBox(height: 10),
                /* ElevatedButton(
                  onPressed: () async {
                    print("nekretId slike ${FindNekretninaId()}");
                    await uploadImageToApi(FindNekretninaId());
                  },
                  child: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                    primary: isPropertyAdded ? Colors.blue : Colors.grey,
                  ),
                ),*/
                ElevatedButton(
                  onPressed: isPropertyAdded
                      ? () async {
                          Future<int?> nekretninaId = FindNekretninaId();
                          String base64Image = await pickAndEncodeImage();

                          if (base64Image.isNotEmpty && nekretninaId != null) {
                            print("nekretId slike $nekretninaId");
                            await uploadImageToApi(nekretninaId);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Uspješno ste dodali sliku!',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Uredu'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            print(
                                'Nekretnina nije odabrana ili nije odabrana slika. Molimo provjerite i pokušajte ponovo.');
                          }
                        }
                      : null,
                  child: Text('Dodaj sliku'),
                  style: ElevatedButton.styleFrom(
                    primary: isPropertyAdded ? Colors.blue : Colors.grey,
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    var tmpLokacijeData = await _lokacijeProvider?.get(null);
                    setState(() {
                      lokacijeData = tmpLokacijeData!;
                    });
                    // Prepare the property data to send in a request
                    DateTime currentDate = DateTime.now();
                    String iso8601Date = currentDate.toIso8601String();
                    print("Kvadr ${_propertykvadraturaController.text}");

                    Map<String, dynamic> propertyData = {
                      'isOdobrena': false,
                      'korisnikId': korisnikId(),
                      'tipNekretnineId': selectedPropertyTypeId,
                      'kategorijaId': 1,
                      'lokacijaId': pronadiLokacijaId(),
                      'datumDodavanja': iso8601Date,
                      'datumIzmjene': iso8601Date,
                      'cijena':
                          double.tryParse(_propertyPriceController.text) ?? 0.0,
                      'stateMachine': 'draft',
                      'kvadratura':
                          int.tryParse(_propertykvadraturaController.text) ?? 0,
                      'naziv': _propertyTitleController.text,
                      'brojSoba': _propertybrojSobaController.text,
                      'brojSpavacihSoba':
                          _propertybrojSpavacihSobaController.text,
                      'namjesten': namjestenChecked,
                      'novogradnja': novogradnjaChecked,
                      'sprat': _propertyspratController.text,
                      'parkingMjesto': parkingChecked,
                      'brojUgovora': _propertybrojUgovoraController.text,
                      'detaljanOpis': _propertyDescriptionController.text,
                    };

                    var result = await _nekretnineProvider.insert(propertyData);

                    //_propertyTitleController.clear();
                    _propertyDescriptionController.clear();
                    _propertyPriceController.clear();
                    _propertykvadraturaController.clear();
                    _propertybrojSobaController.clear();
                    _propertybrojSpavacihSobaController.clear();
                    _propertynamjestenController.clear();
                    _propertynovogradnjaController.clear();
                    _propertyspratController.clear();
                    _propertyparkingMjestoController.clear();
                    _propertybrojUgovoraController.clear();
                    _nazivUliceController.clear();
                    _postanskiController.clear();
                    selectedPropertyTypeId = -1;
                    selectedDrzavaId = -1;
                    selectedGradId = -1;
                    selectedUlica = '';
                    selectedPostanski = '';
                    namjestenChecked = false;
                    novogradnjaChecked = false;
                    parkingChecked = false;
                    setState(() {
                      isPropertyAdded = true;
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Uspješno ste dodali nekretninu!',
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Uredu'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Dodaj nekretninu'),
                ),
              ],
            ),
          )
        ]));
  }

  bool isPropertyAdded = false;
  Future<int?> FindNekretninaId() async {
    print("Prop title ${_propertyTitleController.text}");
    var tmpKorisnikNekretninaWish = await _nekretnineProvider?.get(null);
    setState(() {
      nekretnineData = tmpKorisnikNekretninaWish!;
    });
    List<dynamic> filteredData = nekretnineData!
        .where((korisnik) => korisnik.naziv == _propertyTitleController.text)
        .toList();

    if (filteredData.isNotEmpty) {
      print("NekrtId ${filteredData[0].nekretninaId}");
      return filteredData[0].nekretninaId;
    } else {
      return null;
    }
  }

  Future<void> uploadImageToApi(Future<int?> nekretninaIdFuture) async {
    try {
      String base64Image = await pickAndEncodeImage(); // Wait for the result
      int? nekretninaId =
          await nekretninaIdFuture; // Await the result of the Future

      print('BASE64: $base64Image');

      String apiUrl = 'https://10.0.2.2:7125/Slike';
      String username = Authorization.username ?? "";
      String password = Authorization.password ?? "";

      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.parse(apiUrl));

      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Authorization',
          'Basic ' + base64Encode(utf8.encode('$username:$password')));

      Map<String, dynamic> requestBody = {
        'imageBase64': base64Image,
        'nekretninaId': nekretninaId,
      };

      request.write(jsonEncode(requestBody));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Image upload failed. Status code: ${response.statusCode}');
      }

      // Close the client
      client.close();
    } catch (e) {
      print('Error during image upload: $e');
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
