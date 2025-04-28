import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile/main.dart';
import 'package:prodajanekretnina_mobile/utils/util.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineDetaljiScreen.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineListScreen.dart';
import 'package:prodajanekretnina_mobile/screens/VasProfilScreen.dart';
import 'package:prodajanekretnina_mobile/screens/WishListaScreen.dart';
import 'package:prodajanekretnina_mobile/screens/DodajNekretninuScreen.dart';
import 'package:prodajanekretnina_mobile/screens/ZakazaniObilasciScreen.dart';
import 'package:prodajanekretnina_mobile/screens/PrijavljeniProblemiScreen.dart';
import 'package:prodajanekretnina_mobile/screens/ObjavljeneNekretnineScreen.dart';
import 'package:prodajanekretnina_mobile/screens/RegistracijaScreen.dart';
import 'package:prodajanekretnina_mobile/screens/makePayment.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreenWidget({this.child, this.title, Key? key}) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidget();
}

String username = Authorization.username ?? "";

class _MasterScreenWidget extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? "",
          style: TextStyle(fontSize: 20), // Adjust the font size as needed
        ),
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
                    builder: (context) => DodajNekretninuScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Zakazani obilasci'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ZakazaniObilasciScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Lista želja'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WishListaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('Moje nekretnine'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ObjavljeneNekretnineScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.report,
                size: 30,
                color: Colors.red,
              ),
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
              leading: Icon(
                Icons.person,
                size: 30,
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
              leading: Icon(
                Icons.person,
                size: 30,
                color: Colors.blue,
              ),
              title: Text('Plati'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => makePayment(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: widget.child!,
    );
  }
}
