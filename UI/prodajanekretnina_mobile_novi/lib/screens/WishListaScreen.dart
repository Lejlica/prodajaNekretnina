import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

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
   late SlikeProvider _slikeProvider;
  bool isLoading = true;

  List<dynamic> data = [];
  List<dynamic> korisniciData = [];
  List<dynamic> nekretnineData = [];
  List<dynamic> lokacijeData = [];
  List<dynamic> gradoviData = [];
  List<Nekretnina> preporuceneNekretnine = [];
   List<dynamic> slikeData = [];

  String username = Authorization.username ?? "";
  int userRating = 0;

  @override
void initState() {
  super.initState();

  _korisniciProvider = context.read<KorisniciProvider>();
  _korisnikNekretninaWishProvider = context.read<KorisnikNekretninaWishProvider>();
  _nekretnineProvider = context.read<NekretnineProvider>();
  _lokacijeProvider = context.read<LokacijeProvider>();
  _gradoviProvider = context.read<GradoviProvider>();

  _slikeProvider = context.read<SlikeProvider>(); // ✅ OVO DODAJ

  loadSlike();
  initForm();
}


  Future initForm() async {
    try {
      var tmpData = await _korisnikNekretninaWishProvider?.get(null);
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpNekretnineData = await _nekretnineProvider?.get(null);
      var tmpLokacijeData = await _lokacijeProvider?.get(null);
      var tmpGradoviData = await _gradoviProvider?.get(null);
      var slikeData = await _slikeProvider?.get();
     
     
     
      
      setState(() {
        data = tmpData!;
        korisniciData = tmpKorisniciData!;
        nekretnineData = tmpNekretnineData!;
        lokacijeData = tmpLokacijeData!;
        gradoviData = tmpGradoviData!;
        slikeData = slikeData!;
        
      
      });
       final userId=korisnikId()!;
      print("korisnikKora: $userId");
      fetchPreporuke(userId);
      print("Preporučene nekretnine: $preporuceneNekretnine");
    } catch (e) {
      print('Error in initForm: $e');
    }
  }
  Future<void> loadSlike() async {
  try {
    final slikeResult = await SlikeProvider().get();
    setState(() {
      slikeData = slikeResult.result;
      isLoading = false;
    });
  } catch (e) {
    print('Greška pri dohvatu slika: $e');
    setState(() {
      isLoading = false;
    });
  }
}
  Future<void> fetchPreporuke(int userId) async {
  try {
   
    final preporuke = await _nekretnineProvider.recommend(userId);
   

    setState(() {
      isLoading = false;
      preporuceneNekretnine = preporuke;
    });
  } catch (e) {
    print("Greška pri dohvatu preporuka: $e");
  }
}

int kora=0;
  int? korisnikId() {
    List<dynamic> filteredData = korisniciData!
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();

    if (filteredData.isNotEmpty) {
      kora=filteredData[0].korisnikId;
     
      print("korisnikIde: $kora"); 
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


  
  Widget buildPreporuceneWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Preporučeno za vas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: preporuceneNekretnine.length,
          itemBuilder: (context, index) {
            final nekretnina = preporuceneNekretnine[index];

        
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NekretnineDetaljiScreen(
                      nekretnina: nekretnina,
                    ),
                  ),
                );
              },
              child: Container(
  width: 180,
  height: 250,
  margin: const EdgeInsets.symmetric(horizontal: 10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: const Color.fromARGB(255, 228, 198, 198),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 6,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     
      Container(
        height: 100,
        child: Builder(
          builder: (context) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final slikeZaNekretninu = slikeData
                .where((slika) =>
                    slika.nekretninaId == nekretnina.nekretninaId)
                .toList();

            if (slikeZaNekretninu.isEmpty) {
              return const Center(child: Text('Nema slika'));
            }

            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.memory(
                base64Decode(slikeZaNekretninu.first.bajtoviSlike ?? ''),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),

    
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nekretnina.naziv ?? 'Nekretnina',
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2),
            Text(
              '${nekretnina.cijena?.toStringAsFixed(2)} BAM',
              style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.king_bed, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text('${nekretnina.brojSoba}'),
                SizedBox(width: 10),
                Icon(Icons.square_foot, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text('${nekretnina.kvadratura} m²'),
                SizedBox(width: 10),
               Icon(Icons.local_parking, size: 14,color: Colors.grey),
    SizedBox(width: 4),
    Icon(
      nekretnina.parkingMjesto == true
          ? Icons.check_circle
          : Icons.cancel, 
      color: nekretnina.parkingMjesto == true
          ? Colors.green
          : Colors.red,
      size: 14,
    ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
),


            );
          },
        ),
       
      ),
       SizedBox(height: 16),
    ],
  );
}

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
    
    List<Widget> obilasciWidgets = [];
 if (data.isEmpty) {
    obilasciWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.info_outline, size: 60, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Nemate nijednu nekretninu na listi želja.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
    return obilasciWidgets;
  }
   
    double fontSize = 18.0; 

    for (var obilazak in data) {
 
      if (obilazak.korisnikId == korisnikId()) {
        obilasciWidgets.add(
          GestureDetector(
            onTap: () {
           
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NekretnineDetaljiScreen(
                    nekretnina: nekretninaOdabrana(obilazak.nekretninaId),
                  ),
                ),
              );
            },
            child: Card(
  elevation: 4,
  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
            Icon(Icons.home, color: Colors.deepPurple),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                nazivNekretnine(obilazak.nekretninaId) ?? 'Nepoznata nekretnina',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Lokacija
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.redAccent),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                lokacijaNekretnine(obilazak.nekretninaId)?? 'Nepoznata lokacija',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

       
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        var result = await _korisnikNekretninaWishProvider
                            .delete(obilazak.korisnikNekretninaWishId);

                       
                        if (result) {
                         
                          print('Obilazak uspješno otkazan.');
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => WishListaScreen(),
                            ),
                          );

                         
                          await initForm();
                          setState(() {});
                        } else {
                          
                          print('Otkazivanje nije uspjelo obilazak.');
                        }
                      } catch (e) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => WishListaScreen(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Uspješno ste uklonili nekretninu iz vaše liste želja!',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
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

                         
                       
                        print(
                            'Error canceling obilazak: $e obilazakId ${obilazak.korisnikNekretninaWishId}');
                      }
                    },
                    icon: Icon(Icons.favorite_border),
  label: Text("Ukloni iz liste želja"),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),


        ),
    ),],
    ),
  ),
)

          ),
        );
      }
    }

    return obilasciWidgets;
  }

 @override
Widget build(BuildContext context) {
  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }
  return MasterScreenWidget(
    title: "Vaša lista želja",
    child: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              if (preporuceneNekretnine.isNotEmpty) buildPreporuceneWidget(),
              ...buildObilasciWidgets(),
            ],
          ),
        ),
      ],
    ),
  );
}

}
