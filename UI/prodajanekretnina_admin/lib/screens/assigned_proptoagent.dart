import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/tipAkcije.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/screens/vise_o_nekretnini.dart';

import 'package:provider/provider.dart';
import '../utils/util.dart';

class AssignedPropertiesScreen extends StatefulWidget {
   @override
  State<AssignedPropertiesScreen> createState() => _AssignedPropertiesScreenState();}


  class _AssignedPropertiesScreenState extends State<AssignedPropertiesScreen> {
late NekretninaAgentiProvider _nekretninaAgentiProvider;
late SearchResult<NekretninaAgenti> nekretninaAgentiResult; 
late KorisniciProvider _korisniciProvider;
late NekretnineProvider _nekretnineProvider;
late SearchResult<Nekretnina> nekretninaResult;
late GradoviProvider _gradoviProvider;
late SearchResult<Grad> gradoviResult;
late SearchResult<Lokacija> lokacijeResult;
late LokacijeProvider _lokacijeProvider;
late ObilazakProvider _obilazakProvider;
late TipAkcijeProvider _tipAkcijeProvider;
late SearchResult<TipAkcije> tipAkcijeResult;
late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
late SearchResult<NekretninaTipAkcije> nekretninaTipAkcijeResult;

late SearchResult<Obilazak> obilazakResult;
  late SearchResult<Korisnik> data;
  String ime = '';
  String prezime = '';
  String email = '';
  int korisnikId = 0;
Set<int?> obilazakNekretninaIds = {};
Set<int?> nekretnineProdaja = {};
Set<int?> nekretnineIznajmljivanje = {};
bool _isLoading = true;



  Korisnik? korisnik;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();
  }
  
@override
  void initState() {
    super.initState();

    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
   _nekretnineProvider = context.read<NekretnineProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();
    initForm();
    
  }

 
  Future initForm() async {
    try {
     
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
      print('nekrAgenti $nekretninaAgentiResult');
      data = await _korisniciProvider.get();
      print('korisnici $data');
      nekretninaResult = await _nekretnineProvider.get();
      print('nekretnine $nekretninaResult');
      gradoviResult = await _gradoviProvider.get();
      print('gradovi $gradoviResult');    
      lokacijeResult = await _lokacijeProvider.get();
      print('lokacije $lokacijeResult');
      obilazakResult = await _obilazakProvider.get();
      print('obilazak $obilazakResult');
      tipAkcijeResult = await _tipAkcijeProvider.get();
      print('tipAkcije $tipAkcijeResult');
      nekretninaTipAkcijeResult = await _nekretninaTipAkcijeProvider.get();
      print('nekretninaTipAkcije $nekretninaTipAkcijeResult');  
     korisnikk();
     
     if (id != null) {
    

      // Filtriraj samo dodijeljene nekretnine ovom agentu
      final filtered = nekretninaAgentiResult.result
          .where((na) => na.korisnikId == id)
          .toList();

      nekretninaAgentiResult.result = filtered;
    }
      List<int> dodijeljeneNekretninaIds =
      nekretninaAgentiResult.result.map((na) => na.nekretninaId!).toList();

  // Filtriraj listu svih nekretnina po ID-evima
  List<Nekretnina> dodijeljeneNekretnine = nekretninaResult.result
      .where((n) => dodijeljeneNekretninaIds.contains(n.nekretninaId))
      .toList();
       obilazakNekretninaIds = obilazakResult.result
    .map((o) => o.nekretninaId)
    .toSet(); // Brži lookup
// Mapa: tipAkcijeId -> naziv (prodaja / iznajmljivanje)
final tipAkcijeMap = {
  for (var tip in tipAkcijeResult.result) tip.tipAkcijeId: tip.naziv?.toLowerCase()
};

// Iteracija kroz sve poveznice nekretnina - tipAkcije
for (var nta in nekretninaTipAkcijeResult.result) {
  final tipNaziv = tipAkcijeMap[nta.tipAkcijeId];

  if (tipNaziv == 'prodaja') {
    nekretnineProdaja.add(nta.nekretninaId);
  } else if (tipNaziv == 'iznajmljivanje') {
    nekretnineIznajmljivanje.add(nta.nekretninaId);
  }
}

// Printanje ID-eva
print('Nekretnine za prodaju: ${nekretnineProdaja.toList()}');
print('Nekretnine za iznajmljivanje: ${nekretnineIznajmljivanje.toList()}');




  // Ažuriraj prikaz
  setState(() {
    nekretninaResult.result = dodijeljeneNekretnine;
      _isLoading = false;
  });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }


 
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Moje dodijeljene nekretnine'),
        backgroundColor: const Color(0xFFB8860B),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: nekretninaAgentiResult.result.isEmpty
            ? const Center(
                child: Text(
                  'Nemate dodijeljenih nekretnina.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          Chip(
            avatar: const Icon(Icons.key, color: Color(0xFFB8860B), size: 20),
            label: const Text("Prodaja"),
            backgroundColor: const Color(0xFFFDF6E3),
            labelStyle: const TextStyle(color: Color(0xFFB8860B)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFFB8860B)),
            ),
          ),
          Chip(
            avatar: const Icon(Icons.home_work, color: Colors.teal, size: 20),
            label: const Text("Iznajmljivanje"),
            backgroundColor: const Color(0xFFE0F2F1),
            labelStyle: const TextStyle(color: Colors.teal),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.teal),
            ),
          ),
          Chip(
            avatar: const Icon(Icons.visibility, color: Colors.blueAccent, size: 20),
            label: const Text("Obilazak"),
            backgroundColor: const Color(0xFFE3F2FD),
            labelStyle: const TextStyle(color: Colors.blueAccent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    ),
                Expanded(
                  child: ListView.builder(
                      itemCount: nekretninaResult.result.length,
                      itemBuilder: (context, index) {
                        final property = nekretninaResult.result[index];
                         final isZaObilazak = obilazakNekretninaIds.contains(property.nekretninaId);
                          bool jeProdaja = nekretnineProdaja.contains(property.nekretninaId);
                          bool jeIznajmljivanje = nekretnineIznajmljivanje.contains(property.nekretninaId);
                        Color iconColor;
                  IconData iconData;
                  
                  if (jeProdaja) {
                    iconData = Icons.key;
                    iconColor = const Color(0xFFB8860B); // Zlatna
                  } else if (jeIznajmljivanje) {
                    iconData = Icons.home_work;
                    iconColor = Colors.teal; // Tamnozelena
                  } else if (isZaObilazak) {
                    iconData = Icons.visibility;
                    iconColor = Colors.blueAccent; // Plava
                  } else {
                    iconData = Icons.home;
                    iconColor = Colors.grey;
                  }
                  
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading:  Icon(
                    iconData,
                    color: iconColor,
                    size: 32,
                  ),
                  
                  
                            title: Text(
                              property.nekretninaId != null
                                  ? property.naziv.toString()
                                  : 'Nepoznata nekretnina',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle:
                            Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getNazivGrad(property)}, ${getUlica(property)}, ${getPB(property)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                       if (isZaObilazak)
                        Text(
                          'Datum obilaska: ${getDatumObilaska(property.nekretninaId)}',
                          style: const TextStyle(fontSize: 13, color: Colors.blueAccent),
                        ),
                    ],
                  ),
                  
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onTap: () {
                             Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViseONekretniniScreen(
          nekretnina: property,
        ),
      ),
    );
                            },
                          ),
                        );
                      },
                    ),
                ),
              ],
            ),
      ),
    );
  }
String username = Authorization.username ?? "";
 int id=0;
  Korisnik? korisnikk() {
    print('Username: $username');
    print('datica: $data');
    List<dynamic> filteredData = data.result.where((korisnik) {
      print('KorisnickoIme: ${korisnik.korisnickoIme}');
      return korisnik.korisnickoIme == username;
    }).toList();

id=filteredData[0].korisnikId;
print('ID: $id');
   

    if (filteredData.isNotEmpty) {
      return filteredData[0];
    } else {
      return null;
    }
  }

  Grad? grad;

  String? getNazivGrad(Nekretnina? nekretnina) {
    int? gradic;
    gradic = getGradId(nekretnina);
    if (gradoviResult != null && lokacijeResult?.result != null) {
      grad = gradoviResult?.result.firstWhere(
        (grad) => grad.gradId == gradic,
      );

      return grad?.naziv;
    }
    return null;
  }

  

  String getDatumObilaska(int? nekretninaId) {
  final obilazak = obilazakResult.result.firstWhere(
    (o) => o.nekretninaId == nekretninaId,
   
  );
  if (obilazak != null && obilazak.datumObilaska != null) {
    return formatDate(obilazak.datumObilaska!.toString());
  }
  return 'Nepoznat datum';
}

String formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd.MM.yyyy. HH:mm').format(date)+ 'h';
  }
  Lokacija? lokacija;
  int? getGradId(Nekretnina ? nekretnina) {
    var lokacijaId = nekretnina?.lokacijaId;
    if (lokacijaId != null &&
        gradoviResult != null &&
        lokacijeResult?.result != null) {
      lokacija = lokacijeResult?.result.firstWhere(
        (lokacija) => lokacija.lokacijaId == lokacijaId,
      );
    }
    print("LokacijaId: ${nekretnina?.lokacijaId}");
    print("GradId: ${lokacija?.gradId}");
    return lokacija?.gradId;
  }
   String? getUlica(Nekretnina ? nekretnina) {
    var lokacijaId = nekretnina?.lokacijaId;
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

  String? getPB(Nekretnina ? nekretnina) {
    var lokacijaId = nekretnina?.lokacijaId;
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

} 

// Example usage:
// AssignedPropertiesScreen(
//   assignedProperties: [
//     {
//       'naziv': 'Stan u centru',
//       'lokacija': 'Sarajevo, Marijin Dvor',
//       'cijena': 250000,
//     },
//     {
//       'naziv': 'Kuća sa vrtom',
//       'lokacija': 'Ilidža, Pejton',
//       'cijena': 320000,
//     },
//   ],
// );
