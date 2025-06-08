import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prodajanekretnina_admin/models/agencija.dart';
import 'package:prodajanekretnina_admin/providers/agencije_provider.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'dart:convert';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';

class SalesStatisticsScreen extends StatefulWidget {
  const SalesStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<SalesStatisticsScreen> createState() => _SalesStatisticsScreenState();
}

class _SalesStatisticsScreenState extends State<SalesStatisticsScreen> {
  
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late AgencijaProvider _agencijaProvider;
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  SearchResult<Korisnik>? korisniciResult;
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
  SearchResult<Agencija>? agencijeResult;
  late SearchResult<Korisnik> data;
  String? selectedImagePath;
  List<dynamic> kupcidata = [];

  @override
  void initState() {
    super.initState();

    _initialValue = {};

    _korisniciProvider = context.read<KorisniciProvider>();
    _agencijaProvider = context.read<AgencijaProvider>();
    _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      korisniciResult = await _korisniciProvider.get();
      print("Koirsnici $korisniciResult");
      agencijeResult = await _agencijaProvider.get();
      print("Agncije $agencijeResult");
      korisnikAgencijaResult = await _korisnikAgencijaProvider.get();
      print("KoirAgei $korisnikAgencijaResult");
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  Future<void> initSalesData() async {
    print("Pokrenuo init");
    for (Agencija agencija in agencijeResult?.result ?? []) {
      int? agencijaId = agencija.agencijaId;
      salesData[agencijaId] = Saberi(agencijaId) ?? 0;
      agencijeNazivi.add(agencija.naziv);
      print(
          "Agencije ${agencijeNazivi.toString()}"); // Dodajte ovo kako biste popunili listu
    }

  }

  String convertBytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  int ukupno = 0;

  Korisnik? nadjiKorisnika(int? korisnikId) {
    List<dynamic> filteredData = korisniciResult!.result
        .where((korisnik) => korisnik.korisnikId == korisnikId)
        .toList();

    if (filteredData.isNotEmpty) {
      print(
          "kornsik brojnekr ${filteredData[0].brojUspjesnoProdanihNekretnina}");
      return filteredData[0];
    } else {
      return null;
    }
  }

  int? Saberi(int? agencijaId) {
    List<int?> korisnikIds = [];

    for (var entry in korisnikAgencijaResult!.result) {
      print('entry.agencijaId: ${entry.agencijaId}, agencijaId: $agencijaId');
      print('Before if condition');
      if (entry.agencijaId == agencijaId) {
        print('Inside if condition');
        print('entry.korisnikId: ${entry.korisnikId}');
        korisnikIds.add(entry.korisnikId);
      }
    }

    print('korisnikIds: $korisnikIds');

    print("Korisnici: $korisnikIds, $agencijaId");
    int totalSales = 0;

    for (int? korisnikId in korisnikIds) {
      // Dobavite podatke o korisniku koristeći korisnikId
      Korisnik? korisnik = nadjiKorisnika(korisnikId);
      print("korId $korisnikId");
      print("brnek ${korisnik!.brojUspjesnoProdanihNekretnina}");
      // Ako korisnik postoji i ima svojstvo brojProdatihNekretnina, dodajte ga ukupnom rezultatu
      totalSales += korisnik.brojUspjesnoProdanihNekretnina ?? 0;
          print("totalsales $totalSales");
    }

    return totalSales;
  }

  /*final Map<String?, int> salesData = {
    'Agencija 1': 20,
    'Agencija 2': 50,
    'Agencija 3': 30,
    // Dodajte stvarne podatke o prodaji za svaku agenciju
  };*/
  Map<int?, int> salesData = {};
  Widget getAgencyNameWidgett() {
    return Column(
      children: agencijeNazivi.map((naziv) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            naziv ?? '',
            style: TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }

  List<String?> agencijeNazivi = [];

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Statistika prodaje nekretnina po agencijama',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              height: 500,
              width: 500,
              // ignore: sort_child_properties_last
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  barGroups: salesData.entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key.hashCode,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.toDouble(),
                              color: Colors.blue,
                              width: 16,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  groupsSpace: 12,
                  titlesData: FlTitlesData(
                    bottomTitles:
                        AxisTitles(axisNameWidget: getAgencyNameWidgett()),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                initSalesData();
                print("aks ${getAgencyNameWidgett}");
                // Ovdje možete dodati kod koji se izvršava nakon inicijalizacije podataka
              },
              child: Text('Inicijaliziraj podatke o prodaji'),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SalesStatisticsScreen(),
  ));
}
