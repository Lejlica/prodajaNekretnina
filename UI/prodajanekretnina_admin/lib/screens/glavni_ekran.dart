import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/main.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_agenta_screen.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_detalji.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_lista_screen.dart';
import 'package:prodajanekretnina_admin/screens/rijeseni_problemi.dart';
import 'package:prodajanekretnina_admin/screens/vasProfil_screen.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_prodaju.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak_detalji.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_iznajmljivanje.dart';
import 'package:prodajanekretnina_admin/screens/prijavljeni_problemi.dart';
import 'package:prodajanekretnina_admin/screens/statistika_agent_screen.dart';
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
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_back), // Add the back arrow icon

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Nekretnine'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NekretnineListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Dodaj nekretninu'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NekretnineDetaljiScreen(),
                  ),
                );
              },
            ),
           /* ListTile(
              leading: Icon(Icons.add),
              title: Text('Dodaj agenta'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajAgentaScreen(),
                  ),
                );
              },
            ),*/
            ExpansionTile(
              leading: Icon(Icons.article),
              title: Text('Zahtjevi'),
              children: [
                ListTile(
                  title: Text('Zahtjevi za prodaju'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ZahtjeviZaProdajuDetaljiScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Zahtjevi za iznajmljivanje'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ZahtjeviZaIznajmljivanjeDetaljiScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Zahtjevi za obilazak'),
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
              leading: Icon(Icons.article),
              title: Text('Problemi'),
              children: [
                ListTile(
                  title: Text('Prijavljeni problemi'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PrijavljeniProblemiScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Riješeni problemi'),
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
              title: Text('Statistika'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SalesStatisticssScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Izvještaj o prodaji'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 24.0,
                color: Colors.blue,
              ),
              title: Text('Vaš profil'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VasProfilScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Lista agenata'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaAgenataScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // body: widget.child!,
    );
  }
}
