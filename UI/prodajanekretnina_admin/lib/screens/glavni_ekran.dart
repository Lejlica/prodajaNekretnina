import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/main.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_agenta_screen.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_nekr2.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_uredi_nekretninu.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_detalji.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_lista_screen.dart';
import 'package:prodajanekretnina_admin/screens/rijeseni_problemi.dart';
import 'package:prodajanekretnina_admin/screens/vasProfil_screen.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_prodaju.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak_detalji.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak.dart';
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
              leading: const Icon(Icons.arrow_back), // Add the back arrow icon

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Nekretnine'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NekretnineListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Dodaj nekretninu'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajNekr2Screen(),
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
              leading: const Icon(Icons.article),
              title: const Text('Zahtjevi'),
              children: [
                ListTile(
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
                  title: const Text('Zahtjevi za iznajmljivanje'),
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
              leading: const Icon(Icons.article),
              title: const Text('Problemi'),
              children: [
                ListTile(
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
              title: const Text('Izvještaj o prodaji'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 24.0,
                color: Colors.blue,
              ),
              title: const Text('Vaš profil'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VasProfilScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Lista agenata'),
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
