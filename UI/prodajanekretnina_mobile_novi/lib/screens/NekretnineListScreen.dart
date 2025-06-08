import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipNekr_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/PayPalPaymentScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
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
  final Uint8List? slikaBajtovi;

  CustomCard({
    required this.context,
    required this.nekretnina,
    required this.slike,
    required this.nekretninaId,
    required this.slikaBajtovi
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late PageController _pageController;
  List<dynamic> data = [];
  late KorisniciProvider _korisniciProvider;
  late KupciProvider _kupciProvider;

  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _korisniciProvider = context.read<KorisniciProvider>();
    _kupciProvider = context.read<KupciProvider>();
    
    initForm();
    
    
  }
Future initForm() async {
  try {
    var tmpKorisniciData = await _korisniciProvider.get({});
    var tmpKupciData = await _kupciProvider.get({});

    setState(() {
      data = tmpKorisniciData!;
      
    });

    String? username = Authorization.username;
    if (username != null) {
      ispisiKorisnika(username);
    }
  } catch (e) {
    print('Error in initForm: $e');
  }
}


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void ispisiKorisnika(String username) {
  var korisnik = pronadjiKorisnika(username);
  if (korisnik != null) {
    print("KorisnikId: ${korisnik.korisnikId}");
    print("Ime: ${korisnik.ime}");
  } else {
    print("Korisnik sa korisnickim imenom '$username' nije pronađen.");
  }
}

String? username = Authorization.username;

Korisnik? pronadjiKorisnika(String username) {
  List<dynamic> filteredData =
      data!.where((korisnik) => korisnik.korisnickoIme == username).toList();

  if (filteredData.isNotEmpty) {
    print("Korisnik sa korisnickim imenom '$username' se logirao."); 
    return filteredData[0];
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
  margin: EdgeInsets.all(12),
  elevation: 6,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ClipRRect(
  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
  child: widget.slikaBajtovi != null
      ? Image.memory(
          widget.slikaBajtovi!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image));
          },
        )
      : Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.image, size: 60, color: Colors.grey),
          ),
        ),
),


      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget!.nekretnina!.nekretninaId != null
                    ? 'ID: ${widget!.nekretnina!.nekretninaId}'
                    : 'Nema ID',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                formatCijena(widget!.nekretnina!.cijena!),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                
                children: [
                
                  Text('Kvadratura: ${widget!.nekretnina!.kvadratura} m²'),
                  SizedBox(width: 20),
                  Text('Sobe: ${widget!.nekretnina!.brojSoba}'),
                  SizedBox(width: 20),
                  Icon(
                    widget!.nekretnina!.namjesten! ? Icons.chair : Icons.block,
                    color: widget!.nekretnina!.namjesten! ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  const Text('Namjesten'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    widget!.nekretnina!.novogradnja! ? Icons.check_circle : Icons.cancel,
                    color: widget!.nekretnina!.novogradnja! ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  const Text('Novogradnja'),
                  const SizedBox(width: 16),
                  Icon(
                    widget!.nekretnina!.parkingMjesto! ? Icons.local_parking : Icons.block,
                    color: widget!.nekretnina!.parkingMjesto! ? Colors.green : Colors.red,
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
                  backgroundColor: const Color.fromARGB(255, 42, 163, 219),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                onPressed: data == null ? null : () {
    var korisnik = pronadjiKorisnika(username!);
    if (korisnik == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Korisnik nije pronađen!')),
      );
      return;
    } else {
    print('Korisnik je u buttonu: ${korisnik.ime}');
  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayPalPaymentScreen(
                       korisnik: korisnik,
                      
                       price: widget.nekretnina!.cijena!,
                      nekretnina: widget!.nekretnina!,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart_checkout, color: Color.fromARGB(255, 255, 255, 255), size: 22),
    SizedBox(width: 8),
    Text(
      "Kupi koristeći PayPal",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 255, 255, 255),
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
),

    );
  }

  Widget _buildImageSlider() {
    List<Slika> slike = widget.slike
        .where((slika) => slika.nekretninaId == widget.nekretninaId)
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 200, 
        viewportFraction: 1.0,
        autoPlay: true, 
        autoPlayInterval: Duration(seconds: 3),
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
  late TipNekretninaProvider _tipNekretnineProvider;
  late int selectedPropertyTypeId;
  late TipNekretninaProvider _tipNekProvider;
  Map<int, Uint8List?> slikeMap = {};
bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _tipNekretnineProvider = context.read<TipNekretninaProvider>();
    _tipNekProvider = context.read<TipNekretninaProvider>();
    _slikeProvider = context.read<SlikeProvider>();
    initForm();
loadNekretnine();
    selectedPropertyTypeId = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
    
      initForm();
    });
  }

  List<dynamic> tipNekrData = [];
  Future initForm() async {
    print("Pozivam initForm");
    try {
      var tmpData = await _nekretnineProvider?.get(null);
      var tmpTipNekrData = await _tipNekProvider?.get(null);
      
      print("Tipovi nekretnina: ${tipNekretnineResult?.result}");

      setState(() {
        dataa = tmpData!;
        tipNekrData = tmpTipNekrData!;
      });
    
    } catch (e) {
      print('Error in initForm: $e');
    }
    print("initForm završen");
  }
Future<void> loadNekretnine() async {
  setState(() {
    isLoading = true;
  });

  try {
    final nekretnineProvider = Provider.of<NekretnineProvider>(context, listen: false);
  
    _slikeProvider = context.read<SlikeProvider>();

    final allNekretnine = await nekretnineProvider.get({});
    

    

    
    slikeMap.clear();

    for (var nekretnina in allNekretnine) {
      var slikeResult = await _slikeProvider.get(
        filter: {'nekretninaId': nekretnina.nekretninaId.toString()},
      );

      if (slikeResult.result.isNotEmpty && slikeResult.result.first.bajtoviSlike != null) {
        slikeMap[nekretnina.nekretninaId!] = base64Decode(slikeResult.result.first.bajtoviSlike!);
      } else {
        slikeMap[nekretnina.nekretninaId!] = null;
      }
    }

    setState(() {
     
      isLoading = false;
    });

  } catch (e) {
    print('Greška prilikom učitavanja nekretnina: $e');
    setState(() {
      isLoading = false;
    });
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
      'tipNekretnineId': selectedPropertyTypeId ?? 0,
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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tip nekretnine
        DropdownButtonFormField<int>(
          decoration: InputDecoration(
            labelText: "Tip nekretnine",
            prefixIcon: Icon(Icons.home_work_outlined, color: Colors.deepPurple),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          hint: Text("Odaberite tip nekretnine"),
          items: tipNekrData?.map((tip) {
            return DropdownMenuItem<int>(
              value: tip.tipNekretnineId,
              child: Text(tip.nazivTipa ?? ''),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedPropertyTypeId = value ?? -1;
            });
          },
        ),
        SizedBox(height: 16),

        // Grad & Kvadratura
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _gradController,
                decoration: InputDecoration(
                  labelText: "Grad",
                  prefixIcon: Icon(Icons.location_city, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _kvadraturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Kvadratura (m²)",
                  prefixIcon: Icon(Icons.square_foot, color: Colors.green),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

      
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _cijenaOdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cijena od",
                  prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _cijenaDoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cijena do",
                  prefixIcon: Icon(Icons.money_off_csred_rounded, color: Colors.redAccent),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Dugme za pretragu
        ElevatedButton.icon(
          onPressed: _performSearch,
          icon: Icon(Icons.search, color: Colors.white),
          label: Text(
  "Pretraga",
  style: TextStyle(color: Colors.white), // ili bilo koja druga boja
),

          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}


Widget _buildDataListView() {
  return Expanded(
    child: ListView.builder(
      itemCount: dataa.length,
      itemBuilder: (context, index) {
        final nekretnina = dataa[index];
        final Uint8List? slikaBajtovi = slikeMap[nekretnina.nekretninaId!];

        return CustomCard(
          context: context,
          nekretnina: nekretnina,
          slike: [], 
          nekretninaId: nekretnina.nekretninaId!,
          slikaBajtovi: slikaBajtovi,
        );
      },
    ),
  );
}


}
