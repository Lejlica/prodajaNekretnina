import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ZahtjeviZaObilazakDetaljiScreen extends StatefulWidget {
  final Obilazak? obilazak;

  ZahtjeviZaObilazakDetaljiScreen({Key? key, this.obilazak}) : super(key: key);

  @override
  _ZahtjeviZaObilazakDetaljiScreenState createState() =>
      _ZahtjeviZaObilazakDetaljiScreenState();
}

class _ZahtjeviZaObilazakDetaljiScreenState
    extends State<ZahtjeviZaObilazakDetaljiScreen> {
  late ObilazakProvider _obilazakProvider;
  SearchResult<Obilazak>? result;
  TextEditingController _nekretninaIdController = TextEditingController();
  late KorisniciProvider _korisniciProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  @override
  void initState() {
    super.initState();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    initForm();
  }

  Future<void> initForm() async {
    try {
      korisniciResult = await _korisniciProvider.get();
      print(korisniciResult);
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
      print(korisniciResult);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zahtjevi za obilascima'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildSearch(),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'ID',
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
                      'Nekretnina ID',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Korisnik',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  /*DataColumn(
                  label: Text(
                    'Agent',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),*/
                  DataColumn(
                    label: Text(
                      'Odobren',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: result?.result
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow.byIndex(
                            index: entry.key,
                            selected: false,
                            onSelectChanged: (selected) {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => ObilazakDetailScreen(
                                    obilazak: entry.value,
                                    korisniciResult: korisniciResult,
                                    obilazakProvider: _obilazakProvider,
                                  ),
                                ),
                              )
                                  .then((value) async {
                                var obilazakTemp =
                                    await _obilazakProvider.get();
                                _buildSearch();

                                setState(() {
                                  result = obilazakTemp;
                                });
                              });
                            },
                            cells: [
                              DataCell(Text(
                                  entry.value.obilazakId?.toString() ?? "")),
                              DataCell(Text(
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                  DateTime.parse(
                                      entry.value.vrijemeObilaska?.toString() ??
                                          ""),
                                ),
                              )),
                              DataCell(Text(
                                  entry.value.nekretninaId?.toString() ?? "")),
                              DataCell(_buildKorisnikNameCell(
                                  entry.value.korisnikId)),
                              // DataCell(_buildAgentNameCell(entry.value.nekretninaId)),
                              DataCell(entry.value.isOdobren == true
                                  ? Icon(Icons.check)
                                  : Icon(Icons.close)),
                            ],
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: "ID nekretnine"),
            controller: _nekretninaIdController,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            var data = await _obilazakProvider.get(
              filter: {
                'nekretninaId': _nekretninaIdController.text,
              },
            );

            setState(() {
              result = data;
            });
          },
          child: Text("Pretraga"),
        ),
      ],
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
        return Text('Unknown Agent');
      }
    } else {
      return Text('Unknown Agent');
    }
  }
}

class ObilazakDetailScreen extends StatelessWidget {
  final Obilazak obilazak;
  final SearchResult<Korisnik>? korisniciResult;
  final ObilazakProvider obilazakProvider;
  ObilazakDetailScreen({
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
        title: Text('Odobrenje/odbijanje obilazaka'),
      ),
      body: Center(
        child: Container(
          width: 600,
          height: 330,
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                          color: const Color.fromARGB(239, 158, 158,
                              158), // Postavite boju teksta na plavu
                          fontSize:
                              10.0, // Prilagodite veličinu teksta prema potrebi
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 3,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  VerticalDivider(width: 1, thickness: 1, color: Colors.blue),
                  Text(
                    obilazak.isOdobren == true
                        ? 'Odobren obilazak'
                        : 'Odobrenje na čekanju',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),
                  // Text('ID: ${obilazak.obilazakId}'),
                  Row(
                    children: [
                      Text(
                        'Zahtjev poslao: ',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                      Text('${_getKorisnikName(obilazak.korisnikId)}'),
                      TextButton(
                        onPressed: () => _launchEmail(obilazak.korisnikId!),
                        child: Text(
                          '${_getEmail(obilazak.korisnikId)}',
                          style: TextStyle(
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
                    Text(
                      'Vrijeme obilaska: ',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                    Text(
                      '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(obilazak.vrijemeObilaska?.toString() ?? ""))} PM GMT',
                    ),
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    Text(
                      'Detalji: ',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Nekretnina ID: ${obilazak.nekretninaId}')
                  ]),

                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Broj telefona: ${_getBrTel(obilazak.korisnikId)}')
                  ]),

                  SizedBox(height: 20),
                  Row(children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Potvrda'),
                              content: Text(
                                  'Da li ste sigurni da želite odbiti zahtjev?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Zatvaranje dijaloga
                                  },
                                  child: Text('Ne'),
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
                                              Text('Uspješno uklonjen zahtjev'),
                                          content: Text(
                                              'Zahtjev je uspješno odbačen.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pop(); // Zatvaranje dijaloga
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ZahtjeviZaObilazakDetaljiScreen(),
                                                  ),
                                                );
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
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Da'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 228, 56, 13), // Boja pozadine dugmeta
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0), // Radijus gornjeg levog ugla
                          ),
                        ),
                      ),
                      child: Text(
                        'Odbij',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
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
                                    title: Text('Uspješno odobren zahtjev'),
                                    content:
                                        Text('Zahtjev je uspješno odobren.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ZahtjeviZaObilazakDetaljiScreen()),
                                          ); // Close the dialog
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0), // Radijus gornjeg levog ugla
                          ),
                        ),
                      ),
                      child: Text(
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
