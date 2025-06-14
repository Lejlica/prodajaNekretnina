import 'package:flutter/material.dart';
import 'package:prodajanekretnina_mobile_novi/main.dart';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';
import 'package:prodajanekretnina_mobile_novi/screens/NekretnineListScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/VasProfilScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/WishListaScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/DodajNekretninuScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/ZakazaniObilasciScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/PrijavljeniProblemiScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/ObjavljeneNekretnineScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/statistika2.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  final bool showDrawer;
  MasterScreenWidget({this.child, this.title,this.showDrawer = true, Key? key}) : super(key: key);

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
        automaticallyImplyLeading: widget.showDrawer,
      ),
      drawer: widget.showDrawer ? Drawer(
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
         Color.fromRGBO(198, 173, 137, 0.745),
                         Color.fromARGB(255, 78, 62, 38),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Text(
                Authorization.username??'',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
             
            ],
          ),
        ),
        _buildDrawerItem(Icons.home, 'Nekretnine', context, const NekretnineListScreen()),
      
        _buildDrawerItem(Icons.add, 'Dodaj nekretninu', context, DodajNekretninuScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        _buildDrawerItem(Icons.schedule, 'Zakazani obilasci', context, ZakazaniObilasciScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        _buildDrawerItem(Icons.favorite, 'Lista želja', context, WishListaScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        _buildDrawerItem(Icons.vpn_key, 'Moje objavljene nekretnine', context, ObjavljeneNekretnineScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        _buildDrawerItem(Icons.report, 'Prijavljeni problemi', context, PrijavljeniProblemiScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        _buildDrawerItem(Icons.person, 'Vaš profil', context, VasProfilScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        _buildDrawerItem(Icons.bar_chart, 'Statistika', context, SalesStatisticssScreen(),
            iconColor: const Color.fromARGB(255, 255, 255, 255)),
        const Divider(color: Colors.white54),
         
        _buildDrawerItem(Icons.logout, 'Odjavi se', context, HomePage(),
            iconColor: const Color.fromARGB(255, 255, 0, 0), logout: true),
           
      ],
    ),
  ),
):null,

      body: widget.child!,
    );
  }


  Future<void> _clearAppState() async {
  Authorization.username = null;
  Authorization.password = null;
 
  setState(() {
    username = '';
  });
}

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, Widget destination,
    {Color? iconColor, bool logout = false}) {
  return ListTile(
    leading: Icon(icon, size: 28, color: iconColor ?? Colors.white),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
    onTap: () {
      Navigator.pop(context); 
      if (logout) {
      _clearAppState().then((_) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
      (Route<dynamic> route) => false,
    );
  });
}
 else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destination),
        );
      }
    },
  );
}

}
