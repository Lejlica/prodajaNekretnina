import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipAkcije.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';

import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../utils/util.dart';

class ZahtjeviZaIznajmljivanjeDetaljiScreen extends StatefulWidget {
  final Nekretnina? nekretnina;

  const ZahtjeviZaIznajmljivanjeDetaljiScreen({Key? key, this.nekretnina})
      : super(key: key);

  @override
  _ZahtjeviZaIznajmljivanjeDetaljiScreenState createState() =>
      _ZahtjeviZaIznajmljivanjeDetaljiScreenState();
}

class _ZahtjeviZaIznajmljivanjeDetaljiScreenState
    extends State<ZahtjeviZaIznajmljivanjeDetaljiScreen> {
  late ObilazakProvider _obilazakProvider;
  SearchResult<Nekretnina>? result;
  final TextEditingController _nekretninaIdController = TextEditingController();
  late KorisniciProvider _korisniciProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  late NekretnineProvider _nekretnineProvider;
  late TipAkcijeProvider _tipAkcijeProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  SearchResult<Lokacija>? lokacijeResult;

  late GradoviProvider _gradoviProvider;
  SearchResult<Grad>? gradoviResult;

  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<NekretninaTipAkcije>? nekretninaTipAkcijeResult;
  SearchResult<TipAkcije>? tipAkcijeResult;
  SearchResult<TipNekretnine>? tipoviNekretninaResult;
  @override
  void initState() {
    super.initState();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    initForm();
  }

  Future<void> initForm() async {
    try {
      korisniciResult = await _korisniciProvider.get();
      print(korisniciResult);
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
      print(nekretninaAgentiResult);
      nekretninaTipAkcijeResult = await _nekretninaTipAkcijeProvider.get();
      print(nekretninaTipAkcijeResult);
      tipAkcijeResult = await _tipAkcijeProvider.get();
      print(tipAkcijeResult);
      tipoviNekretninaResult = await _tipoviNekretninaProvider.get();
      print(tipoviNekretninaResult);
      lokacijeResult = await _lokacijeProvider.get();
      print(lokacijeResult);

      gradoviResult = await _gradoviProvider.get();
      print(gradoviResult);
      List<int> nekretnineIdsForProdaja = [];

      // Iterate through tipAkcije items to find matching nekretninaId values
      for (var nekretninaTipAkcije in nekretninaTipAkcijeResult!.result) {
        if (nekretninaTipAkcije.tipAkcijeId == 2) {
          nekretnineIdsForProdaja.add(nekretninaTipAkcije.nekretninaId!);
        }
      }

      result = await _nekretnineProvider.get(
        filter: {
          'nekretninaId': nekretnineIdsForProdaja,
        },
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  Grad? grad;
  String? getNazivGrad() {
    int? gradic;
    gradic = getGradId();
    if (gradoviResult != null && lokacijeResult?.result != null) {
      grad = gradoviResult?.result.firstWhere(
        (grad) => grad.gradId == gradic,
      );

      return grad?.naziv;
    }
    return null;
  }

  Lokacija? lokacija;
  int? getGradId() {
    var lokacijaId = widget.nekretnina?.lokacijaId;
    if (lokacijaId != null &&
        gradoviResult != null &&
        lokacijeResult?.result != null) {
      lokacija = lokacijeResult?.result.firstWhere(
        (lokacija) => lokacija.lokacijaId == lokacijaId,
      );
    }
    print("GradId: ${lokacija?.gradId}");
    return lokacija?.gradId;
  }

  String? getUlica() {
    var lokacijaId = widget.nekretnina?.lokacijaId;
    if (lokacijaId != null &&
        gradoviResult != null &&
        lokacijeResult?.result != null) {
      lokacija = lokacijeResult?.result.firstWhere(
        (lokacija) => lokacija.lokacijaId == lokacijaId,
      );
    }
    print("Ulica: ${lokacija?.ulica}");
    return lokacija?.ulica;
  }

  String? getPB() {
    var lokacijaId = widget.nekretnina?.lokacijaId;
    if (lokacijaId != null &&
        gradoviResult != null &&
        lokacijeResult?.result != null) {
      lokacija = lokacijeResult?.result.firstWhere(
        (lokacija) => lokacija.lokacijaId == lokacijaId,
      );
    }
    print("Ulica: ${lokacija?.postanskiBroj}");
    return lokacija?.postanskiBroj;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zahtjevi za iznajmljivanje'),
      ),
      body: _buildBody(),
    );
  }

  void _launchEmail(int korisnikId) async {
    Widget email = _buildKorisnikEmailCell(korisnikId);

    if (await canLaunch('mailto:$email')) {
      await launch('mailto:$email');
    } else {
      // Ne može se otvoriti email, dodajte odgovarajući tretman ovdje
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd.MM.yyyy. HH:mm').format(date)+ 'h';
  }
  


  Widget _buildBody() {
    // Filter nekretnine based on nekretninaTipAkcijeResult
    List<Nekretnina> filteredNekretnine = result?.result
            .where((nekretnina) => nekretninaTipAkcijeResult!.result.any(
                (tipAkcije) =>
                    tipAkcije.nekretninaId == nekretnina.nekretninaId &&
                    tipAkcije.tipAkcijeId == 2))
            .toList() ??
        [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildSearch(),
          const SizedBox(height: 16),
          Expanded(
            
            child: Padding(
              padding: const EdgeInsets.only(left: 60),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                   showCheckboxColumn: false,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Nekretnina ID',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Datum dodavanja',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Datum izmjene',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Broj ugovora',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ime i prezime',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'E-mail',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Odobren',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: filteredNekretnine
                      .map(
                        (Nekretnina e) => DataRow(
                          onSelectChanged: (selected) {
                            if (selected == true) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NekretninaDetailScreen(
                                    nekretnina: e,
                                    korisniciResult: korisniciResult,
                                    nekretnineProvider: _nekretnineProvider,

                                    //tipNekretnineResult: tipoviNekretninaResult,
                                  ),
                                ),
                              );
                            }
                          },
                          cells: [
                            DataCell(Text(e.nekretninaId?.toString() ?? "")),
                            DataCell(
                              Text(' ${_formatDate(e.datumDodavanja)}'),
                            ),
                            DataCell(
                              Text(' ${_formatDate(e.datumIzmjene)}'),
                            ),
                            DataCell(
                              Text(' ${e.brojUgovora}'),
                            ),
                            DataCell(_buildKorisnikNameCell(e.korisnikId)),
                            DataCell(
                              TextButton(
                                onPressed: () => _launchEmail(e.korisnikId!),
                                child: Text(
                                  '${getMail(e.korisnikId)}',
                                  style: const TextStyle(
                                    color: Colors
                                        .blue, // Postavite boju teksta na plavu ili drugu po želji
                                    decoration: TextDecoration
                                        .underline, // Dodajte podcrtavanje
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Icon(
                                e.isOdobrena == true
                                    ? Icons.check
                                    : Icons.access_time,
                                color: e.isOdobrena == true
                                    ? Colors.green
                                    : Colors.orange,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOdobrenaChecked = false;

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Container(
        width: 1000,
        height: 100,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           /* Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "ID nekretnine",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                controller: _nekretninaIdController,
              ),
            ),*/
            const SizedBox(width: 10),
            Checkbox(
              value: isOdobrenaChecked,
              onChanged: (value) {
                setState(() {
                  isOdobrenaChecked = value!;
                });
              },
            ),
            const Text("Odobrena"),
            const SizedBox(width: 40),
            ElevatedButton(
              onPressed: () async {
                var data = await _nekretnineProvider.get(
                  filter: {
                    'nekretninaId': _nekretninaIdController.text,
                    'isOdobrena': isOdobrenaChecked ? true : false,
                  },
                );

                setState(() {
                  result = data;
                });
              },
              child: const Text("Pretraga"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKorisnikNameCell(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return Text('${korisnik?.ime} ${korisnik?.prezime}');
  }

  Widget _buildKorisnikEmailCell(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return Text('${korisnik?.email}');
  }

  String? getMail(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return korisnik?.email.toString();
  }

  Widget _buildAgentNameCell(int? nekretninaId) {
    NekretninaAgenti? agent = nekretninaAgentiResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
    );

    if (agent != null) {
      Korisnik? korisnik = korisniciResult?.result.firstWhere(
        (element) => element.korisnikId == agent.korisnikId,
      );

      if (korisnik != null) {
        return Text('${korisnik.ime} ${korisnik.prezime}');
      } else {
        return const Text('Unknown Agent');
      }
    } else {
      return const Text('Unknown Agent');
    }
  }
}

class NekretninaDetailScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final Nekretnina nekretnina;

  final SearchResult<Korisnik>? korisniciResult;
  final NekretnineProvider nekretnineProvider;
  final NekretninaAgentiProvider _nekretninaAgentiProvider;

  late LokacijeProvider _lokacijeProvider;
  SearchResult<Lokacija>? lokacijeResult;

  late GradoviProvider _gradoviProvider;
  SearchResult<Grad>? gradoviResult;

  bool isLoading = true;

  NekretninaDetailScreen({super.key, 
    required this.nekretnina,
    required this.korisniciResult,
    required this.nekretnineProvider,

    //required this.tipNekretnineResult,
  }) : _nekretninaAgentiProvider = NekretninaAgentiProvider();
  void _launchEmail(int korisnikId) async {
    String email = _getEmail(korisnikId);

    if (await canLaunch('mailto:$email')) {
      await launch('mailto:$email');
    } else {
      // Ne može se otvoriti email, dodajte odgovarajući tretman ovdje
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalji o zahtjevu'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(children: [
            const SizedBox(height: 16),
            Text(
              'Naziv nekretnine: ${nekretnina.naziv}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
              color: const Color.fromARGB(255, 246, 244, 244),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    /*Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informacije o nekretnini',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Nekretnina ID: ${nekretnina.nekretninaId}'),
                            Text(
                                'Datum dodavanja: ${_formatDate(nekretnina.datumDodavanja)}'),
                            Text(
                                'Datum izmjene: ${_formatDate(nekretnina.datumIzmjene)}'),
                            Text('Tip akcije: Prodaja'),
                            Text('Cijena: ${nekretnina.cijena}'),
                            Text(
                                'Odobrena: ${nekretnina.isOdobrena == true ? 'Odobrena' : 'Nije odobrena'}'),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informacije o prodavcu',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                                'Ime i prezime: ${_getKorisnikName(nekretnina.korisnikId)}'),
                            Text('Email: ${_getEmail(nekretnina.korisnikId)}'),
                            Text(
                                'Broj telefona: ${_getBrTel(nekretnina.korisnikId)}'),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FormBuilderDropdown<String>(
                                name: 'korisnikId',
                                decoration: InputDecoration(
                                  labelText: 'Dodajte agenta za nekretninu',
                                  suffix: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _formKey
                                          .currentState!.fields['korisnikId']
                                          ?.reset();
                                    },
                                  ),
                                  hintText: 'Odaberite agenta',
                                ),
                                onChanged: (newValue) async {
                                  Map<String, dynamic> request = {
                                    'korisnikId': newValue,
                                    'nekretninaId': nekretnina.nekretninaId,
                                  };
                                  print('new value ${newValue}');
                                  print('new value ${request}');
                                  var agentId = request['korisnikId'];
                                  if (agentId != null) {
                                    await _nekretninaAgentiProvider
                                        .insert(request);
                                  }
                                },
                                items: korisniciResult?.result
                                        .map((Korisnik k) => DropdownMenuItem(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              value: k.korisnikId.toString(),
                                              child: Text(k.ime.toString()),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),*/
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FutureBuilder<SearchResult<Slika>>(
                            future: SlikeProvider().get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                SearchResult<Slika>? slike = snapshot.data;

                                if (slike != null &&
                                    slike.result.isNotEmpty) {
                                  // Create a list of image URLs from the data
                                  List<String> imageUrls = slike.result
                                      .where((slika) =>
                                          slika.nekretninaId ==
                                          nekretnina.nekretninaId)
                                      .map((slika) => slika.bajtoviSlike ?? "")
                                      .toList();

                                  // Check if there are images to display in the carousel
                                  if (imageUrls.isNotEmpty) {
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                        height:
                                            200.0, // Adjust the height of the slider as needed
                                        autoPlay:
                                            true, // Enable auto-playing of images
                                        enlargeCenterPage: true,
                                        viewportFraction:
                                            0.5, // Adjust the size of the images
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
                                                margin: const EdgeInsets.symmetric(
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
                                    return const Text('Nema slika');
                                  }
                                } else {
                                  return const Text('Nema slika');
                                }
                              } else if (snapshot.hasError) {
                                return const Text(
                                    'Greška prilikom dobavljanja slika');
                              } else {
                                return const Text('Nema slika');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${nekretnina.cijena ?? ""} BAM',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 25),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .local_hotel, // Hotel icon represents rooms
                                color: Colors.blue, // Set the color to blue
                              ),
                              const SizedBox(
                                  width:
                                      8), // Adjust the space between icon and text
                              Text(
                                'Sobe ${nekretnina.brojSoba ?? ""} ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: nekretnina.parkingMjesto == true
                              ? const Row(
                                  children: [
                                    Icon(
                                      Icons.drive_eta,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Garaža 1',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox
                                  .shrink(), // This will create an empty space if parkingMjesto is false
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.stairs, // Hotel icon represents rooms
                                color: Colors.blue, // Set the color to blue
                              ),
                              const SizedBox(
                                  width:
                                      8), // Adjust the space between icon and text
                              Text(
                                'Sprat ${nekretnina.sprat ?? ""} ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .crop_square, // Hotel icon represents rooms
                                color: Colors.blue, // Set the color to blue
                              ),
                              const SizedBox(
                                  width:
                                      8), // Adjust the space between icon and text
                              Text(
                                'Kvadratura ${nekretnina.kvadratura ?? ""} ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: nekretnina.novogradnja == true
                              ? const Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Novogradnja',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox
                                  .shrink(), // This will create an empty space if parkingMjesto is false
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
              color: const Color.fromARGB(255, 246, 244, 244),
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Informacije o nekretnini',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    'Nekretnina ID: ${nekretnina.nekretninaId}'),
                                Text(
                                    'Datum dodavanja: ${_formatDate(nekretnina.datumDodavanja)}'),
                                Text(
                                    'Datum izmjene: ${_formatDate(nekretnina.datumIzmjene)}'),
                                const Text('Tip akcije: Prodaja'),
                                Row(children: [
                                  const Text(
                                    'Status: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    nekretnina.isOdobrena == true
                                        ? Icons.check
                                        : Icons.access_time,
                                    color: nekretnina.isOdobrena == true
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 24,
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Informacije o prodavcu',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    'Ime i prezime: ${_getKorisnikName(nekretnina.korisnikId)}'),
                                Row(children: [
                                  const Text('Email: '),
                                  TextButton(
                                    onPressed: () =>
                                        _launchEmail(nekretnina.korisnikId!),
                                    child: Text(
                                      _getEmail(nekretnina.korisnikId),
                                      style: const TextStyle(
                                        color: Colors
                                            .blue, // Postavite boju teksta na plavu ili drugu po želji
                                        decoration: TextDecoration
                                            .underline, // Dodajte podcrtavanje
                                      ),
                                    ),
                                  ),
                                ]),
                                Text(
                                    'Broj telefona: ${_getBrTel(nekretnina.korisnikId)}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Visibility(
                visible: nekretnina.isOdobrena == null ||
                    nekretnina.isOdobrena ==
                        false, // Karta će biti vidljiva samo kada je isOdobrena false
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
                  color: const Color.fromARGB(255, 246, 244, 244),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dodajte agenta za nekretninu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: FormBuilderDropdown<String>(
                                name: 'korisnikId',
                                decoration: InputDecoration(
                                  suffix: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _formKey
                                          .currentState!.fields['korisnikId']
                                          ?.reset();
                                    },
                                  ),
                                  hintText: 'Odaberite agenta',
                                ),
                                onChanged: (newValue) async {
                                  Map<String, dynamic> request = {
                                    'korisnikId': newValue,
                                    'nekretninaId': nekretnina.nekretninaId,
                                  };
                                  print('new value $newValue');
                                  print('new value $request');
                                  var agentId = request['korisnikId'];
                                  if (agentId != null) {
                                    await _nekretninaAgentiProvider
                                        .insert(request);
                                  }
                                },
                                items: korisniciResult?.result
                                        .map((Korisnik k) => DropdownMenuItem(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              value: k.korisnikId.toString(),
                                              child: Text(k.ime.toString()),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: nekretnina.isOdobrena == true
                              ? null
                              : () async {
                                  try {
                                    Map<String, dynamic> request = {
                                      'isOdobrena': true,
                                      'naziv': nekretnina.naziv,
                                      'detaljanOpis': nekretnina.detaljanOpis,
                                      'korisnikId': nekretnina.korisnikId,
                                      'nekretninaId': nekretnina.nekretninaId,
                                      'cijena': nekretnina.cijena,
                                      'lokacijaId': nekretnina.lokacijaId,
                                      'kategorijaId': nekretnina.kategorijaId,
                                      'tipNekretnineId':
                                          nekretnina.tipNekretnineId,
                                      'datumDodavanja':
                                          nekretnina.datumDodavanja,
                                      'datumIzmjene': nekretnina.datumIzmjene
                                    };
                                    var result =
                                        await nekretnineProvider.update(
                                      nekretnina.nekretninaId!,
                                      request,
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ZahtjeviZaIznajmljivanjeDetaljiScreen(),
                                      ),
                                    );
                                    print('kliknuli ste odobri ${request}');
                                                                    } catch (e) {
                                    // Prikazati poruku o grešci korisniku
                                    print(
                                        'Greška prilikom izvođenja akcije: $e');
                                  }
                                },
                          child: const Text('Odobri'),
                        ),
                      ],
                    ),
                  ),
                )),
          ]),
        )));
  }

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String _getKorisnikName(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }

  /* String _getTipNekretnineName(int? tipNekretnineId) {
    TipNekretnine? tipNekretnine = tipNekretnineResult?.result.firstWhere(
      (element) => element.tipNekretnineId == tipNekretnineId,
      // Default value
    );

    return tipNekretnine?.nazivTipa ??
        'Unknown Type'; // Return the name or 'Unknown Type'
  }*/

  String _getBrTel(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.telefon}';
  }

  String _getEmail(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.email}';
  }
}
