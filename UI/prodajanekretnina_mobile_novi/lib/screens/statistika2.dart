import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prodajanekretnina_mobile_novi/models/agencija.dart';
import 'package:prodajanekretnina_mobile_novi/providers/agencije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_mobile_novi/models/drzave.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:crypto/crypto.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';

import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';


import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';

import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'dart:convert';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';

import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
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

class SalesStatisticssScreen extends StatefulWidget {
  const SalesStatisticssScreen({Key? key}) : super(key: key);

  @override
  State<SalesStatisticssScreen> createState() => _SalesStatisticssScreenState();
}

class _SalesStatisticssScreenState extends State<SalesStatisticssScreen> {
  //final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late AgencijaProvider _agencijaProvider;
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  bool isLoading = true;
 // SearchResult<Korisnik>? korisniciResult;
   
    List<dynamic> korisniciData = [];
     List<dynamic> agencijeData = [];
     List<dynamic> korisnikAgencijaData = [];
 
  
  
  String? selectedImagePath;
  List<dynamic> kupcidata = [];

@override
void initState() {
  super.initState();
  _loadSalesData();
}

Future<void> _loadSalesData() async {
  _korisniciProvider = context.read<KorisniciProvider>();
  _agencijaProvider = context.read<AgencijaProvider>();
  _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();

  await initForm();         // <- prvo učitaj sve potrebne podatke
  await initSalesData();    // <- tek onda izračunaj prodaje
  setState(() {});          // <- osvježi UI
}


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

 Future initForm() async {
  try {
    var tmpKorisniciData = await _korisniciProvider?.get(null);
    var tmpAgencijeData = await _agencijaProvider?.get(null);
    var tmpKorisniciAgencijeData = await _korisnikAgencijaProvider?.get(null);

    print("tmpKorisniciData $tmpKorisniciData");
    print("tmpAgencijeData $tmpAgencijeData");
    print("tmpKorisniciAgencijeData $tmpKorisniciAgencijeData");

    // ⬇⬇⬇ OVO JE NAJVAŽNIJE ⬇⬇⬇
    setState(() {
      korisniciData = tmpKorisniciData!;
    agencijeData = tmpAgencijeData!;
      korisnikAgencijaData = tmpKorisniciAgencijeData!;
      isLoading = false;
    });
  } catch (e) {
    print('Error in initForm: $e');
  }
}


  String convertBytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  int ukupno = 0;

  Korisnik? nadjiKorisnika(int? korisnikId) {
    List<dynamic> filteredData = korisniciData
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

    for (var entry in korisnikAgencijaData) {
      print('entry.agencijaId: ${entry.agencijaId}, agencijaId: $agencijaId');
      print('Before if condition');
      if (entry.agencijaId == agencijaId) {
        print('Inside if condition');
        print('entry.korisnikId: ${entry.korisnikId}');
        korisnikIds.add(entry.korisnikId);
      }
    }

    

    print("Korisnici: $korisnikIds, $agencijaId");
    int totalSales = 0;

    for (int? korisnikId in korisnikIds) {
      
      Korisnik? korisnik = nadjiKorisnika(korisnikId);
      print("korId $korisnikId");
      print("brnek ${korisnik!.brojUspjesnoProdanihNekretnina}");
   
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
  Future<void> initSalesData() async {
    for (Agencija agencija in agencijeData ?? []) {
      int? agencijaId = agencija.agencijaId;
      salesData[agencijaId] = Saberi(agencijaId) ?? 0;
    }

    // Opcionalno: Ako želite osvježiti widget nakon što se podaci popune, koristite setState
    setState(() {});
  }

  Widget getAgencyNameWidget() {
  List<String> agencijeNazivi = [];

  for (var entry in agencijeData) {
    print('entry.agencijaId: ${entry.agencijaId}');
    print('entry.korisnikId: ${entry.korisnikId}');
    agencijeNazivi.add(entry.naziv!);

    print('Naziv agencije: ${entry.naziv}');
  }

  return ListView.builder(
    shrinkWrap: true, // ako se koristi unutar drugog scrollable widgeta kao što je Column
    physics: const NeverScrollableScrollPhysics(), // ako je deo većeg skrolabilnog dela
    itemCount: agencijeNazivi.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          agencijeNazivi[index],
          style: const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    },
  );
}
String getAgencyNameById(int id) {
  for (var entry in agencijeData) {
    if (entry.agencijaId == id) {
      return entry.naziv ?? 'Nepoznata agencija';
    }
  }
  return 'Nepoznata agencija';
}


@override
Widget build(BuildContext context) {
  if (isLoading) {
    return Center(child: CircularProgressIndicator());
  }
  final int? maxValue = salesData.values.isNotEmpty
      ? salesData.values.reduce((a, b) => a > b ? a : b)
      : null;

  return MasterScreenWidget(
    title: 'Statistika prodaje nekretnina po agencijama',
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Ukupan broj uspješno prodatih nekretnina po agencijama',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xff37434d), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (maxValue != null) ? (maxValue + 10).toDouble() : 100,
                barGroups: salesData.entries.map((entry) {
                  final isTopSeller = entry.value == maxValue;
                  return BarChartGroupData(
                    x: entry.key!,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.toDouble(),
                        color: isTopSeller ? Colors.green : Colors.blue,
                        width: 18,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        rodStackItems: [],
                        // opcionalno
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }).toList(),
                groupsSpace: 14,
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      interval: 20,
                      getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final agencijaId = value.toInt();
                        final agencijaNaziv = getAgencyNameById(agencijaId);
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8.0,
                          child: Transform.rotate(
                            angle: -0.5, // nagni tekst radi preglednosti
                            child: Text(
                              agencijaNaziv,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final naziv = getAgencyNameById(group.x.toInt());
                      return BarTooltipItem(
                        '$naziv\n${rod.toY.toInt()} nekretnina',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (maxValue != null)
            Text(
              'Agencija s najviše prodatih nekretnina: '
              '${getAgencyNameById(salesData.entries.firstWhere((e) => e.value == maxValue).key!)} '
              '(${maxValue} ukupno)',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    ),
  );
}
}

void main() {
  runApp(MaterialApp(
    home: SalesStatisticssScreen(),
  ));
}
