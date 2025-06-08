import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../utils/util.dart';


class ViseONekretniniScreen extends StatefulWidget {
  final Nekretnina nekretnina;

  const ViseONekretniniScreen({Key? key, required this.nekretnina}) : super(key: key);

  @override
  _ViseONekretniniScreenState createState() => _ViseONekretniniScreenState();
}

class _ViseONekretniniScreenState extends State<ViseONekretniniScreen> {
  late LokacijeProvider _lokacijeProvider;
  late NekretnineProvider _nekretnineProvider;
  late ObilazakProvider _obilazakProvider;
 
  SearchResult<Lokacija>? lokacijeResult;

  late GradoviProvider _gradoviProvider;
  SearchResult<Grad>? gradoviResult;
  SearchResult<Obilazak>? obilazakResult;
 SearchResult<Nekretnina>? nekretnineResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
 
    _lokacijeProvider = context.read<LokacijeProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
_obilazakProvider = context.read<ObilazakProvider>();
    
    initForm();
  }

  Future<void> initForm() async {
    try {
      lokacijeResult = await _lokacijeProvider.get();
      gradoviResult = await _gradoviProvider.get();
nekretnineResult = await _nekretnineProvider.get();
obilazakResult = await _obilazakProvider.get();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Greška u initForm: $e");
    }
  }

  // Sada možeš koristiti widget.nekretnina za pristup nekretnini

 

  
 Widget _infoItem(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalji o nekretnini'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(children: [
            const SizedBox(height: 16),
            Text(
              'Naziv nekretnine: ${widget.nekretnina.naziv}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
              color: const Color.fromARGB(255, 246, 244, 244),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FutureBuilder<SearchResult<Slika>>(
                            future: SlikeProvider().get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                SearchResult<Slika>? slike = snapshot.data;

                                if (slike != null &&
                                    slike.result.isNotEmpty) {
                               
                                  List<String> imageUrls = slike.result
                                      .where((slika) =>
                                          slika.nekretninaId ==
                                          widget.nekretnina.nekretninaId)
                                      .map((slika) => slika.bajtoviSlike ?? "")
                                      .toList();

                                  
                                  if (imageUrls.isNotEmpty) {
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                        height:
                                            200.0,
                                        autoPlay:
                                            true, 
                                        enlargeCenterPage: true,
                                        viewportFraction:
                                            0.5, 
                                        aspectRatio: 16 / 9,
                                      ),
                                      items: imageUrls.map((imageUrl) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return AspectRatio(
                                              aspectRatio: 16 /
                                                  9, 
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                                child: imageFromBase64String(
                                                    imageUrl),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    );
                                  } else {
                                    return const Text('Nema slika');
                                  }
                                } else {
                                  return const Text('Nema slika');
                                }
                              } else if (snapshot.hasError) {
                                return const Text(
                                    'Greška prilikom dobavljanja slika');
                              } else {
                                return const Text('Nema slika');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.nekretnina.cijena ?? ""} BAM',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 25),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .local_hotel, 
                                color: Colors.blue, 
                              ),
                              const SizedBox(
                                  width:
                                      8), 
                              Text(
                                'Sobe ${widget.nekretnina.brojSoba ?? ""} ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.nekretnina.parkingMjesto == true
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
                                          color: Colors.black, fontSize: 11),
                                    ),
                                  ],
                                )
                              : const SizedBox
                                  .shrink(), 
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.stairs, 
                                color: Colors.blue, 
                              ),
                              const SizedBox(
                                  width:
                                      8), 
                              Text(
                                'Sprat ${widget.nekretnina.sprat ?? ""} ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .crop_square, 
                                color: Colors.blue, 
                              ),
                              const SizedBox(
                                  width:
                                      8),
                              Text(
                                'Kvadratura ${widget.nekretnina.kvadratura ?? ""} ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.nekretnina.novogradnja == true
                              ? const Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Novogradnja',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 11),
                                    ),
                                  ],
                                )
                              : const SizedBox
                                  .shrink(), 
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  elevation: 4,
  margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
  color: const Color.fromARGB(255, 255, 255, 255),
  child: Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT COLUMN - PROPERTY INFO
            Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Text(
          '📄 Informacije o nekretnini',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
      ),
      _infoItem(Icons.numbers, 'Rb. nekretnine', '${widget.nekretnina.nekretninaId}'),
      _infoItem(Icons.calendar_today, 'Datum dodavanja', _formatDate(widget.nekretnina.datumDodavanja)),
      _infoItem(Icons.edit_calendar, 'Datum izmjene', _formatDate(widget.nekretnina.datumIzmjene)),
      const SizedBox(height: 8),
      

    ],
  ),
)
,
            const SizedBox(width: 40),

           
            Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Text(
          '📄 Dodatne informacije',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
      ),
      _infoItem(Icons.meeting_room, 'Broj soba', '${widget.nekretnina.brojSoba}'),
      _infoItem(Icons.bed, 'Broj spavaćih soba', '${widget.nekretnina.brojSpavacihSoba}'),
      _infoItem(Icons.description, 'Broj ugovora', '${widget.nekretnina.brojUgovora}'),
      const SizedBox(height: 12),
    ],
  ),
),

          ],
        ),
        SizedBox(height: 30),
        Row(
  mainAxisAlignment: MainAxisAlignment.center, 
  children: [
    const Icon(Icons.verified, size: 20, color: Colors.grey),
    const SizedBox(width: 8),
    const Text(
      'Status:',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    const SizedBox(width: 8),
    Icon(
      widget.nekretnina.isOdobrena == true
          ? Icons.check_circle
          : Icons.access_time_filled,
      color: widget.nekretnina.isOdobrena == true ? Colors.green : Colors.orange,
      size: 22,
    ),
    const SizedBox(width: 6),
    Text(
      widget.nekretnina.isOdobrena == true ? 'Odobreno' : 'Na čekanju',
      style: TextStyle(
        color: widget.nekretnina.isOdobrena == true ? Colors.green : Colors.orange,
        fontWeight: FontWeight.w600,
      ),
    ),
    
  ],
),
      ],
    ),
  ),
  
),

            Visibility(
                visible: widget.nekretnina.isOdobrena == null ||
                    widget.nekretnina.isOdobrena ==
                        false, 
                child: Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  elevation: 4,
  margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
  color: const Color.fromARGB(255, 255, 255, 255),
  child: Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person_add, color: Colors.blueAccent),
            const SizedBox(width: 8),
            const Text(
              'Dodajte agenta za nekretninu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        const SizedBox(height: 24),
        Divider(),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green),
            const SizedBox(width: 8),
            const Text(
              'Odobri nekretninu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
      ],
    ),
  ),
),

            )]),
        )));
  }
Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; 
    }

    DateTime date = DateTime.parse(dateString); 
    return DateFormat('dd.MM.yyyy.').format(date);
  }
 
}
