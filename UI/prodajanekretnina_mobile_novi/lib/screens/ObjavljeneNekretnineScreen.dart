import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/PrijaviProblemScreen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/nekretnine_provider.dart';
import '../utils/util.dart'; 

class ObjavljeneNekretnineScreen extends StatefulWidget {
  const ObjavljeneNekretnineScreen({Key? key}) : super(key: key);

  @override
  State<ObjavljeneNekretnineScreen> createState() => _ObjavljeneNekretnineScreenState();
}

class _ObjavljeneNekretnineScreenState extends State<ObjavljeneNekretnineScreen> {
  List<dynamic> mojeNekretnine = [];
  bool isLoading = true;
  late SlikeProvider slikeProvider;
  late KorisniciProvider korisniciProvider;
  List<dynamic>? korisnici;
  String username = Authorization.username ?? "";
  Map<int, Uint8List?> slikeMap = {};

  @override
  void initState() {
    super.initState();
    loadNekretnine();
  }

Future<void> loadNekretnine() async {
  setState(() {
    isLoading = true;
  });

  try {
    final nekretnineProvider = Provider.of<NekretnineProvider>(context, listen: false);
    final korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    slikeProvider = context.read<SlikeProvider>();

    final allNekretnine = await nekretnineProvider.get({});
    final data = await korisniciProvider.get({});
    korisnici = data;

    final currentUserId = korisnikId();
    if (currentUserId == null) {
      print('Nije pronađen korisnik za username: $username');
      setState(() => isLoading = false);
      return;
    }

    final moje = allNekretnine.where((n) => n.korisnikId == currentUserId).toList();
    slikeMap.clear();

    for (var nekretnina in moje) {
      var slikeResult = await slikeProvider.get(
        filter: {'nekretninaId': nekretnina.nekretninaId.toString()},
      );

      if (slikeResult.result.isNotEmpty && slikeResult.result.first.bajtoviSlike != null) {
        slikeMap[nekretnina.nekretninaId!] = base64Decode(slikeResult.result.first.bajtoviSlike!);
      } else {
        slikeMap[nekretnina.nekretninaId!] = null;
      }
    }

    setState(() {
      mojeNekretnine = moje;
      isLoading = false;
    });

  } catch (e) {
    print('Greška prilikom učitavanja nekretnina: $e');
    setState(() {
      isLoading = false;
    });
  }
}

int? korisnikId() {
    List<dynamic> filteredData =
        korisnici!.where((korisnik) => korisnik.korisnickoIme == username).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }
  String formatCijena(double cijena) {
    final formatCurrency = NumberFormat.currency(locale: 'hr_HR', symbol: '€');
    return formatCurrency.format(cijena);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje nekretnine'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : mojeNekretnine.isEmpty
              ? const Center(child: Text('Nemate dodanih nekretnina.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: mojeNekretnine.length,
                  itemBuilder: (context, index) {
  final nekretnina = mojeNekretnine[index];
  Uint8List? slikaBajtovi = slikeMap[nekretnina.nekretninaId!];

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 6,
    margin: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (slikaBajtovi != null)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.memory(
              slikaBajtovi,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.image_not_supported));
              },
            ),
          )
        else
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(
              child: Icon(Icons.photo, size: 60, color: Colors.grey),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatCijena(nekretnina.cijena),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                
                  Text('Kvadratura: ${nekretnina.kvadratura} m²'),
                  Text('Sobe: ${nekretnina.brojSoba}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    nekretnina.novogradnja ? Icons.check_circle : Icons.cancel,
                    color: nekretnina.novogradnja ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  const Text('Novogradnja'),
                  const SizedBox(width: 16),
                  Icon(
                    nekretnina.parkingMjesto ? Icons.local_parking : Icons.block,
                    color: nekretnina.parkingMjesto ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  const Text('Parking'),
                ],
              ),
              const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 173, 70, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrijaviProblemScreen(
                        nekretnina: nekretnina,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.report_problem, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text("Prijavi problem", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ],
    ),
  );
}

                ),
    );
  }
}
