import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../utils/util.dart';
import 'dart:async';

class ZahtjeviZaObilazakDetaljiScreen extends StatefulWidget {
  final Obilazak? obilazak;

  const ZahtjeviZaObilazakDetaljiScreen({Key? key, this.obilazak}) : super(key: key);

  @override
  _ZahtjeviZaObilazakDetaljiScreenState createState() =>
      _ZahtjeviZaObilazakDetaljiScreenState();
}

class _ZahtjeviZaObilazakDetaljiScreenState
    extends State<ZahtjeviZaObilazakDetaljiScreen> {
  late ObilazakProvider _obilazakProvider;
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  
  SearchResult<Obilazak>? result;
  
 
  final TextEditingController _nekretninaIdController = TextEditingController();
  late KorisniciProvider _korisniciProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  bool isLoading = true;
List<int> nekretninaIdAgencije = [];
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
  SearchResult<Korisnik>? korisniciResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
 /* @override
  void initState() {
    super.initState();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    initForm();
  }*/

  Future<void> initForm() async {
    try {
      korisniciResult = await _korisniciProvider.get();
      print(korisniciResult);
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
      print(korisniciResult);
      korisnikAgencijaResult = await _korisnikAgencijaProvider.get();
      print(korisnikAgencijaResult);
       final noviResult = await _obilazakProvider.get();
    for (var obilazak in noviResult.result) {
  print('ID: ${obilazak.obilazakId}');

  print('Odobren: ${obilazak.isOdobren}');
 
}
NadjiKojojAgencijiPripadaKorisnik();
nekretninaIdAgencije = NadjiNekretnineZaAgenciju();
      setState(() {
        isLoading = false;
         result = noviResult;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }
  @override
void initState() {
  super.initState();
  _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
  _korisniciProvider = context.read<KorisniciProvider>();
  _obilazakProvider = ObilazakProvider();
  _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
  _onRefresh();
  initForm(); // pozivaš API ili postavljaš početne vrijednosti
}

  FutureOr<void> _onRefresh() async {
    var data = await _obilazakProvider.get(filter: {});
    setState(() {
      result = data;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zahtjevi za obilascima'),
      ),
      body: _buildBody(),
    );
  }
  int korisnikID=0;
  String username = Authorization.username ?? "";
  int? korisnikId() {
    List<dynamic> filteredData = korisniciResult!.result
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();
    if (filteredData.isNotEmpty) {
      korisnikID = filteredData[0].korisnikId!;
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
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildSearch(),
          const SizedBox(height: 16),
          Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 1000), // Prilagodi širinu po potrebi
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        columns: const [
          DataColumn(
            label: Text(
              'Redni broj',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Vrijeme obilaska',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Rb. nekretnine',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Korisnik',
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
        rows: result?.result.where((obilazak) => nekretninaIdAgencije.contains(obilazak.nekretninaId))
    .toList()
                .asMap()
                .entries
                .map(
                  (entry) => DataRow.byIndex(
                    index: entry.key,
                    selected: false,
                    onSelectChanged: (selected) async {
  if (selected == true) {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ObilazakDetailScreen(
          obilazak: entry.value,
          korisniciResult: korisniciResult,
          obilazakProvider: _obilazakProvider,
        ),
      ),
    );

    print("Rezultat iz detail screena: $result");

    if (result == true) {
      await initForm(); 
      setState(() {});
    }
  }
}
,

                    cells: [
                      DataCell(Text(entry.value.obilazakId?.toString() ?? "")),
                      DataCell(
                        Text(
                          DateFormat('dd.MM.yyyy HH:mm')
                                  .format(DateTime.parse(entry.value.vrijemeObilaska?.toString() ?? "")) +
                              "h",
                        ),
                      ),
                      DataCell(Text(entry.value.nekretninaId?.toString() ?? "")),
                      DataCell(_buildKorisnikNameCell(entry.value.korisnikId)),
                      DataCell(
                        Icon(
                          entry.value.isOdobren == true ? Icons.check : Icons.access_time,
                          color: entry.value.isOdobren == true ? Colors.green : Colors.orange,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                )
                .toList() ??
            [],
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
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600), // Možeš povećati ako želiš
      child: Container(
        padding: const EdgeInsets.all(16.0),
        
          
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: isOdobrenaChecked,
              onChanged: (value) {
                setState(() {
                  isOdobrenaChecked = value!;
                });
              },
            ),
            const Text("Odobrena"),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: () async {
                var data = await _obilazakProvider.get(
                  filter: {
                    'isOdobren': isOdobrenaChecked,
                  },
                );

                setState(() {
                  result = data;
                });
              },
              icon: const Icon(Icons.search),
              label: const Text("Pretraži"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 87, 88, 171),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
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

class ObilazakDetailScreen extends StatelessWidget {
  final Obilazak obilazak;
  final SearchResult<Korisnik>? korisniciResult;
  final ObilazakProvider obilazakProvider;
  const ObilazakDetailScreen({super.key, 
    required this.obilazak,
    required this.korisniciResult,
    required this.obilazakProvider,
  });
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
        title: const Text('Odobrenje/odbijanje obilazaka'),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 330,
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color:
                            Colors.blue, // Set the color to represent approval
                        size: 24.0, // Set the size as needed
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Odobrenja ',
                        style: TextStyle(
                          color: Colors.blue, // Postavite boju teksta na plavu
                          fontSize:
                              16.0, // Prilagodite veličinu teksta prema potrebi
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '| ',
                        style: TextStyle(
                          color: Colors.blue, // Postavite boju teksta na plavu
                          fontSize:
                              16.0, // Prilagodite veličinu teksta prema potrebi
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Odobrite ili odbijte zahtjev',
                        style: TextStyle(
                          color: Color.fromARGB(239, 158, 158,
                              158), // Postavite boju teksta na plavu
                          fontSize:
                              10.0, // Prilagodite veličinu teksta prema potrebi
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 3,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const VerticalDivider(width: 1, thickness: 1, color: Colors.blue),
                  Text(
                    obilazak.isOdobren == true
                        ? 'Odobren obilazak'
                        : 'Odobrenje na čekanju',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Text('ID: ${obilazak.obilazakId}'),
                  Row(
                    children: [
                      const Text(
                        'Zahtjev poslao: ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                      Text(_getKorisnikName(obilazak.korisnikId)),
                      TextButton(
                        onPressed: () => _launchEmail(obilazak.korisnikId!),
                        child: Text(
                          _getEmail(obilazak.korisnikId),
                          style: const TextStyle(
                            color: Colors
                                .blue, // Postavite boju teksta na plavu ili drugu po želji
                            decoration: TextDecoration
                                .underline, // Dodajte podcrtavanje
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    const Text(
                      'Vrijeme obilaska: ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                    Text(
                      '${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(obilazak.vrijemeObilaska?.toString() ?? ""))+
                            "h"}',
                    ),
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(children: [
                    Text(
                      'Detalji: ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Nekretnina ID: ${obilazak.nekretninaId}')
                  ]),

                  Row(children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Broj telefona: ${_getBrTel(obilazak.korisnikId)}')
                  ]),

                  const SizedBox(height: 20),
                  Row(children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Potvrda'),
                              content: const Text(
                                  'Da li ste sigurni da želite odbiti zahtjev?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Zatvaranje dijaloga
                                  },
                                  child: const Text('Ne'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .pop(); // Zatvaranje originalnog dijaloga

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Uspješno uklonjen zahtjev'),
                                          content: const Text(
                                              'Zahtjev je uspješno odbačen.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pop(); // Zatvaranje dijaloga
                                                Navigator.pop(context, true); 
                                                // Brisanje samo ako korisnik odabere "Da"
                                                var result =
                                                    await obilazakProvider
                                                        .delete(obilazak
                                                            .obilazakId!);

                                                if (result == true) {
                                                  // Kada je brisanje završeno, pričekajte malo prije nego što napravite redirekciju
                                                  Future.delayed(Duration.zero,
                                                      () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ZahtjeviZaObilazakDetaljiScreen(),
                                                      ),
                                                    );
                                                  });
                                                }
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Da'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 228, 56, 13), // Boja pozadine dugmeta
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0), // Radijus gornjeg levog ugla
                          ),
                        ),
                      ),
                      child: const Text(
                        'Odbij',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: obilazak.isOdobren == true
                          ? null
                          : () async {
                              Map<String, dynamic> request = {
                                'isOdobren': true,
                                'korisnikId': obilazak.korisnikId,
                                'nekretninaId': obilazak.nekretninaId,
                                'datumObilaska':
                                    obilazak.datumObilaska?.toIso8601String(),
                                'vrijemeObilaska':
                                    obilazak.vrijemeObilaska?.toIso8601String(),
                              };
                              var result = await obilazakProvider.update(
                                obilazak.obilazakId!,
                                request,
                              );

                              // Show the success dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Uspješno odobren zahtjev'),
                                    content:
                                        const Text('Zahtjev je uspješno odobren.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                           Navigator.pop(context);
                                          Navigator.pop(context, true); 
                                         /* Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ZahtjeviZaObilazakDetaljiScreen()),
                                          );*/ // Close the dialog
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0), // Radijus gornjeg levog ugla
                          ),
                        ),
                      ),
                      child: const Text(
                        'Odobri',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getKorisnikName(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }

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
