import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile/models/kupci.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/korisnici.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/providers/komentariAgentima_provider.dart';
import 'package:prodajanekretnina_mobile/screens/AgentDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/utils/util.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class WishListaScreen extends StatefulWidget {
  final Korisnik? korisnik;

  const WishListaScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<WishListaScreen> createState() => _WishListaScreenState();
}

class _WishListaScreenState extends State<WishListaScreen> {
  late KorisnikNekretninaWishProvider _korisnikNekretninaWishProvider;
  late KorisniciProvider _korisniciProvider;
  late NekretnineProvider _nekretnineProvider;
  late LokacijeProvider _lokacijeProvider;
  late GradoviProvider _gradoviProvider;
  List<dynamic> data = [];
  List<dynamic> korisniciData = [];
  List<dynamic> nekretnineData = [];
  List<dynamic> lokacijeData = [];
  List<dynamic> gradoviData = [];

  String username = Authorization.username ?? "";
  int userRating = 0;

  @override
  void initState() {
    super.initState();

    _korisniciProvider = context.read<KorisniciProvider>();
    _korisnikNekretninaWishProvider =
        context.read<KorisnikNekretninaWishProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    initForm();
  }

  Future initForm() async {
    try {
      var tmpData = await _korisnikNekretninaWishProvider?.get(null);
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpNekretnineData = await _nekretnineProvider?.get(null);
      var tmpLokacijeData = await _lokacijeProvider?.get(null);
      var tmpGradoviData = await _gradoviProvider?.get(null);
      setState(() {
        data = tmpData!;
        korisniciData = tmpKorisniciData!;
        nekretnineData = tmpNekretnineData!;
        lokacijeData = tmpLokacijeData!;
        gradoviData = tmpGradoviData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

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

  String? nazivNekretnine(int nekretninaId) {
    List<dynamic> filteredData = nekretnineData!
        .where((nekretnina) => nekretnina.nekretninaId == nekretninaId)
        .toList();

    if (filteredData.isNotEmpty) {
      return "${filteredData[0].naziv}";
    } else {
      return null;
    }
  }

/*
  List<Widget> buildObilasciWidgets() {
    // Create a list of widgets representing obilasci details
    List<Widget> obilasciWidgets = [];

    // Define the desired font size
    double fontSize = 18.0; // Change the font size as needed

    for (var obilazak in data) {
      // Check if the obilazak belongs to the current user
      if (obilazak.korisnikId == korisnikId()) {
        obilasciWidgets.add(
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add border
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // Add rounded corners
            ),
            margin: EdgeInsets.all(8.0), // Add margin for spacing
            padding: EdgeInsets.all(8.0), // Add padding for spacing
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "${nazivNekretnine(obilazak.nekretninaId)}",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on), // Location icon
                      SizedBox(width: 8),

                      Expanded(
                        // Wrap in Expanded to take up available space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${lokacijaNekretnine(obilazak.nekretninaId)}",
                              style: TextStyle(
                                  fontSize: fontSize), // Set the font size
                              softWrap:
                                  true, // Allow text to wrap to the next line
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    try {
                      var result = await _korisnikNekretninaWishProvider
                          .delete(obilazak.korisnikNekretninaWishId);

                      // Check the result
                      if (result) {
                        // Deletion was successful
                        print('Obilazak uspješno otkazan.');
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => WishListaScreen(),
                          ),
                        );

                        // Refresh the content by calling initForm() and triggering a rebuild
                        await initForm();
                        setState(() {});
                      } else {
                        // Deletion failed
                        print('Otkazivanje nije uspjelo obilazak.');
                      }
                    } catch (e) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => WishListaScreen(),
                        ),
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Uspješno ste uklonili nekretninu iz vaše liste želja!',
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
                      // Handle unexpected errors
                      print(
                          'Error canceling obilazak: $e obilazakId ${obilazak.korisnikNekretninaWishId}');
                    }
                  },
                  child: Text("Ukloni iz liste želja"),
                ),
                SizedBox(height: 5), // Add some spacing between entries
              ],
            ),
          ),
        );
      }
    }

    return obilasciWidgets;
  }*/
  Nekretnina? nekretninaOdabrana(int? nekretninaId) {
    List<dynamic> filteredData = nekretnineData!
        .where((korisnik) => korisnik.nekretninaId == nekretninaId)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0];
    } else {
      return null;
    }
  }

  List<Widget> buildObilasciWidgets() {
    // Create a list of widgets representing obilasci details
    List<Widget> obilasciWidgets = [];

    // Define the desired font size
    double fontSize = 18.0; // Change the font size as needed

    for (var obilazak in data) {
      // Check if the obilazak belongs to the current user
      if (obilazak.korisnikId == korisnikId()) {
        obilasciWidgets.add(
          GestureDetector(
            onTap: () {
              // Navigate to NekretnineDetaljiScreen when container is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NekretnineDetaljiScreen(
                    nekretnina: nekretninaOdabrana(obilazak.nekretninaId),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add border
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // Add rounded corners
              ),
              margin: EdgeInsets.all(8.0), // Add margin for spacing
              padding: EdgeInsets.all(8.0), // Add padding for spacing
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "${nazivNekretnine(obilazak.nekretninaId)}",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on), // Location icon
                        SizedBox(width: 8),

                        Expanded(
                          // Wrap in Expanded to take up available space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${lokacijaNekretnine(obilazak.nekretninaId)}",
                                style: TextStyle(
                                    fontSize: fontSize), // Set the font size
                                softWrap:
                                    true, // Allow text to wrap to the next line
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        var result = await _korisnikNekretninaWishProvider
                            .delete(obilazak.korisnikNekretninaWishId);

                        // Check the result
                        if (result) {
                          // Deletion was successful
                          print('Obilazak uspješno otkazan.');
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => WishListaScreen(),
                            ),
                          );

                          // Refresh the content by calling initForm() and triggering a rebuild
                          await initForm();
                          setState(() {});
                        } else {
                          // Deletion failed
                          print('Otkazivanje nije uspjelo obilazak.');
                        }
                      } catch (e) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => WishListaScreen(),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Uspješno ste uklonili nekretninu iz vaše liste želja!',
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
                        // Handle unexpected errors
                        print(
                            'Error canceling obilazak: $e obilazakId ${obilazak.korisnikNekretninaWishId}');
                      }
                    },
                    child: Text("Ukloni iz liste želja"),
                  ),
                  SizedBox(height: 5), // Add some spacing between entries
                ],
              ),
            ),
          ),
        );
      }
    }

    return obilasciWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Vaša lista želja",
      child: CustomScrollView(
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
