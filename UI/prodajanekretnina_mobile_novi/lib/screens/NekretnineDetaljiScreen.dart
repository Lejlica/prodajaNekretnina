import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/lokacije.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipAkcije.dart';
import 'package:prodajanekretnina_mobile_novi/models/obilazak.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/reccomendResult.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/reccomend_results_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_mobile_novi/screens/AgentDetaljiScreen.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NekretnineDetaljiScreen extends StatefulWidget {
  Nekretnina? nekretnina;
  static const String routeName = "/Obilazak";
  NekretnineDetaljiScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<NekretnineDetaljiScreen> createState() =>
      _NekretnineDetaljiScreenState();
}

class _NekretnineDetaljiScreenState extends State<NekretnineDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  //late final Obilazak? obilazak;
  Map<String, dynamic> _initialValue = {};
  int tipNekretnineId = 0;
  int nekretninaId = 0;
  int lokacijaId = 0;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;
  late TipoviNekretninaProvider _tipNekretnineProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late KorisnikNekretninaWishProvider _korisnikNekretninaWishProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  late KorisniciProvider _korisniciProvider;
  late ObilazakProvider _obilazakProvider;
  late TipAkcijeProvider _tipAkcijeProvider;
  late ReccomendResultProvider _reccomendResultProvider;
  bool isLoading = true;
  List<dynamic> data = [];
  List<dynamic> korisnicidata = [];
  List<dynamic> tipAkcijedata = [];
  List<dynamic> nekretninaTipAkcijedata = [];
  List<dynamic> obilasciData = [];
  List<dynamic> korisnikNekretninaWishData = [];
  List<dynamic> reccomendData = [];
  List<dynamic> nekrData = [];
  SearchResult<Slika>? slikeResult;
  SearchResult<TipNekretnine>? tipNekretnineResult;
  List<int> recommendedNekretninee = [];
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
      'brojSoba': widget.nekretnina?.brojSoba?.toString(),
      'brojSpavacihSoba': widget.nekretnina?.brojSpavacihSoba?.toString(),
      'sprat': widget.nekretnina?.sprat?.toString(),
      'brojUgovora': widget.nekretnina?.brojUgovora?.toString(),
      'novogradnja': widget.nekretnina?.novogradnja?.toString(),
      'namjesten': widget.nekretnina?.namjesten?.toString(),
      'parkingMjesto': widget.nekretnina?.parkingMjesto?.toString(),
      'kvadratura': widget.nekretnina?.kvadratura?.toString(),
      'detaljanOpis': widget.nekretnina?.detaljanOpis?.toString(),
    };
    tipNekretnineId = int.parse(_initialValue['tipNekretnineId']);
    lokacijaId = int.parse(_initialValue['lokacijaId']);
    nekretninaId = int.parse(_initialValue['nekretninaId']);

    _nekretnineProvider = context.read<NekretnineProvider>();

    // _lokacijeProvider = LokacijeProvider();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();

    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    _korisnikNekretninaWishProvider =
        context.read<KorisnikNekretninaWishProvider>();
    _tipNekretnineProvider = TipoviNekretninaProvider();
    _reccomendResultProvider = context.read<ReccomendResultProvider>();
    //_slikeProvider = SlikeProvider();
    //_tipAkcijeProvider = TipAkcijeProvider();
    //_nekretninaTipAkcijeProvider = NekretninaTipAkcijeProvider();
    initForm();

    print("tipNekretnineProvider PROVIDER ${_tipNekretnineProvider}");
    // ispis();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      tipNekretnineResult = await _tipNekretnineProvider.get();
      var tmpNekrData = await _nekretnineProvider?.get(null);
      var tmpData = await _nekretninaAgentiProvider?.get(null);
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpTipAkcije = await _tipAkcijeProvider?.get(null);
      var tmpNekretTipAkcije = await _nekretninaTipAkcijeProvider?.get(null);
      var tmpObilazakData = await _obilazakProvider?.get(null);
      var tmpKorisnikNekretninaWish =
          await _korisnikNekretninaWishProvider?.get(null);
      var tmpReccomendResult = await _reccomendResultProvider?.get(null);
      TipNekretnine? grad = tipNekretnineResult?.result.firstWhere(
        (element) => element.tipNekretnineId == 1,
        // Default value
      );

      setState(() {
        isLoading = false;
        data = tmpData!;
        nekrData = tmpNekrData!;
        korisnicidata = tmpKorisniciData!;
        tipAkcijedata = tmpTipAkcije!;
        nekretninaTipAkcijedata = tmpNekretTipAkcije!;
        obilasciData = tmpObilazakData!;
        korisnikNekretninaWishData = tmpKorisnikNekretninaWish!;
        reccomendData = tmpReccomendResult!;
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
      String apiUrl = 'https://localhost:7125/Slike';
      String username = Authorization.username ?? "";
      String password = Authorization.password ?? "";

      Map<String, dynamic> requestBody = {
        'imageBase64': base64Image,
        'nekretninaId': nekretninaId,
      };

      String jsonBody = jsonEncode(requestBody);

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ' + base64Encode(utf8.encode('$username:$password')),
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

  final nekretninaAgent = "";
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      // ignore: sort_child_properties_last
      child: Column(
        children: [
          _formBuild()
        ],
      ),
      title: this.widget.nekretnina?.naziv.toString() ?? "",
    );
  }

  String username = Authorization.username ?? "";

  int? korisnikId() {
    Korisnik? matchingKorisnik = korisnicidata?.firstWhere(
      (korisnik) => korisnik.korisnickoIme == username,
      orElse: () => null,
    );
    print("KORISNIK ID ${matchingKorisnik?.korisnikId}");
    if (matchingKorisnik != null) {
      return matchingKorisnik?.korisnikId;
    } else {
      return 0;
    }
  }

  String? nekretninaTipAkcijeId() {
    NekretninaTipAkcije? matchingKorisnik = nekretninaTipAkcijedata?.firstWhere(
      (nekretnina) =>
          nekretnina.nekretninaId == widget.nekretnina?.nekretninaId,
      orElse: () => null,
    );

    TipAkcije? tipAkcijeNaziv = tipAkcijedata?.firstWhere(
      (nekretnina) => nekretnina.tipAkcijeId == matchingKorisnik?.tipAkcijeId,
      orElse: () => null,
    );
    //print("TIP AKCIJE NAZIV ${tipAkcijeNaziv?.naziv}");
    return tipAkcijeNaziv?.naziv;
  }

  List<int> reccomendForUser() {
    for (var reccomendation in (reccomendData?.take(3) ?? [])) {
      if (reccomendation.korisnikId == korisnikId()) {
        recommendedNekretninee.add(reccomendation.prvaNekretninaId);
      }
    }

    print("Prve tri preporučene nekretnine: $recommendedNekretninee");
    return recommendedNekretninee;
  }

  FormBuilder _zakazivanje() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 200,
          decoration: BoxDecoration(),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Text(
                    "Zakaži obilazak",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Odaberite datum obilaska',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: datumPopravkeController,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  DateFormat inputFormat =
                      DateFormat('dd.MM.yyyy. HH:mm');
                  DateTime parsedDate =
                      inputFormat.parse(datumPopravkeController.text);

                  Map<String, dynamic> request = {
                    'korisnikId': korisnikId(),
                    'nekretninaId': widget.nekretnina?.nekretninaId,
                    'isOdobren': false,
                    'vrijemeObilaska':
                        selectedDate.value?.toIso8601String() ?? '',
                    'datumObilaska':
                        selectedDate.value?.toIso8601String() ?? '',
                  };

                  print('datum ${parsedDate}');
                  var result = _obilazakProvider.insert(
                    request,
                  );
                },
                child: Text('Zakaži'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TimeOfDay? selectedTime;
  ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);
  TextEditingController datumPopravkeController = TextEditingController();
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      selectedDate.value = picked;
      datumPopravkeController.text =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSSS').format(selectedDate.value!);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  bool _checkDateAvailability(DateTime selectedDate, int? nekretninaId) {
    for (var obilazak in obilasciData) {
      DateTime obilazakTime = obilazak.vrijemeObilaska!;
      DateTime satVremenaNakonObilaska = obilazakTime.add(Duration(hours: 1));
      print("sat vre ${satVremenaNakonObilaska}, vrijeme obil ${obilazakTime}");
      if (obilazak.nekretninaId == nekretninaId) {
        if (selectedDate.isBefore(satVremenaNakonObilaska)) {
          return false;
        }
      }
      print("Baza ${obilazak!.vrijemeObilaska},${selectedDate}");
      print("Baza ${obilazak}");
    }

    return true;
  }

  bool _checkIfNekretninaIsInWishList(int? nekretninaId, int? korisnikId) {
    for (var korisnikNekretninaWish in korisnikNekretninaWishData) {
      if (korisnikNekretninaWish.nekretninaId == nekretninaId &&
          korisnikNekretninaWish.korisnikId == korisnikId) {
        print(
            "Korisnik poslan ${korisnikId}, korisnik u bazi ${korisnikNekretninaWish.korisnikId}, Nekretnina poslana ${nekretninaId}, nekr u bazi ${korisnikNekretninaWish.nekretninaId}");
        return true;
      }
    }

    return false;
  }

  FormBuilder _formBuild() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 600,
          decoration: BoxDecoration(),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Text(
                    "Podaci o nekretnini",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<SearchResult<Slika>>(
                          future: SlikeProvider().get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              SearchResult<Slika>? slike = snapshot.data;

                              if (slike != null &&
                                  slike.result.isNotEmpty &&
                                  widget.nekretnina != null) {
                                // Create a list of image URLs from the data
                                List<String> imageUrls = slike.result
                                    .where((slika) =>
                                        slika.nekretninaId ==
                                        widget.nekretnina!.nekretninaId)
                                    .map((slika) => slika.bajtoviSlike ?? "")
                                    .toList();

                                // Check if there are images to display in the carousel
                                if (imageUrls.isNotEmpty) {
                                  return CarouselSlider(
                                    options: CarouselOptions(
                                      height:
                                          300.0, // Adjust the height of the slider as needed
                                      autoPlay:
                                          true, // Enable auto-playing of images
                                      enlargeCenterPage: true,
                                      viewportFraction:
                                          0.8, // Adjust the size of the images
                                      aspectRatio: 16 / 9,
                                    ),
                                    items: imageUrls.map((imageUrl) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return AspectRatio(
                                            aspectRatio: 16 /
                                                9, // Set the desired aspect ratio
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: imageFromBase64String(
                                                  imageUrl),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Text('Nema slika');
                                }
                              } else {
                                return Text('Nema slika');
                              }
                            } else if (snapshot.hasError) {
                              return Text('Greška prilikom dobavljanja slika');
                            } else {
                              return Text('Nema slika');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        List<Nekretnina> recommendedNekretnine =
                            await _nekretnineProvider.recommend(korisnikId()!);

                        // Ovde možete koristiti listu recommendedNekretnine kako želite
                        print(recommendedNekretnine);
                      } catch (e) {
                        print('Error: $e');
                      }
                      var tmpKorisnikNekretninaWish =
                          await _korisnikNekretninaWishProvider?.get(null);
                      setState(() {
                        korisnikNekretninaWishData = tmpKorisnikNekretninaWish!;
                      });

                      bool isAvailable = await _checkIfNekretninaIsInWishList(
                        widget.nekretnina?.nekretninaId,
                        korisnikId(),
                      );
                      if (isAvailable == false) {
                        Map<String, dynamic> request = {
                          'korisnikId': korisnikId(),
                          'nekretninaId': widget.nekretnina?.nekretninaId,
                        };

                        var result = await _korisnikNekretninaWishProvider
                            .insert(request);

                        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Uspješno dodana nekretnina na Vašu listu želja!',
      style: TextStyle(fontSize: 16),
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 3),
  ),
);

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Nekretnina već postoji u Vašoj listi želja!',
      style: TextStyle(fontSize: 16),
    ),
    backgroundColor: Colors.orange,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 3),
  ),
);

                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                          10.0), // Prilagodite razmak oko dugmeta
                      decoration: BoxDecoration(
                        color: Colors.blue, // Prilagodite boju pozadine dugmeta
                        borderRadius: BorderRadius.circular(
                            20.0), // Prilagodite oblik dugmeta
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons
                                .favorite_border, // Koristite ikonu srca ili neku drugu ikonu
                            color: Colors.white, // Prilagodite boju ikone
                          ),
                          SizedBox(width: 5.0), // Razmak između ikone i teksta
                          Text(
                            "Dodaj u listu želja",
                            style: TextStyle(
                              color: Colors.white, // Prilagodite boju teksta
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //  int? reccomendForUser() {
                  

                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
          children: [
            Icon(Icons.attach_money, size: 20, color: const Color.fromARGB(255, 36, 109, 71)), // Ikonica za cijenu
            SizedBox(width: 5),
            Text(
              "Cijena: ${_initialValue['cijena']} BAM",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.home, size: 20, color: const Color.fromARGB(255, 165, 175, 26)), // Ikonica za tip nekretnine
    SizedBox(width: 5),
    Text(
      "Tip nekretnine: ${_getNazivTipa(tipNekretnineId)}",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.swap_horiz, size: 20, color: const Color.fromARGB(255, 25, 103, 145)), // Ikonica za tip akcije
    SizedBox(width: 5),
    Text(
      "Tip akcije: ${nekretninaTipAkcijeId()}",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.new_releases, size: 20, color: Colors.grey), // Ikonica za novogradnju
    SizedBox(width: 5),
    Text("Novogradnja:", style: TextStyle(fontSize: 16)),
    SizedBox(width: 5),
    Icon(
      _initialValue['novogradnja'] == 'true' ? Icons.check : Icons.cancel,
      color: _initialValue['novogradnja'] == 'true' ? Colors.green : Colors.red,
      size: 20,
    ),
  ],
),


                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.meeting_room, size: 20, color: const Color.fromARGB(255, 91, 27, 134)), // Ikonica za broj soba
    SizedBox(width: 5),
    Text(
      "Broj soba: ${_initialValue['brojSoba']}",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.bed, size: 20, color: const Color.fromARGB(255, 125, 52, 52)), // Ikonica za broj spavaćih soba
    SizedBox(width: 5),
    Text(
      "Broj spavaćih soba: ${_initialValue['brojSpavacihSoba']}",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.arrow_upward, size: 20, color: Colors.grey), // Ikonica za sprat
    SizedBox(width: 5),
    Text(
      "Sprat: ${_initialValue['sprat']}",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.local_parking, size: 20, color: Colors.grey), // Ikonica za parking mjesto
    SizedBox(width: 5),
    Text("Parking mjesto:", style: TextStyle(fontSize: 16)),
    SizedBox(width: 5),
    Icon(
      _initialValue['parkingMjesto'] == 'true' ? Icons.check_circle : Icons.cancel,
      color: _initialValue['parkingMjesto'] == 'true' ? Colors.green : Colors.red,
      size: 20,
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.chair, size: 20, color: Colors.grey), // Ikonica za namještenost
    SizedBox(width: 5),
    Text("Namješten:", style: TextStyle(fontSize: 16)),
    SizedBox(width: 5),
    Icon(
      _initialValue['namjesten'] == 'true' ? Icons.check_circle : Icons.cancel,
      color: _initialValue['namjesten'] == 'true' ? Colors.green : Colors.red,
      size: 20,
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
  children: [
    Icon(Icons.aspect_ratio, size: 20, color: Colors.grey), // Ikonica za kvadraturu
    SizedBox(width: 5),
    Text(
      "Kvadratura: ${_initialValue['kvadratura']} m2",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Detaljan opis", // Prikaz cijene iz _initialValue
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${_initialValue['detaljanOpis']} ", // Prikaz cijene iz _initialValue
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(
                        10.0), // Prilagodite veličinu padding-a prema potrebi
                    child: Row(
                      children: [
                        Text(
                          'Informacije o agentu/ima',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<List<dynamic>>(
                                future: _nekretninaAgentiProvider?.get(null),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData) {
                                    return Text('No data available.');
                                  } else {
                                    List<dynamic>? data = snapshot.data;

                                    // Filter the data based on the condit ion
                                    List<dynamic> filteredData = data!
                                        .where((nekretninaAgent) =>
                                            nekretninaAgent.nekretninaId ==
                                            widget.nekretnina?.nekretninaId)
                                        .toList();

                                    if (filteredData.isEmpty) {
                                      return Text(
                                          'No matching data available.');
                                    }
                                    return Container(
                                      height: 200,
                                      
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 5 / 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 30,
                                        ),
                                        itemBuilder: (context, index) {
                                          final nekretninaAgent =
                                              filteredData[index];
                                          dynamic matchingKorisnik =
                                              korisnicidata?.firstWhere(
                                            (korisnik) =>
                                                korisnik.korisnikId ==
                                                nekretninaAgent.korisnikId,
                                            orElse: () => null,
                                          );

                                          if (matchingKorisnik != null) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgentDetaljiScreen(
                                                      korisnik:
                                                          matchingKorisnik,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(width: 1, color: Colors.grey),
    borderRadius: BorderRadius.circular(5),
  ),
  child: LayoutBuilder( // Dodajemo LayoutBuilder da dobijemo constraints
    builder: (context, constraints) {
      return Row(
        children: [
          // Info o agentu
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 24, color: Colors.black),
                    SizedBox(width: 7),
                    Expanded( // Ovdje dodajemo kako bi tekst znao gdje da "pukne"
                      child: Text(
                        'Ime i prezime: ${matchingKorisnik.ime} ${matchingKorisnik.prezime}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.email, size: 24, color: Colors.blue),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        'Email: ${matchingKorisnik.email}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Icon(Icons.phone, size: 24, color: Colors.green),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Telefon: ${matchingKorisnik.telefon}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),

          // Slika agenta
          /*Container(
            width: 100, // Fiksiramo širinu slike
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.memory(
                base64.decode(matchingKorisnik.bajtoviSlike!),
                fit: BoxFit.cover,
              ),
              
            ),
          ),*/
          Container(
  width: 100, // Fiksiramo širinu slike
  height: 100,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: matchingKorisnik.bajtoviSlike != null && matchingKorisnik.bajtoviSlike!.isNotEmpty
        ? Image.memory(
            base64.decode(matchingKorisnik.bajtoviSlike!),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/usericon.webp', // Putanja do defaultne slike
                fit: BoxFit.cover,
              );
            },
          )
        : Image.asset(
            'assets/images/usericon.webp', // Putanja do defaultne slike
            fit: BoxFit.cover,
          ),
  ),
)

        ],
      );
    },
  ),
),

                                            );
                                          } else {
                                            return Text(
                                                'Za ovu nekretninu nije pronađen agent.');
                                          }
                                        },
                                        itemCount: filteredData.length,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        10.0), // Prilagodite veličinu padding-a prema potrebi
                    child: Row(
                      children: [
                        Text(
                          "Zakaži obilazak",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        10.0), // Prilagodite veličinu padding-a prema potrebi
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText: 'Odaberite datum obilaska',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: datumPopravkeController,
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () async {
                            var tmpObilazakData =
                                await _obilazakProvider?.get(null);
                            setState(() {
                              obilasciData = tmpObilazakData!;
                            });
                            DateFormat inputFormat =
                                DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSSS');
                            DateTime parsedDate =
                                inputFormat.parse(datumPopravkeController.text);
                            DateTime? date = selectedDate.value;
                            await _selectTime(context);

                            final DateTime dateTime = DateTime(
                              date!.year,
                              date.month,
                              date.day,
                              selectedTime!.hour,
                              selectedTime!.minute,
                            );
                            DateTime dateTime2 =
                                dateTime.add(Duration(hours: 1));
                            bool isAvailable = await _checkDateAvailability(
                              dateTime,
                              widget.nekretnina?.nekretninaId,
                            );
                            print(
                              "datumic ${dateTime}, nekretninaidic ${widget.nekretnina?.nekretninaId}, isavailable ${isAvailable}",
                            );

                            if (isAvailable == true) {
                              // Datum je dostupan, izvršite zakazivanje
                              Map<String, dynamic> request = {
                                'korisnikId': korisnikId(),
                                'nekretninaId': widget.nekretnina?.nekretninaId,
                                'isOdobren': false,
                                'vrijemeObilaska':
                                    dateTime.toIso8601String() ?? '',
                                'datumObilaska':
                                    selectedDate.value?.toIso8601String() ?? '',
                              };

                              var result =
                                  await _obilazakProvider.insert(request);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Uspješno ste zakazali obilazak!',
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
                              // Datum je zauzet, prikažite odgovarajući alert
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Odabrani datum je već rezervisan. Molimo odaberite neki drugi.',
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
                            }
                          },
                          child: Text('Zakaži'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ), //ovdje
      ),
    );
  }

  String _getNazivTipa(int? tipNekretnineId) {
    TipNekretnine? tipNekretnine = tipNekretnineResult?.result.firstWhere(
      (element) => element.tipNekretnineId == tipNekretnineId,
      // Default value
    );

    return '${tipNekretnine?.nazivTipa} ';
  }

  File? _image;
  String? _base64Image;

  /*Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }*/

  Future<void> getImage() async {
  final picker = ImagePicker();

  // Izbor slike sa galerije
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Ako je slika odabrana, čitaj je kao bajtove
    File imageFile = File(pickedFile.path);
    
    // Pretvori bajtove u base64
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    print("Base64 image: $base64Image");
  } else {
    print('No image selected.');
  }
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
                return Container(
                  width: 100,
                  height: 100,
                  child: imageFromBase64String(slika.bajtoviSlike ?? ""),
                );
              }).toList(),
            );
          } else {
            return Text('Nema slika');
          }
        } else if (snapshot.hasError) {
          return Text('Greška prilikom dobavljanja slika');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Slika>> _getSlikeForNekretnina(int nekretninaId) async {
    _slikeProvider = SlikeProvider(); // Initialize SlikeProvider
    SearchResult<Slika> slikeResult = await _slikeProvider
        .get(filter: {'nekretninaId': nekretninaId.toString()});
    return slikeResult.result;
  }

  Widget _buildDataListView() {
    print("Poziva se _buildDataListView()");
    return Expanded(
      child: ListView.builder(
        itemCount: recommendedNekretninee.length, //result?.result.length ?? 0,
        itemBuilder: (context, index) {
          if (index < recommendedNekretninee.length) {
            int? nekretnina =
                recommendedNekretninee[index]; //result!.result[index];
            print("NekrIdJedan ${nekretnina}");
            return FutureBuilder<List<Slika>>(
              future: _getSlikeForNekretnina(nekretnina ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error fetching images');
                } else if (!snapshot.hasData) {
                  return Text('No images found for this property');
                } else {
                  List<Slika> slike = snapshot.data!;
                  Nekretnina _getNekr(int? nekretninaId) {
                    Nekretnina? tipNekretnine;
                    try {
                      tipNekretnine = nekrData.firstWhere(
                        (element) => element.nekretninaId == nekretninaId,
                        // Default value
                      );
                    } catch (e) {
                      print('Error while fetching TipNekretnine: $e');
                    }

                    return tipNekretnine!;
                  }

                  return GestureDetector(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomCard(
                            context: context,
                            nekretnina: _getNekr(nekretnina),
                            slike: slike,
                            nekretninaId: nekretnina ?? -1,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return SizedBox(); // Prazan widget za slučaj van granica indeksa
          }
        },
      ),
    );
  }
}

//reccomend
class CustomCard extends StatefulWidget {
  final Nekretnina? nekretnina;
  final List<Slika> slike;
  final BuildContext context;
  final int? nekretninaId;

  CustomCard({
    required this.context,
    required this.nekretnina,
    required this.slike,
    required this.nekretninaId,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late PageController _pageController;
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NekretnineDetaljiScreen(
              nekretnina: widget.nekretnina,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageSlider(), // Display the carousel slider

            ListTile(
              title: Text(
                ' ${widget.nekretnina?.naziv ?? ""}',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  '${widget.nekretnina?.cijena ?? ""} BAM',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String username = Authorization.username ?? "";
  Widget _buildImageSlider() {
    List<Slika> slike = widget.slike
        .where((slika) => slika.nekretninaId == widget.nekretninaId)
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 200, // Set the height of the carousel
        viewportFraction: 1.0, // Display a single image at a time
        autoPlay: true, // Enable auto-play
        autoPlayInterval: Duration(seconds: 3), // Auto-play interval
      ),
      items: slike.map((slika) {
        return Image(
          image: MemoryImage(
            base64Decode(slika.bajtoviSlike ?? ''),
          ),
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
    );
  }
}
