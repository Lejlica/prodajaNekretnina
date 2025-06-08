import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ZakazaniObilasciScreen extends StatefulWidget {
  final Korisnik? korisnik;

  const ZakazaniObilasciScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<ZakazaniObilasciScreen> createState() => _ZakazaniObilasciScreenState();
}

class _ZakazaniObilasciScreenState extends State<ZakazaniObilasciScreen> {
  DateTime currentDate = DateTime.now();
  TextEditingController _sadrzajController = TextEditingController();

  late KorisniciProvider _korisniciProvider;
  late NekretnineProvider _nekretnineProvider;
  late ObilazakProvider _obilazakProvider;
  late LokacijeProvider _lokacijeProvider;
  late GradoviProvider _gradoviProvider;
  List<dynamic> data = [];
  List<dynamic> korisniciData = [];
  List<dynamic> nekretnineData = [];
  List<dynamic> lokacijeData = [];
  List<dynamic> gradoviData = [];
  String username = Authorization.username ?? "";
  bool isLoading = true;
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

  String? nazivNekretnine(int nekretninaId) {
    List<dynamic> filteredData = nekretnineData!
        .where((nekretnina) => nekretnina.nekretninaId == nekretninaId)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].naziv;
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

  @override
  void initState() {
    super.initState();

    _korisniciProvider = context.read<KorisniciProvider>();

    _obilazakProvider = context.read<ObilazakProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    initForm();
  }

  Future initForm() async {
    try {
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var searchFilters = {'korisnikId': korisnikId()};
      var tmpObilazakData = await _obilazakProvider?.get(searchFilters);
      var tmpNekretnineData = await _nekretnineProvider?.get(null);
      var tmpLokacijeData = await _lokacijeProvider?.get(null);
      var tmpGradoviData = await _gradoviProvider?.get(null);

      setState(() {
        data = tmpObilazakData!;
        korisniciData = tmpKorisniciData!;
        nekretnineData = tmpNekretnineData!;
        lokacijeData = tmpLokacijeData!;
        gradoviData = tmpGradoviData!;
        isLoading = false;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  List<Widget> buildObilasciWidgets() {
    
  
    List<Widget> obilasciWidgets = [];

    
    double fontSize = 18.0; 

    for (var obilazak in data) {
    
      if (obilazak.korisnikId == korisnikId()) {
        obilasciWidgets.add(
          Card(
  elevation: 6,
  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text(
              "Datum: ${DateFormat('dd.MM.yyyy.').format(obilazak.datumObilaska)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.redAccent),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Lokacija: ${lokacijaNekretnine(obilazak.nekretninaId)}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.blueAccent),
            SizedBox(width: 8),
            Text(
              "Vrijeme: ${DateFormat('HH:mm').format(obilazak.vrijemeObilaska)} h",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.home, color: Colors.green),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Nekretnina: ${nazivNekretnine(obilazak.nekretninaId)}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () async {
              try {
                var result =
                    await _obilazakProvider.delete(obilazak.obilazakId);

                if (result) {
                  print('Obilazak uspješno otkazan.');
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ZakazaniObilasciScreen(),
                    ),
                  );
                  await initForm();
                  setState(() {});
                } else {
                  print('Otkazivanje nije uspjelo.');
                }
              } catch (e) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ZakazaniObilasciScreen(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Uspješno ste otkazali obilazak!',
      style: TextStyle(fontSize: 16),
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    duration: Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

                print('Greška pri otkazivanju: $e');
              }
            },
            icon: Icon(Icons.cancel),
            label: Text("Otkaži obilazak"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
)

        );
      }
    }

    return obilasciWidgets;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
    return Center(child: CircularProgressIndicator());
  }
    return MasterScreenWidget(
      title: "Zakazani obilasci",
      child:  data.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Nema zakazanih obilazaka.",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        :  CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              buildObilasciWidgets(),
            ),
          ),
        ],
      ),
    );
  }
}
