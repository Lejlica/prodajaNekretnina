import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipNekr_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  late TipNekretninaProvider _tipNekretnineProvider;
  late TipAkcijeProvider _tipAkcijeProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late DrzaveProvider _drzaveProvider;
  String? base64Image;
  List<String> base64Images = []; 

  List<dynamic> data = [];
  List<dynamic> korisniciData = [];
  List<dynamic> nekretnineData = [];
  List<dynamic> lokacijeData = [];
  List<dynamic> gradoviData = [];
  List<dynamic> drzaveData = [];
  List<dynamic> slikeData = [];
  List<dynamic> tipoviAkcijeData = [];
   List<dynamic> tipoviNekretnineData = [];
   List<dynamic> nekrTipAkcijeData = [];
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
  int? selectedPropertyTypeId;
  int? selectedDrzavaId;
  int? selectedGradId;
  int? selectedtipAkcijeId;
  late Object selectedUlica = '';
  late Object selectedPostanski = '';
  @override
  void initState() {
    super.initState();
    if (drzaveData.isNotEmpty && selectedDrzavaId == -1) {
  selectedDrzavaId = drzaveData.first.id;
}
selectedtipAkcijeId = -1;
      selectedPropertyTypeId = -1;
      selectedGradId = -1;
      selectedUlica = '';
      selectedPostanski = '';
    _tipNekretnineProvider = context.read<TipNekretninaProvider>();
    
_tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisnikNekretninaWishProvider =
        context.read<KorisnikNekretninaWishProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _drzaveProvider = context.read<DrzaveProvider>();
    _nekretninaTipAkcijeProvider=context.read<NekretninaTipAkcijeProvider>();
    //_slikeProvider = context.read<SlikeProvider>();
 
    initForm();
    
  }

  Future initForm() async {
    try {
      
      var tmpData = await _korisnikNekretninaWishProvider?.get(null);
      print('tmpData: ${tmpData}');

      var tmpKorisniciData = await _korisniciProvider?.get(null);
      print('tmpKorisniciData: ${tmpKorisniciData}');

      var tmpNekretnineData = await _nekretnineProvider?.get(null);
      print('tmpNekretnineData: ${tmpNekretnineData}');

      var tmpLokacijeData = await _lokacijeProvider?.get(null);
      print('tmpLokacijeData: ${tmpLokacijeData}');

      var tmpGradoviData = await _gradoviProvider?.get(null);
      print('tmpGradoviData: ${tmpGradoviData}');
var tmpTipoviAkcijeData = await _tipAkcijeProvider?.get(null);
      print('tmpTipoviAkcijeData: ${tmpTipoviAkcijeData}');
      
      var tmptipoviNekretnineData = await _tipNekretnineProvider?.get(null);
      print('tmptipoviNekretnineData: ${tmptipoviNekretnineData}');
      var tmpdrzaveData = await _drzaveProvider.get();
      print('drzaveData: ${tmpdrzaveData}');
var tmpnekrTipAkcijeData = await _nekretninaTipAkcijeProvider?.get(null);
      print('drzaveData: ${tmpnekrTipAkcijeData}');

      setState(() {
        data = tmpData!;
        korisniciData = tmpKorisniciData!;
        nekretnineData = tmpNekretnineData!;
        lokacijeData = tmpLokacijeData!;
        gradoviData = tmpGradoviData!;
       tipoviNekretnineData=tmptipoviNekretnineData!;
       tipoviAkcijeData=tmpTipoviAkcijeData!;
       nekrTipAkcijeData=tmpnekrTipAkcijeData!;
        drzaveData = tmpdrzaveData ?? [];
  if (drzaveData.isEmpty) {
    print("Nema dostupnih država iz baze!");
  }
       
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
    
    };

   

    await _nekretnineProvider.insert(propertyData);

   
    _propertyTitleController.clear();
    _propertyDescriptionController.clear();
    _propertyPriceController.clear();
   
  }

  int? pronadiLokacijaId() {
    for (var lokacija in lokacijeData) {
      print(
          "Drzava ${lokacija.drzavaId}, selectedDrzavaId ${selectedDrzavaId}, Grad ${lokacija.gradId}, selectedGradId ${selectedGradId},Ulica ${lokacija.ulica}, selectedUlica ${selectedUlica}, PB ${lokacija.postanskiBroj}, selectedPostanski ${selectedPostanski}");

    
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

    return null; 
  }
final _formKey = GlobalKey<FormState>();

  bool novogradnjaChecked = false;
  bool namjestenChecked = false;
  bool parkingChecked = false;
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: "Dodaj nekretninu",
        child: CustomScrollView(slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16.0), 
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Wrap(
                                alignment:
                                    WrapAlignment.center, 
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
                      Form(
  key: _formKey,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    
      TextFormField(
        controller: _propertyTitleController,
        decoration: InputDecoration(
          hintText: 'Naziv nekretnine',
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Unesite naziv nekretnine';
          }
          return null;
        },
      ),
      SizedBox(height: 12),

  
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _propertyPriceController,
              decoration: InputDecoration(
                hintText: 'Cijena',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite cijenu';
                }
                final number = double.tryParse(value);
                if (number == null || number <= 0) {
                  return 'Unesite validan broj veći od 0';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: _propertykvadraturaController,
              decoration: InputDecoration(
                hintText: 'Kvadratura',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite kvadraturu';
                }
                final number = int.tryParse(value);
                if (number == null || number <= 0) {
                  return 'Unesite validan broj veći od 0';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      SizedBox(height: 12),

     
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _propertybrojSobaController,
              decoration: InputDecoration(
                hintText: 'Broj soba',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite broj soba';
                }
                final number = int.tryParse(value);
                if (number == null || number <= 0) {
                  return 'Unesite validan broj veći od 0';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: _propertybrojSpavacihSobaController,
              decoration: InputDecoration(
                hintText: 'Broj spavaćih soba',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite broj spavaćih soba';
                }
                final number = int.tryParse(value);
                if (number == null || number < 0) {
                  return 'Unesite validan broj (0 ili više)';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      SizedBox(height: 12),

     
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _propertyspratController,
              decoration: InputDecoration(
                hintText: 'Sprat',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite sprat';
                }
                final number = int.tryParse(value);
                if (number == null || number < 0) {
                  return 'Unesite validan broj (0 ili više)';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: _propertybrojUgovoraController,
              decoration: InputDecoration(
                hintText: 'Broj ugovora',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Unesite broj ugovora';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      SizedBox(height: 12),

    
      TextFormField(
        controller: _propertyDescriptionController,
        decoration: InputDecoration(
          hintText: 'Detaljan opis',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        maxLines: 4,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Unesite detaljan opis';
          }
          return null;
        },
      ),
    ],
  ),
)
,

                      SizedBox(height: 10),
                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Flexible(
      child: Row(
        children: [
          Checkbox(
            value: novogradnjaChecked,
            onChanged: (bool? newValue) {
              setState(() {
                novogradnjaChecked = newValue ?? false;
              });
            },
          ),
          Icon(Icons.apartment, size: 20),
          SizedBox(width: 4),
         
        ],
      ),
    ),
    Flexible(
      child: Row(
        children: [
          Checkbox(
            value: namjestenChecked,
            onChanged: (bool? newValue) {
              setState(() {
                namjestenChecked = newValue ?? false;
              });
            },
          ),
          Icon(Icons.chair, size: 20),
          SizedBox(width: 4),
         
        ],
      ),
    ),
    Flexible(
      child: Row(
        children: [
          Checkbox(
            value: parkingChecked,
            onChanged: (bool? newValue) {
              setState(() {
                parkingChecked = newValue ?? false;
              });
            },
          ),
          Icon(Icons.local_parking, size: 20),
          SizedBox(width: 4),
          
        ],
      ),
    ),
  ],
)


                    ],
                  ),
                ),
                SizedBox(height: 10),
                
Form(
  key: _formKey,
  
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        

      
        TextFormField(
          controller: _propertyTitleController,
          decoration: InputDecoration(
            labelText: 'Naziv nekretnine',
            prefixIcon: Icon(Icons.home_outlined),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Unesite naziv nekretnine';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

      
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _propertyPriceController,
                decoration: InputDecoration(
                  labelText: 'Cijena',
                  prefixIcon: Icon(Icons.attach_money),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Unesite cijenu';
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) return 'Unesite validan broj veći od 0';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _propertykvadraturaController,
                decoration: InputDecoration(
                  labelText: 'Kvadratura',
                  prefixIcon: Icon(Icons.square_foot),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Unesite kvadraturu';
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) return 'Unesite validan broj veći od 0';
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

       
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _propertybrojSobaController,
                decoration: InputDecoration(
                  labelText: 'Broj soba',
                  prefixIcon: Icon(Icons.meeting_room_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Unesite broj soba';
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) return 'Unesite validan broj veći od 0';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _propertybrojSpavacihSobaController,
                decoration: InputDecoration(
                  labelText: 'Broj spavaćih soba',
                  prefixIcon: Icon(Icons.bed_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Unesite broj spavaćih soba';
                  final number = int.tryParse(value);
                  if (number == null || number < 0) return 'Unesite validan broj (0 ili više)';
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Sprat i broj ugovora
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _propertyspratController,
                decoration: InputDecoration(
                  labelText: 'Sprat',
                  prefixIcon: Icon(Icons.stairs_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Unesite sprat';
                  final number = int.tryParse(value);
                  if (number == null || number < 0) return 'Unesite validan broj (0 ili više)';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _propertybrojUgovoraController,
                decoration: InputDecoration(
                  labelText: 'Broj ugovora',
                  prefixIcon: Icon(Icons.description_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Unesite broj ugovora';
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Opis
        TextFormField(
          controller: _propertyDescriptionController,
          decoration: InputDecoration(
            labelText: 'Detaljan opis',
            alignLabelWithHint: true,
            prefixIcon: Icon(Icons.notes_outlined),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          maxLines: 4,
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Unesite detaljan opis';
            return null;
          },
        ),
const SizedBox(height: 16),
        // Ulica i Poštanski broj
Row(
  children: [
    Expanded(
      
      child: TextFormField(
        controller: _nazivUliceController,
        decoration: InputDecoration(
          labelText: 'Ulica',
          prefixIcon: Icon(Icons.location_on_outlined),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Unesite naziv ulice';
          return null;
        },
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      
      child: TextFormField(
        controller: _postanskiController,
        decoration: InputDecoration(
          labelText: 'Poštanski broj',
          prefixIcon: Icon(Icons.local_post_office_outlined),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Unesite poštanski broj';
          if (!RegExp(r'^\d{4,6}$').hasMatch(value)) return 'Potrebno je od 4 do 6 cifara';
          return null;
        },
      ),
    ),
  ],
),

     const SizedBox(height: 16), 
tipoviAkcijeData.isEmpty
  ? const Center(child: CircularProgressIndicator())
  : DropdownButtonFormField<int>(
      value: tipoviAkcijeData.any((t) => t.tipAkcijeId == selectedtipAkcijeId)
          ? selectedtipAkcijeId
          : -1,
      decoration: InputDecoration(
        labelText: 'Tip akcije',
        prefixIcon: Icon(Icons.local_offer_outlined),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: [
        const DropdownMenuItem(value: -1, child: Text("Odaberite tip akcije")),
        ...tipoviAkcijeData.map<DropdownMenuItem<int>>((t) {
          return DropdownMenuItem(value: t.tipAkcijeId, child: Text(t.naziv));
        }).toList(),
      ],
      validator: (value) => value == -1 ? 'Odaberite tip akcije' : null,
      onChanged: (value) {
        setState(() {
          selectedtipAkcijeId = value!;
        });
      },
    ),

      const SizedBox(height: 16),
      // Tip nekretnine
     tipoviNekretnineData.isEmpty
  ? const Center(child: CircularProgressIndicator())
  : DropdownButtonFormField<int>(
      value: tipoviNekretnineData.any((t) => t.tipNekretnineId == selectedPropertyTypeId)
          ? selectedPropertyTypeId
          : -1,
      decoration: InputDecoration(
        labelText: 'Tip nekretnine',
        prefixIcon: Icon(Icons.apartment_outlined),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: [
        const DropdownMenuItem(value: -1, child: Text("Odaberite tip nekretnine")),
        ...tipoviNekretnineData.map<DropdownMenuItem<int>>((t) {
          return DropdownMenuItem(value: t.tipNekretnineId, child: Text(t.nazivTipa));
        }).toList(),
      ],
      validator: (value) => value == -1 ? 'Odaberite tip nekretnine' : null,
      onChanged: (value) {
        setState(() {
          selectedPropertyTypeId = value!;
        });
      },
    ),

      const SizedBox(height: 16),

      // Država
     drzaveData.isEmpty
  ? const Center(child: CircularProgressIndicator())
  : DropdownButtonFormField<int>(
      value: drzaveData.any((d) => d.drzavaId == selectedDrzavaId)
          ? selectedDrzavaId
          : -1,
      decoration: InputDecoration(
        labelText: 'Država',
        prefixIcon: Icon(Icons.public_outlined),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: [
        const DropdownMenuItem(value: -1, child: Text("Odaberite državu")),
        ...drzaveData.map<DropdownMenuItem<int>>((d) {
          return DropdownMenuItem(value: d.drzavaId, child: Text(d.naziv));
        }).toList(),
      ],
      validator: (value) => value == -1 ? 'Odaberite državu' : null,
      onChanged: (value) {
        setState(() {
          selectedDrzavaId = value!;
        });
      },
    ),

     const SizedBox(height: 16),

      // Grad
      gradoviData.isEmpty
  ? const Center(child: CircularProgressIndicator())
  : DropdownButtonFormField<int>(
      value: gradoviData.any((g) => g.gradId == selectedGradId && g.drzavaId == selectedDrzavaId)
    ? selectedGradId
    : -1,

      decoration: InputDecoration(
        labelText: 'Grad',
        prefixIcon: Icon(Icons.location_city_outlined),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: [
        const DropdownMenuItem(value: -1, child: Text("Odaberite grad (prvo odaberite državu)")),
        ...gradoviData
            .where((g) => g.drzavaId == selectedDrzavaId)
            .map<DropdownMenuItem<int>>(
              (g) => DropdownMenuItem(
                value: g.gradId,
                child: Text(g.naziv ?? ''),
              ),
            )
            .toList(),
      ],
      validator: (value) => value == -1 ? 'Odaberite grad' : null,
      onChanged: (value) {
        setState(() {
          selectedGradId = value!;
        });
      },
    ),

      SizedBox(height: 10),

      
    ],
  ),
)
,), SizedBox(height: 10),

ElevatedButton.icon(
  onPressed: () async {
    final selectedImages = await pickAndEncodeImages();
    if (selectedImages.isNotEmpty) {
      setState(() {
        base64Images = selectedImages;
      });
    }
  },
  icon: const Icon(Icons.photo_library),
  label: const Text("Odaberi slike"),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
),

 if (base64Image != null && base64Image!.isNotEmpty)
      Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.memory(
          base64Decode(base64Image!),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),

    const SizedBox(height: 24),
SizedBox(height: 10),
                ElevatedButton.icon(
  onPressed: () async {
     if (_formKey.currentState!.validate()) {
      print("Forma validna");

  
    if (_nazivUliceController.text.trim().isEmpty || _postanskiController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Molimo unesite i ulicu i poštanski broj!')),
      );
      return;
    }

if (base64Images == null || base64Images!.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Dodavanje slike je obavezno!'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

   
      
      bool lokacijaPostoji = lokacijeData?.any((lok) =>
        lok.ulica == _nazivUliceController.text.trim() &&
        lok.postanskiBroj == _postanskiController.text.trim() &&
        lok.gradId == selectedGradId &&
        lok.drzavaId == selectedDrzavaId
      ) ?? false;

    
      if (!lokacijaPostoji) {
        Map<String, dynamic> novaLokacija = {
          'ulica': _nazivUliceController.text.trim(),
          'postanskiBroj': _postanskiController.text.trim(),
          'gradId': selectedGradId,
          'drzavaId': selectedDrzavaId,
        };

        await _lokacijeProvider.insert(novaLokacija);
      }

     
      var tmpLokacijeData = await _lokacijeProvider.get(null);
      setState(() {
        lokacijeData = tmpLokacijeData!;
        print('Pozvan setState - lokacijeData je ažurirana. Broj lokacija: ${lokacijeData.length}');
      });

 int? lokacijaId;

for (var lokacija in tmpLokacijeData) {
  print(
      "Drzava ${lokacija.drzavaId}, selectedDrzavaId ${selectedDrzavaId}, Grad ${lokacija.gradId}, selectedGradId ${selectedGradId}, Ulica ${lokacija.ulica}, selectedUlica ${selectedUlica}, PB ${lokacija.postanskiBroj}, selectedPostanski ${selectedPostanski}");

  if (lokacija.drzavaId == selectedDrzavaId &&
      lokacija.gradId == selectedGradId &&
      lokacija.ulica == _nazivUliceController.text.trim()  &&
      lokacija.postanskiBroj == _postanskiController.text.trim()) {
    print("✅ Lokacija pronađena!");
    print("LokacijaId: ${lokacija.lokacijaId}");

    lokacijaId = lokacija.lokacijaId;
    break; 
  }
}

if (lokacijaId == null) {
  print("❌ Lokacija nije pronađena!");
} else {
  print("ℹ️ Pohranjen lokacijaId: $lokacijaId");
}

      
      DateTime currentDate = DateTime.now();
      String iso8601Date = currentDate.toIso8601String();

      Map<String, dynamic> propertyData = {
        'isOdobrena': false,
        'korisnikId': korisnikId(),
        'tipNekretnineId': selectedPropertyTypeId,
        'kategorijaId': 1,
        'lokacijaId': lokacijaId, 
        'datumDodavanja': iso8601Date,
        'datumIzmjene': iso8601Date,
        'cijena': double.tryParse(_propertyPriceController.text) ?? 0.0,
        'stateMachine': 'draft',
        'kvadratura': int.tryParse(_propertykvadraturaController.text) ?? 0,
        'naziv': _propertyTitleController.text,
        'brojSoba': int.tryParse(_propertybrojSobaController.text) ?? 0,
        'brojSpavacihSoba': int.tryParse(_propertybrojSpavacihSobaController.text) ?? 0,
        'namjesten': namjestenChecked,
        'novogradnja': novogradnjaChecked,
        'sprat': int.tryParse(_propertyspratController.text) ?? 0,
        'parkingMjesto': parkingChecked,
        'brojUgovora': _propertybrojUgovoraController.text.trim(),
        'detaljanOpis': _propertyDescriptionController.text,
      };
print('Podaci koji se šalju za nekretninu:');
propertyData.forEach((key, value) {
  print('$key: $value');
});

      var result = await _nekretnineProvider.insert(propertyData);

      if (result != null && result.nekretninaId != null) {
        int novaNekretninaId = result.nekretninaId;

        print("Nova nekretnina ID: $novaNekretninaId");

        Map<String, dynamic> nekrTipAkcijeData = {
          'nekretninaId': novaNekretninaId,
          'tipAkcijeId': selectedtipAkcijeId,
        };

        await _nekretninaTipAkcijeProvider.insert(nekrTipAkcijeData);

       
      for (var base64Image in base64Images) {
      await uploadSingleImage(base64Image, novaNekretninaId);
    }

      if (base64Images.isNotEmpty) {
         

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(child: Text('Uspješno ste dodali nekretninu i sliku! PRIJE NEGO VASA NEKRETNINA BUDE OBJAVLJENA, ADMINISTRATOR MORA DA JE ODOBRI!')),
                ],
              ),
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          print('Slika nije odabrana.');
        }


 
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
      }
    } else {
      print("Forma nije validna");
    }
  },
   icon: Icon(Icons.add, color: Colors.white),
  label: Text('Dodaj nekretninu'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, 
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
),
 SizedBox(height: 40),
              ],
            ),
          ),)
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
Future<void> uploadSingleImage(String base64Image, int nekretninaId) async {
  try {
    String apiUrl = 'http://10.0.2.2:7189/Slike';
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
      print('Slika uspješno upload-ovana za nekretninu ID: $nekretninaId');
    } else {
      print('Upload slike neuspješan. Status kod: ${response.statusCode}');
    }

    client.close();
  } catch (e) {
    print('Greška prilikom upload slike: $e');
  }
}
  Future<void> uploadImageToApi(Future<int?> nekretninaIdFuture) async {
    try {
      String base64Image = await pickAndEncodeImage(); 
      int? nekretninaId =
          await nekretninaIdFuture; 

      print('BASE64: $base64Image');

      String apiUrl = 'http://10.0.2.2:7189/Slike';
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

      
      client.close();
    } catch (e) {
      print('Error during image upload: $e');
    }
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
  Future<List<String>> pickAndEncodeImages() async {
  final picker = ImagePicker();
  final pickedFiles = await picker.pickMultiImage(); 

  if (pickedFiles.isNotEmpty) {
    List<String> base64Images = [];

    for (var file in pickedFiles) {
      Uint8List imageBytes = await file.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      base64Images.add(base64Image);
    }

    return base64Images;
  } else {
    print('No images selected.');
    return [];
  }
}


}
