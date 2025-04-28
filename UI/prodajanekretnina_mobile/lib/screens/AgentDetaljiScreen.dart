import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile/models/kupci.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/korisnici.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile/providers/recenzija_provider.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/providers/komentariAgentima_provider.dart';
import 'package:prodajanekretnina_mobile/screens/AgentDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/utils/util.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentDetaljiScreen extends StatefulWidget {
  final Korisnik? korisnik;

  const AgentDetaljiScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<AgentDetaljiScreen> createState() => _AgentDetaljiScreenState();
}

class CommentWidget extends StatelessWidget {
  final String text;

  const CommentWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text),
    );
  }
}

class _AgentDetaljiScreenState extends State<AgentDetaljiScreen> {
  DateTime currentDate = DateTime.now();
  TextEditingController _sadrzajController = TextEditingController();
  late KomentariAgentimaProvider _komentariAgentimaProvider;
  late KorisniciProvider _korisniciProvider;
  late KupciProvider _kupciProvider;
  late RecenzijaProvider _recenzijaProvider;
  List<dynamic> data = [];
  List<dynamic> korisniciData = [];
  List<dynamic> kupciData = [];
  List<dynamic> recenzijeData = [];
  String username = Authorization.username ?? "";
  int userRating = 0;

  @override
  void initState() {
    super.initState();
    _komentariAgentimaProvider = context.read<KomentariAgentimaProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _kupciProvider = context.read<KupciProvider>();
    _recenzijaProvider = context.read<RecenzijaProvider>();

    initForm();
    currentRating = this.widget.korisnik?.rejtingKupaca;
  }

  Future initForm() async {
    try {
      var tmpData = await _komentariAgentimaProvider?.get(null);
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpKupciData = await _kupciProvider?.get(null);
      var tmpRecenzijeData = await _recenzijaProvider?.get(null);
      setState(() {
        data = tmpData!;
        korisniciData = tmpKorisniciData!;
        kupciData = tmpKupciData!;
        recenzijeData = tmpRecenzijeData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  String? kupacUsername(int username) {
    List<dynamic> filteredData =
        kupciData!.where((kupac) => kupac.kupacId == username).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].korisnickoIme;
    } else {
      return null;
    }
  }

  int? kupacId(String username) {
    List<dynamic> filteredData =
        kupciData!.where((kupac) => kupac.korisnickoIme == username).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].kupacId;
    } else {
      return null;
    }
  }

  num? currentRating = 0; // Početni rejting
  int totalRatings = 0; // Broj datih rejtinga
  num? totalRatingSum = 0; // Sum of all ratings

  void updateRating(int newRating) {
    setState(() {
      totalRatings++;
      totalRatingSum =
          (totalRatingSum ?? 0) + newRating; // Add a null check here
      print("total klikova ${totalRatings}");
    });
  }

  num calculateAverageRating() {
    if (totalRatings == 0 || totalRatingSum == null) {
      return currentRating ?? 0;
    }
    return totalRatingSum! / totalRatings;
  }

  num? calculateTotalRating() {
    if (currentRating == null) {
      return 0;
    }
    return currentRating;
  }

  int korisnikId(String username) {
    List<dynamic> filteredData = korisniciData!
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();

    if (filteredData.isNotEmpty) {
      print("kroisnikId ${filteredData[0].korisnikId}");
      return filteredData[0].korisnikId;
    } else {
      return 0;
    }
  }

  int recenzijaId(String username) {
    List<dynamic> filteredData = recenzijeData!
        .where((korisnik) => korisnik.kupacId == kupacId(username))
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].recenzijaId;
    } else {
      return 0;
    }
  }

  void updateAgentRating(int newRating) async {
    Map<String, dynamic> request = {
      'vrijednostZvjezdica': newRating,
      'kupacId': kupacId(username),
      'korisnikId': widget.korisnik!.korisnikId,
    };
    print("Stari rejting ${newRating}");

    List<dynamic> filteredData = recenzijeData!
        .where((recenzija) =>
            recenzija.korisnikId == widget.korisnik?.korisnikId &&
            recenzija.kupacId == kupacId(username))
        .toList();

    if (filteredData.isNotEmpty) {
      print(
          "Agent ${filteredData[0].korisnikId}, Kupac ${filteredData[0].kupacId}");
      print("updatujemo na ${newRating}");
      await _recenzijaProvider.update(recenzijaId(username), request);
    } else {
      // Handle the case when filteredData is empty
      print("No data for the agent and buyer combination");
      var result = await _recenzijaProvider.insert(request);
    }
  }

  num totalRating = 0;
  int numberOfRatings = 0;
  double averageRating = 0.0;

  int vratiNmberOfRatings() {
    List<dynamic> filteredData = recenzijeData!
        .where((kupac) => kupac.korisnikId == widget.korisnik?.korisnikId)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData.length;
    } else {
      return 0;
    }
  }

  num vratiSumuVrijednostiZvjezdica() {
    List<dynamic> filteredData = recenzijeData!
        .where((kupac) => kupac.korisnikId == widget.korisnik?.korisnikId)
        .toList();

    if (filteredData.isNotEmpty) {
      return filteredData.fold(
          0, (sum, recenzija) => sum + (recenzija.vrijednostZvjezdica ?? 0));
    } else {
      return 0;
    }
  }

  num izracunajAverageRating() {
    totalRating = vratiSumuVrijednostiZvjezdica();
    numberOfRatings = vratiNmberOfRatings();

    // Ovdje možete izračunati prosjek ocjena ako vam je to potrebno
    if (numberOfRatings != 0) {
      return averageRating = totalRating / numberOfRatings;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = this.widget.korisnik?.email ?? '';

    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Your Email Subject',
        'body': 'Your email body'
      },
    );

    Uint8List bytes = base64.decode(this.widget.korisnik?.bajtoviSlike ?? '');

    return MasterScreenWidget(
      title:
          "Agent: ${this.widget.korisnik?.ime} ${this.widget.korisnik?.prezime}",
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: bytes.isNotEmpty
                            ? Image.memory(
                                bytes,
                                width: 300,
                                height: 300,
                                fit: BoxFit.contain,
                              )
                            : Container(),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            size: 24,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 7),
                          GestureDetector(
                            onTap: () => launch(_emailLaunchUri.toString()),
                            child: Text(
                              'Email: $email',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors
                                    .blue, // Change the color to blue for the link
                                decoration: TextDecoration
                                    .underline, // Underline the link
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: 24,
                            color: Colors.green,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Telefon: ${this.widget.korisnik?.telefon}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            20.0), // Dodatni padding sa lijeve i desne strane
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons
                                .home), // Dodajte ikonicu ovdje (ili odaberite odgovarajuću ikonicu)
                            SizedBox(
                                width:
                                    8), // Pravite razmak između ikonice i teksta
                            Text(
                              'Broj uspješno prodanih nekretnina: ${this.widget.korisnik?.brojUspjesnoProdanihNekretnina}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 8),
                            Text(
                              'Ukupni rejting: ${izracunajAverageRating()}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Iskustva kupaca:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final comment = data[index];
                                  final isUserComment = index % 2 == 0;
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 16),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${kupacUsername(comment.kupacId)}: ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .normal, // Stil za korisničko ime
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "${comment.sadrzaj}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .bold, // Stil za sadržaj poruke
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _sadrzajController,
                                        decoration: InputDecoration(
                                          hintText: 'Unesite komentar...',
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.send),
                                      color: Colors.blue,
                                      onPressed: () async {
                                        List<dynamic> filteredData = kupciData!
                                            .where((kupac) =>
                                                kupac.korisnickoIme == username)
                                            .toList();
                                        String iso8601Date =
                                            currentDate.toIso8601String();

                                        // Extract kupacId from the first item in filteredData
                                        int kupacId = filteredData.isNotEmpty
                                            ? filteredData[0].kupacId
                                            : 0; // You should adjust this default value as needed
                                        print("FILTERED ${kupciData}");
                                        print(
                                            "KUPAC KI ${kupciData[0].korisnickoIme}");
                                        print("KORISNIK KI ${username}");
                                        Map<String, dynamic> request = {
                                          'sadrzaj': _sadrzajController.text,
                                          'datum': iso8601Date,
                                          'korisnikId':
                                              this.widget.korisnik?.korisnikId,
                                          'kupacId':
                                              kupacId, // Use the extracted kupacId
                                        };

                                        var result =
                                            await _komentariAgentimaProvider
                                                .insert(request);

                                        await initForm();
                                        _sadrzajController.clear();
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      int newRating = index + 1;
                                      //totalRating += newRating;
                                      _recenzijaProvider
                                          ?.get(null)
                                          ?.then((tmpRecenzijeData) {
                                        List<dynamic> recenzije =
                                            tmpRecenzijeData ?? [];
                                        if (mounted) {
                                          setState(() {
                                            recenzijeData = recenzije;
                                          });
                                        }
                                      });

                                      totalRating =
                                          vratiSumuVrijednostiZvjezdica();
                                      numberOfRatings = vratiNmberOfRatings();
                                      userRating = newRating;

                                      updateAgentRating(newRating);

                                      // Ovdje možete izračunati prosjek ocjena ako vam je to potrebno
                                      if (numberOfRatings != 0) {
                                        averageRating =
                                            totalRating / numberOfRatings;
                                        print("Prosjek ocjena: $averageRating");
                                        print("Total rating ${totalRating}");
                                        print(
                                            "numberOfRatings ${numberOfRatings}");
                                      }
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AgentDetaljiScreen(
                                                  korisnik: widget.korisnik),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.star,
                                      color: index < userRating
                                          ? Colors.amber
                                          : Colors.grey,
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
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
}
