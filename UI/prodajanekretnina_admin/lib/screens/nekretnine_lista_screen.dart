import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/tipAkcije.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_nekr2.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_detalji.dart';
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

  late GradoviProvider _gradoviProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late TipAkcijeProvider _tipAkcijeProvider;
  SearchResult<Grad>? gradoviResult;
  SearchResult<NekretninaTipAkcije>? nekretninaTipAkcijeResult;
  SearchResult<TipAkcije>? tipAkcijeResult;

  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
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
            builder: (context) => NekretnineDetaljiScreen(
              nekretnina: widget.nekretnina,
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
  Map<int, List<Slika>> slikeMap = {};
  List<Slika> slike = [];

  void _navigateToDetailsScreen(Nekretnina? nekretnina) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NekretnineDetaljiScreen(
          nekretnina: nekretnina,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nekretnineProvider = context.read<NekretnineProvider>();
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Vlasnik"),
              controller: _vlasnikController,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Grad"),
              controller: _gradController,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                print("login proceed");
                var data = await _nekretnineProvider.get(filter: {
                  'vlasnik': _vlasnikController.text,
                  'grad': _gradController.text,
                  'isOdobrena': true,
                });

                setState(() {
                  result = data;
                });

                print("data: ${data.result[0].cijena}");
              },
              child: const Text("Pretraga")),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DodajNekr2Screen(nekretnina: null),
                  ),
                );
              },
              child: const Text("Dodaj"))
        ],
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
              nekretnina?.nekretninaId, // Use the null-aware operator here
        ),
      ),
    );
  }
}