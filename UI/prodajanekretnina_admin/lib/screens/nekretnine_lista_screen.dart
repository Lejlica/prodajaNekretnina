import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/tipAkcije.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import '../utils/util.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_nekr2.dart';
import 'package:prodajanekretnina_admin/screens/vise_o_nekretnini.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class NekretnineListScreen extends StatefulWidget {
  const NekretnineListScreen({Key? key}) : super(key: key);

  @override
  State<NekretnineListScreen> createState() => _NekretnineListScreenState();
}

class CustomCard extends StatefulWidget {
  final Nekretnina? nekretnina;
  final List<Slika> slike;
  final BuildContext context;
  final int? nekretninaId;

  const CustomCard({super.key, 
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
  SearchResult<Lokacija>? lokacijeResult;
  late LokacijeProvider _lokacijeProvider;
late NekretnineProvider _nekretnineProvider;
SearchResult<Nekretnina>? nekretnineResult;
late KorisnikAgencijaProvider _korisnikAgencijaProvider;
late KorisniciProvider _korisniciProvider;
late NekretninaAgentiProvider _nekretninaAgentiProvider;
SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
   SearchResult<Korisnik>? korisniciResult;
  late GradoviProvider _gradoviProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late TipAkcijeProvider _tipAkcijeProvider;
  SearchResult<Grad>? gradoviResult;
  SearchResult<NekretninaTipAkcije>? nekretninaTipAkcijeResult;
  SearchResult<TipAkcije>? tipAkcijeResult;
List<int> nekretninaIdAgencije = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
_nekretnineProvider = context.read<NekretnineProvider>();

    _pageController = PageController(initialPage: 0);
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    initForm();
     
  }

  Future initForm() async {
    try {
      lokacijeResult = await _lokacijeProvider.get();
      print(lokacijeResult);

      gradoviResult = await _gradoviProvider.get();
      print(gradoviResult);

      nekretninaTipAkcijeResult = await _nekretninaTipAkcijeProvider.get();
      tipAkcijeResult = await _tipAkcijeProvider.get();
      
nekretnineResult = await _nekretnineProvider.get(filter: {
        'isOdobrena': true,
      });
      korisniciResult = await _korisniciProvider.get();
      korisnikAgencijaResult = await _korisnikAgencijaProvider.get();
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
korisnikId();
      agencijaIdd();
      NadjiKojojAgencijiPripadaKorisnik();
nekretninaIdAgencije = NadjiNekretnineZaAgenciju();
await _performSearch();
      setState(() {isLoading = false;});
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
int korisnikID=0;
String ime='';
  String username = Authorization.username ?? "";
  int? korisnikId() {
    List<dynamic> filteredData = korisniciResult!.result
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();
    if (filteredData.isNotEmpty) {
      korisnikID = filteredData[0].korisnikId!;
      ime = filteredData[0].ime ?? '';
      print('korisnikIDDD: $korisnikID');
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }

int? agencijaIdd() {
    List<dynamic> filteredData = korisnikAgencijaResult!.result
        .where((korisnik) => korisnik.korisnikId == korisnikId())
        .toList();
    if (filteredData.isNotEmpty) {
      return filteredData[0].agencijaId;
    } else {
      return null;
    }
  }
List<int> NadjiNekretnineZaAgenciju() {
  // 1. Nađi sve korisnike koji pripadaju agenciji
  List<int> agentiAgencije = korisnikAgencijaResult!.result
      .where((entry) => entry.agencijaId == pripadajucaAgencija)
      .map((entry) => entry.korisnikId!)
      .toList();
      print('agentiAgencije: ${agentiAgencije}');

  
 List<int> nekretnineAgencije = [];
     for (var entry in agentiAgencije) {
  nekretnineAgencije = nekretninaAgentiResult!.result
      .where((na) => na.korisnikId == entry)
      .map((na) => na.nekretninaId!)
      .toList();

  // sada možeš dalje koristiti nekretnineAgencije
}

      
print('nekretnineAgencije: ${nekretnineAgencije}');
  return nekretnineAgencije;
}

  int? pripadajucaAgencija;
int? NadjiKojojAgencijiPripadaKorisnik() {
    for (var entry in korisnikAgencijaResult!.result) {
      print(
          'entry.agencijaId: ${entry.agencijaId}, agencijaId: ${agencijaIdd()}');
      print('Before if condition');
      if (entry.korisnikId == korisnikID) {
        print('Inside if condition');
        print('korisnik pripada agenciji: ${entry.agencijaId}');
        pripadajucaAgencija = entry.agencijaId;
      }
    }
    return pripadajucaAgencija ;
  }

  Korisnik? korisnik;
  int? getKorId() {
    var korisnikId = widget.nekretnina?.korisnikId;
    if (korisnikId != null &&
        korisniciResult != null
        ) {
      korisnik = korisniciResult?.result.firstWhere(
        (korisnik) => korisnik.korisnikId == korisnikId,
      );
    }
    print("NoviKorId: ${widget.nekretnina?.korisnikId}");
    print("Nadjeni: ${korisnik?.korisnikId}");
    return korisnik?.korisnikId;
  }
Korisnik? korisnic;
   String? getImeVlasnika() {
   int? kor;
    kor = getKorId();
    if (korisniciResult != null ) {
      korisnic = korisniciResult?.result.firstWhere(
        (korisnic) => korisnic.korisnikId == kor,
      );

      return korisnik?.ime;
    }
    return null;
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

  NekretninaTipAkcije? nta;
  TipAkcije? ta;

  

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
    print("LokacijaId: ${widget.nekretnina?.lokacijaId}");
    print("GradId: ${lokacija?.gradId}");
    return lokacija?.gradId;
  }
  String? getTipAkcije() {
    int? gradic;
    gradic = getGradId();
    if (nekretninaTipAkcijeResult != null) {
      nta = nekretninaTipAkcijeResult?.result.firstWhere(
        (nta) => nta.nekretninaId == widget.nekretnina?.nekretninaId,
      );

      ta = tipAkcijeResult?.result
          .firstWhere((e) => e.tipAkcijeId == nta!.tipAkcijeId);

      return ta?.naziv;
    }
    return null;
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

  Nekretnina? nek;
  Nekretnina? filterNekretnina(
      Nekretnina nekretnina, SearchResult<NekretninaTipAkcije>? tipAkcijeList) {
    nek = tipAkcijeList!.result.any((tipAkcije) =>
            tipAkcije.nekretninaId == nekretnina.nekretninaId &&
            tipAkcije.tipAkcijeId == 2)
        ? nekretnina
        : null;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViseONekretniniScreen(
              nekretnina: widget.nekretnina!,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildImageSlider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' ${getTipAkcije()}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 245, 203, 76)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' ${widget.nekretnina?.naziv ?? ""}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on, // Replace with your custom location icon
                    color: Colors.blue, // Set the color of the icon
                  ),
                  const SizedBox(width: 8), // Adjust the space between icon and text
                  Text(
                    '${getNazivGrad()}, ${getUlica()}, ${getPB()} ',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 163, 163, 163),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.nekretnina?.cijena ?? ""} BAM',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                   'Vlasnik: ${getImeVlasnika()} ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 68, 104, 106),
                    fontSize: 13),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_hotel, // Hotel icon represents rooms
                        color: Colors.blue, // Set the color to blue
                      ),
                      const SizedBox(
                          width: 8), // Adjust the space between icon and text
                      Text(
                        'Sobe ${widget.nekretnina?.brojSoba ?? ""} ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 163, 163, 163),
                            fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.nekretnina?.parkingMjesto == true
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
                                  color:
                                      Color.fromARGB(255, 163, 163, 163),
                                  fontSize: 11),
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
                          width: 8), // Adjust the space between icon and text
                      Text(
                        'Sprat ${widget.nekretnina?.sprat ?? ""} ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 163, 163, 163),
                            fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
Future<void> _performSearch() async {
  // Dohvati sve odobrene nekretnine
  var data = await _nekretnineProvider.get(filter: {
    'isOdobrena': true,
  });

  // Filtriraj lokalno nekretnine koje pripadaju agenciji
  var filtriraniRezultati = data.result
      .where((nekretnina) => nekretninaIdAgencije.contains(nekretnina.nekretninaId))
      .toList();
       for (var nekretnina in filtriraniRezultati) {
  print('ID nekretnine iz: ${nekretnina.nekretninaId}');

  // Ažuriraj nekretnineResult s filtriranim rezultatima
  setState(() {
    nekretnineResult = SearchResult<Nekretnina>()
      ..result = filtriraniRezultati
      ..count = filtriraniRezultati.length;
  });
 
}

}


  Widget _buildImageSlider() {
    List<Slika> slike = widget.slike
        .where((slika) => slika.nekretninaId == widget.nekretninaId)
        .toList();
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: slike.length,
          itemBuilder: (context, index) {
            return Image(
              image: MemoryImage(
                base64Decode(slike[index].bajtoviSlike ?? ''),
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
        ),
        Positioned(
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_pageController.page != 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (_pageController.page! < slike.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _NekretnineListScreenState extends State<NekretnineListScreen> {
  late NekretnineProvider _nekretnineProvider;
  SearchResult<Nekretnina>? result;
  final TextEditingController _gradController = TextEditingController();
  final TextEditingController _vlasnikController =
      TextEditingController(); // Add this line
       final TextEditingController _cijenaOdController =
      TextEditingController();
       final TextEditingController _cijenaDoController =
      TextEditingController();
  Map<int, List<Slika>> slikeMap = {};
  List<Slika> slike = [];
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
late KorisniciProvider _korisniciProvider;
late NekretninaAgentiProvider _nekretninaAgentiProvider;
SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
   SearchResult<Korisnik>? korisniciResult;
List<int> nekretninaIdAgencije = [];
  void _navigateToDetailsScreen(Nekretnina? nekretnina) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NekretnineDetaljiScreen(
          nekretnina: nekretnina,
        ),
      ),
    );
  }
 void initState() {
    super.initState();
_nekretnineProvider = context.read<NekretnineProvider>();

    
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    initForm();
     _initializeData();
     _performSearch();
  }

  Future initForm() async {
    try {
      
      korisniciResult = await _korisniciProvider.get();
      korisnikAgencijaResult = await _korisnikAgencijaProvider.get();
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
korisnikId();
      agencijaIdd();
      NadjiKojojAgencijiPripadaKorisnik();
nekretninaIdAgencije = NadjiNekretnineZaAgenciju();
      setState(() {});
    } catch (e) {
      print('Error in initForm: $e');
    }
  }
  Future<void> _fetchData() async {
  var data = await _nekretnineProvider.get(filter: {
    'vlasnik': _vlasnikController.text,
    'grad': _gradController.text,
    'isOdobrena': true,
    'cijenaOd': _cijenaOdController.text,
    'cijenaDo': _cijenaDoController.text,
  });

  var filtriraniRezultati = data.result
      .where((nekretnina) =>
          nekretninaIdAgencije.contains(nekretnina.nekretninaId))
      .toList();

  print('Filtrirani ID-evi nekretnina: ${filtriraniRezultati.map((e) => e.nekretninaId).toList()}');
  print('idag: ${nekretninaIdAgencije.toList()}');

  setState(() {
    result = data
      ..result = filtriraniRezultati
      ..count = filtriraniRezultati.length;
  });

  for (var nekretnina in data.result) {
    print("Cijena: ${nekretnina.cijena}");
  }
}
Future<void> _initializeData() async {
  await initForm(); // Sačekaj da se sve pripremi
  _fetchData();     // Tek tada pozovi pretragu
}

 /* @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nekretnineProvider = context.read<NekretnineProvider>();
  }*/
  bool _didFetchData = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _nekretnineProvider = context.read<NekretnineProvider>();
  _korisniciProvider = context.read<KorisniciProvider>();
  _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
  _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();

  if (!_didFetchData) {
    _performSearch();
    _didFetchData = true;
  }
}
int korisnikID=0;
String ime='';
  String username = Authorization.username ?? "";
  int? korisnikId() {
    List<dynamic> filteredData = korisniciResult!.result
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();
    if (filteredData.isNotEmpty) {
      korisnikID = filteredData[0].korisnikId!;
      ime = filteredData[0].ime ?? '';
      print('korisnikIDDD: $korisnikID');
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }

int? agencijaIdd() {
    List<dynamic> filteredData = korisnikAgencijaResult!.result
        .where((korisnik) => korisnik.korisnikId == korisnikId())
        .toList();
    if (filteredData.isNotEmpty) {
      return filteredData[0].agencijaId;
    } else {
      return null;
    }
  }
List<int> NadjiNekretnineZaAgenciju() {
  // 1. Nađi sve korisnike koji pripadaju agenciji
  List<int> agentiAgencije = korisnikAgencijaResult!.result
      .where((entry) => entry.agencijaId == pripadajucaAgencija)
      .map((entry) => entry.korisnikId!)
      .toList();
      print('agentiAgencije: ${agentiAgencije}');

  
 List<int> nekretnineAgencije = [];

for (var entry in agentiAgencije) {
  nekretnineAgencije.addAll(
    nekretninaAgentiResult!.result
        .where((na) => na.korisnikId == entry)
        .map((na) => na.nekretninaId!)
        .toList(),
  );
}


      
print('nekretnineAgencije: ${nekretnineAgencije}');
  return nekretnineAgencije;
}

  int? pripadajucaAgencija;
int? NadjiKojojAgencijiPripadaKorisnik() {
    for (var entry in korisnikAgencijaResult!.result) {
      print(
          'entry.agencijaId: ${entry.agencijaId}, agencijaId: ${agencijaIdd()}');
      print('Before if condition');
      if (entry.korisnikId == korisnikID) {
        print('Inside if condition');
        print('korisnik pripada agenciji: ${entry.agencijaId}');
        pripadajucaAgencija = entry.agencijaId;
      }
    }
    return pripadajucaAgencija ;
  }
Future<void> _performSearch() async {
  var data = await _nekretnineProvider.get(filter: {
    'vlasnik': _vlasnikController.text,
    'grad': _gradController.text,
    'isOdobrena': true,
    'cijenaOd': _cijenaOdController.text,
    'cijenaDo': _cijenaDoController.text,
  });
var filtriraniRezultati = data.result
      .where((nekretnina) => nekretninaIdAgencije.contains(nekretnina.nekretninaId))
      .toList();
      

  // Ažuriraj nekretnineResult s filtriranim rezultatima
  setState(() {
    result = SearchResult<Nekretnina>()
      ..result = filtriraniRezultati
      ..count = filtriraniRezultati.length;
  });
  
}


  Future<List<Slika>> _getSlikeForNekretnina(int nekretninaId) async {
    SearchResult<Slika> slikeResult = await SlikeProvider()
        .get(filter: {'nekretninaId': nekretninaId.toString()});
    return slikeResult.result;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Lista nekretnina",
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }

 Widget _buildSearch() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pretraži nekretnine',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildSearchField(
              controller: _vlasnikController,
              label: 'Vlasnik',
              icon: Icons.person,
            ),
            const SizedBox(width: 8),
            _buildSearchField(
              controller: _gradController,
              label: 'Grad',
              icon: Icons.location_city,
            ),
            const SizedBox(width: 8),
            _buildSearchField(
              controller: _cijenaOdController,
              label: 'Cijena od (BAM)',
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(width: 8),
            _buildSearchField(
              controller: _cijenaDoController,
              label: 'Cijena do (BAM)',
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Align(
  alignment: Alignment.centerRight,
  child: ElevatedButton.icon(
    onPressed: () async {
      var data = await _nekretnineProvider.get(filter: {
        'vlasnik': _vlasnikController.text,
        'grad': _gradController.text,
        'isOdobrena': true,
        'cijenaOd': _cijenaOdController.text,
        'cijenaDo': _cijenaDoController.text,
      });
      var filtriraniRezultati = data.result
      .where((nekretnina) => nekretninaIdAgencije.contains(nekretnina.nekretninaId))
      .toList();
       print('Filtrirani ID-evi nekretnina: ${filtriraniRezultati.map((e) => e.nekretninaId).toList()}');

 print('idag: ${nekretninaIdAgencije.toList()}');
  // Ažuriraj nekretnineResult s filtriranim rezultatima
  setState(() {
    result = data
      ..result = filtriraniRezultati
      ..count = filtriraniRezultati.length;
  });

      /*setState(() {
        result = data;
      });*/

      for (var nekretnina in data.result) {
        print("Cijena: ${nekretnina.cijena}");
      }
    },
    icon: const Icon(Icons.search, color: Colors.white),
    label: const Text(
      'Pretraži',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 87, 88, 171),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    ),
  ),
),

      ],
    ),
  );
}

Widget _buildSearchField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Expanded(
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    ),
  );
}


  Widget _buildDataListView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: result?.result.length ?? 0,
        itemBuilder: (context, index) {
          Nekretnina? nekretnina = result!.result[index];
          return FutureBuilder<List<Slika>>(
            future: _getSlikeForNekretnina(nekretnina.nekretninaId ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error fetching images');
              } else if (!snapshot.hasData) {
                return const Text('No images found for this property');
              } else {
                List<Slika> slike = snapshot.data!;

                // Store the images in the map using the property ID as the key
                slikeMap[nekretnina.nekretninaId ?? 0] = slike;

                return GestureDetector(
                  onTap: () => _navigateToDetailsScreen(nekretnina),
                  child: CustomCard(
                    context: context,
                    nekretnina: nekretnina,
                    slike: slike,
                    nekretninaId: nekretnina.nekretninaId ?? -1,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(Nekretnina? nekretnina) {
    return Card(
      child: ListTile(
        onTap: () {
          if (nekretnina != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NekretnineDetaljiScreen(
                  nekretnina: nekretnina,
                ),
              ),
            );
          }
        },
        title: Text('ID: ${nekretnina?.nekretninaId ?? ""}'),
        subtitle: Text('Cijena: ${nekretnina?.cijena ?? ""}'),
        trailing: CustomCard(
          context: context,
          nekretnina: nekretnina,
          slike: slike,
          nekretninaId:
              nekretnina?.nekretninaId, 
        ),
      ),
    );
  }
}