import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipNekr_provider.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/screens/PaymentScreen.dart';
import 'package:prodajanekretnina_mobile/screens/makePayment.dart';
import 'package:prodajanekretnina_mobile/screens/UnesiClientPaypalPodatkeScreen.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/util.dart';

class NekretnineListScreen extends StatefulWidget {
  static const String routeName = "/Nekretnina";
  const NekretnineListScreen({Key? key}) : super(key: key);

  @override
  State<NekretnineListScreen> createState() => _NekretnineListScreenState();
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
  List<dynamic> data = [];
  late KupciProvider _kupciProvider;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _kupciProvider = context.read<KupciProvider>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => makePayment(),
                  ),
                );
              },
              child: Text("Kupi"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Postavite ovde željenu boju
              ),
            ),
          ],
        ),
      ),
    );
  }

  String username = Authorization.username ?? "";
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

class _NekretnineListScreenState extends State<NekretnineListScreen> {
  late NekretnineProvider _nekretnineProvider;
  SearchResult<Nekretnina>? result;
  TextEditingController _gradController = TextEditingController();
  TextEditingController _tipNekretnineController = TextEditingController();
  TextEditingController _kvadraturaController = TextEditingController();
  TextEditingController _cijenaOdController = TextEditingController();
  TextEditingController _cijenaDoController = TextEditingController();
  SearchResult<TipNekretnine>? tipNekretnineResult;
  List<Slika> slike = [];
  late SlikeProvider _slikeProvider;
  late TipoviNekretninaProvider _tipNekretnineProvider;
  late int selectedPropertyTypeId;
  late TipNekretninaProvider _tipNekProvider;

  @override
  void initState() {
    super.initState();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _tipNekretnineProvider = context.read<TipoviNekretninaProvider>();
    _tipNekProvider = context.read<TipNekretninaProvider>();
    initForm();

    selectedPropertyTypeId = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      // Ponovo postavite podatke
      initForm();
    });
  }

  List<dynamic> tipNekrData = [];
  Future initForm() async {
    print("Pozivam initForm");
    try {
      var tmpData = await _nekretnineProvider?.get(null);
      var tmpTipNekrData = await _tipNekProvider?.get(null);
      tipNekretnineResult = await _tipNekretnineProvider.get();
      print("Tipovi nekretnina: ${tipNekretnineResult?.result}");

      setState(() {
        dataa = tmpData!;
        tipNekrData = tmpTipNekrData!;
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
    print("initForm završen");
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
      if (selectedPropertyTypeId != null)
        'tipNekretnineId': selectedPropertyTypeId,
      if (_gradController.text.isNotEmpty) 'grad': _gradController.text,
      if (_kvadraturaController.text.isNotEmpty)
        'kvadratura': int.parse(_kvadraturaController.text),
      if (_cijenaOdController.text.isNotEmpty)
        'CijenaOd': int.parse(_cijenaOdController.text),
      if (_cijenaDoController.text.isNotEmpty)
        'CijenaDo': int.parse(_cijenaDoController.text),
    };

    print("selectedPropertyTypeId ${selectedPropertyTypeId}");
    print("grad ${_gradController.text}");
    print(searchFilters['kvadratura']);

    var tmpdataa = await _nekretnineProvider.get(searchFilters);
    setState(() {
      dataa = tmpdataa;
    });
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

  String selectedTipNekretnineName = '';
  Widget _buildSearch() {
    //_tipNekretnineProvider = context.read<TipoviNekretninaProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  hint: Text("Odaberite tip nekretnine"),
                  items: /*tipNekretnineResult?.result.map((tipNekretnine) {
                    return DropdownMenuItem<int>(
                      key: Key(tipNekretnine.tipNekretnineId?.toString() ?? ''),
                      value: tipNekretnine.tipNekretnineId ?? 7,
                      child: Text(tipNekretnine.nazivTipa ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPropertyTypeId =
                          value ?? 7; // Ako je value null, postavi na -1
                    });
                  },*/
                      tipNekrData?.map((tip) {
                    return DropdownMenuItem<int>(
                      value: tip.tipNekretnineId,
                      child: Text(tip.nazivTipa ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print("Selected value: $value");
                    setState(() {
                      selectedPropertyTypeId = value ?? -1;
                    });
                  },

                  /* selectedItemBuilder: (BuildContext context) {
                    return (tipNekretnineResult?.result ?? [])
                        .map<Widget>((tipNekretnine) {
                      return Text(tipNekretnine.nazivTipa ?? '');
                    }).toList();
                  },*/
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Grad"),
                  controller: _gradController,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Kvadratura"),
                  controller: _kvadraturaController,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Cijena od"),
                  controller: _cijenaOdController,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Cijena do"),
                  controller: _cijenaDoController,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: _performSearch,
            child: Text("Pretraga"),
          ),
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
