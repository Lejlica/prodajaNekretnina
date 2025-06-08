import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/korisnici_uloge.dart';
import 'package:prodajanekretnina_admin/screens/assigned_proptoagent.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/main.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_uloge_provider.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_nekr2.dart';
import '../utils/util.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_lista_screen.dart';
import 'package:prodajanekretnina_admin/screens/rijeseni_problemi.dart';
import 'package:prodajanekretnina_admin/screens/vasProfil_screen.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_prodaju.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak_detalji.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_iznajmljivanje.dart';
import 'package:prodajanekretnina_admin/screens/prijavljeni_problemi.dart';
import 'package:prodajanekretnina_admin/screens/statistika2.dart';
import 'package:prodajanekretnina_admin/screens/izvjestajProdaja_screen.dart';
import 'package:prodajanekretnina_admin/screens/lista_agenata_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreenWidget({this.child, this.title, Key? key}) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidget();
}

class _MasterScreenWidget extends State<MasterScreenWidget> {
  late KorisniciUlogeProvider _korisniciUlogeProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
         SliverAppBar(
              title: Text(widget.title ?? ""),
              floating: false,
              pinned: true,
            ),



          ];
        },
        body: widget.child!,
      ),
      drawer: Drawer(
  child: Column(
    children: [
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFBFA06B),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.account_circle, size: 64, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Dobrodošli!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Vaša real estate aplikacija',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black87),
              title: const Text('Nekretnine'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NekretnineListScreen(),
                  ),
                );
              },
            ),
            
            Visibility(
  visible: ulogaId == 1,
  child: ListTile(
    leading: const Icon(Icons.add_home, color: Colors.black87),
    title: const Text('Dodaj nekretninu'),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NekretnineDetaljiScreen(),
        ),
      );
    },
  ),
),

            ExpansionTile(
              leading: const Icon(Icons.article, color: Colors.black87),
              title: const Text('Zahtjevi'),
              children: [
                ListTile(
                  leading: const Icon(Icons.sell_outlined),
                  title: const Text('Zahtjevi za prodaju'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ZahtjeviZaProdajuDetaljiScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home_work_outlined),
                  title: const Text('Zahtjevi za iznajmljivanje'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ZahtjeviZaIznajmljivanjeDetaljiScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.visibility_outlined),
                  title: const Text('Zahtjevi za obilazak'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ZahtjeviZaObilazakDetaljiScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.report_problem_outlined, color: Colors.black87),
              title: const Text('Problemi'),
              children: [
                ListTile(
                  leading: const Icon(Icons.bug_report_outlined),
                  title: const Text('Prijavljeni problemi'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PrijavljeniProblemiScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: const Text('Riješeni problemi'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RijeseniProblemiScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart, color: Colors.black87),
              title: const Text('Statistika'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SalesStatisticssScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_chart_outlined, color: Colors.black87),
              title: const Text('Izvještaj o prodaji'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
            Visibility(
  visible: ulogaId == 1,
  child: ListTile(
    leading: const Icon(Icons.people, color: Colors.black87),
    title: const Text('Lista agenata'),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ListaAgenataScreen(),
        ),
      );
    },
  ),
),
Visibility(
  visible: ulogaId == 2,
  child:ListTile(
    leading: const Icon(Icons.people, color: Colors.black87),
    title: const Text('Dodijeljene nekretnine'),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AssignedPropertiesScreen(),
        ),
      );
    },
  ),),
          ],
        ),
      ),
      const Divider(),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFBFA06B),
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text('$ime $prezime', style: TextStyle(fontWeight: FontWeight.bold)),

                  Text('$email', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.blue),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VasProfilScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              onPressed: () {
                
 
    Authorization.username = '';
    Authorization.password = '';

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  


              },
            ),
          ],
        ),
      )
    ],
  ),
)
      // body: widget.child!,
    );
    
  }
  late KorisniciProvider _korisniciProvider;
  @override
  void initState() {
    super.initState();
    // _kupciProvider = context.read<KupciProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciUlogeProvider=context.read<KorisniciUlogeProvider>();
    initForm();
  }
  late SearchResult<Korisnik> data;
  late SearchResult<KorisniciUloge> korisniciUlogedata;
   Future initForm() async {
    try {
      
      var tmpKorisniciData = await _korisniciProvider.get();
      var tmpKorisniciUlogeData = await _korisniciUlogeProvider.get();

      //var tmpKupciData = await _kupciProvider?.get(null);
      setState(() {
      
        data = tmpKorisniciData!;
        korisniciUlogedata = tmpKorisniciUlogeData!;
      });
      korisnikk();
      pronadjiUloguLogiranogUsera();
    } catch (e) {
      print('Error in initForm: $e');
    }
  }
  String username = Authorization.username ?? "";
  String ime='';
  String prezime='';
  String email='';
  int id=0;
  Korisnik? korisnikk() {
    print('Username: $username');
    print('datica: $data');
    List<dynamic> filteredData = data.result.where((korisnik) {
      print('KorisnickoIme: ${korisnik.korisnickoIme}');
      return korisnik.korisnickoIme == username;
    }).toList();
ime = filteredData[0].ime;
prezime = filteredData[0].prezime;
email = filteredData[0].email;
id=filteredData[0].korisnikId;
   
print('ime: $ime');
    if (filteredData.isNotEmpty) {
      return filteredData[0];
    } else {
      return null;
    }
  }

  int ulogaId = 0;
  int pronadjiUloguLogiranogUsera() {
   
    List<dynamic> filteredData = korisniciUlogedata.result.where((korisnikUloga) {
      print('KorisnikId: ${korisnikUloga.korisnikId}');
      return korisnikUloga.korisnikId == id;
    }).toList();
    if (filteredData.isNotEmpty) {
      ulogaId = filteredData[0].ulogaId!;
      print('UlogaId: $ulogaId');
      return ulogaId;
    } else {
      return 0;
    }
  }

}
