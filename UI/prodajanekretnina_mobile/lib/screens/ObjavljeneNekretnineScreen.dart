import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_mobile/screens/PrijaviProblemScreen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile/utils/util.dart';

class ObjavljeneNekretnineScreen extends StatefulWidget {
  static const String routeName = "/Nekretnina";
  const ObjavljeneNekretnineScreen({Key? key}) : super(key: key);

  @override
  State<ObjavljeneNekretnineScreen> createState() =>
      _ObjavljeneNekretnineScreenScreenState();
}

class CustomCard extends StatefulWidget {
  final Nekretnina? nekretnina;
  final List<Slika> slike;
  final BuildContext context;
  final int? nekretninaId;

  CustomCard({
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
  List<dynamic> korisniciData = [];
  late KorisniciProvider _korisniciProvider;

  String username = Authorization.username ?? "";

  @override
  void initState() {
    super.initState();
    _korisniciProvider = context.read<KorisniciProvider>();
    _pageController = PageController(initialPage: 0);

    initForm();
  }

  Future initForm() async {
    try {
      var tmpKorisniciData = await _korisniciProvider?.get(null);

      setState(() {
        korisniciData = tmpKorisniciData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    if (widget.nekretnina?.korisnikId == korisnikId()) {
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
              _buildImageSlider(), // Display the carousel slider

              ListTile(
                title: Text(
                  ' ${widget.nekretnina?.naziv ?? ""}',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    '${widget.nekretnina?.cijena ?? ""} BAM',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrijaviProblemScreen(
                        nekretnina: widget.nekretnina,
                      ),
                    ),
                  );
                },
                child: Text("Prijavi problem"),
              ),
            ],
          ),
        ),
      );
    } else {
      // Return an empty container or null if you don't want to show anything
      return Container();
    }
  }

  Widget _buildImageSlider() {
    List<Slika> slike = widget.slike
        .where((slika) => slika.nekretninaId == widget.nekretninaId)
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 200, // Set the height of the carousel
        viewportFraction: 1.0, // Display a single image at a time
        autoPlay: true, // Enable auto-play
        autoPlayInterval: Duration(seconds: 3), // Auto-play interval
      ),
      items: slike.map((slika) {
        return Image(
          image: MemoryImage(
            base64Decode(slika.bajtoviSlike ?? ''),
          ),
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
    );
  }
}

class _ObjavljeneNekretnineScreenScreenState
    extends State<ObjavljeneNekretnineScreen> {
  late NekretnineProvider _nekretnineProvider;
  SearchResult<Nekretnina>? result;
  TextEditingController _gradController = TextEditingController();

  List<Slika> slike = [];
  late SlikeProvider _slikeProvider;

  @override
  void initState() {
    super.initState();
    _nekretnineProvider = context.read<NekretnineProvider>();
    initForm();
  }

  Future initForm() async {
    try {
      var tmpData = await _nekretnineProvider?.get(null);

      setState(() {
        dataa = tmpData!;
      });
      /*var searchFilters = {
        'isOdobrena': true,
      };

      var tmpData = await _nekretnineProvider.get(searchFilters);
      setState(() {
        dataa = tmpData!;
      });*/
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  void _navigateToDetailsScreen(Nekretnina? nekretnina) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NekretnineDetaljiScreen(
          nekretnina: nekretnina,
        ),
      ),
    );
  }

  Future<List<Slika>> _getSlikeForNekretnina(int nekretninaId) async {
    _slikeProvider = SlikeProvider(); // Initialize SlikeProvider
    SearchResult<Slika> slikeResult = await _slikeProvider
        .get(filter: {'nekretninaId': nekretninaId.toString()});
    return slikeResult.result;
  }

  List<dynamic> dataa = [];
  Future<void> _performSearch() async {
    var searchFilters = {
      'isOdobrena': true,
      'grad': _gradController.text,
    };

    var tmpdataa = await _nekretnineProvider.get(searchFilters);
    setState(() {
      dataa = tmpdataa;
    });
    //_nekretnineProvider = context.read<NekretnineProvider>();

    /*var data = await _nekretnineProvider.get(filter: {
      'vlasnik': _vlasnikController.text,
      'grad': _gradController.text,
      'isOdobrena': true,
    });

    setState(() {
      result = data;
    });

    print("data: ${data.result[0].cijena}");*/
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Moje nekretnine",
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
              decoration: InputDecoration(labelText: "Grad"),
              controller: _gradController,
            ),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            child: Text("Pretraga"),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: dataa.length, //result?.result.length ?? 0,
        itemBuilder: (context, index) {
          if (index < dataa.length) {
            Nekretnina? nekretnina = dataa[index]; //result!.result[index];
            return FutureBuilder<List<Slika>>(
              future: _getSlikeForNekretnina(nekretnina!.nekretninaId ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error fetching images');
                } else if (!snapshot.hasData) {
                  return Text('No images found for this property');
                } else {
                  List<Slika> slike = snapshot.data!;
                  return GestureDetector(
                    onTap: () => _navigateToDetailsScreen(nekretnina),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomCard(
                            context: context,
                            nekretnina: nekretnina,
                            slike: slike,
                            nekretninaId: nekretnina.nekretninaId ?? -1,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return SizedBox(); // Prazan widget za slučaj van granica indeksa
          }
        },
      ),
    );
  }
}
