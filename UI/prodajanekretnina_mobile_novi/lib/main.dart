
import 'package:prodajanekretnina_mobile_novi/providers/agencije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/komentariAgentima_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/kupovine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/problem_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/reccomend_results_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/recenzija_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipNekr_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/NekretnineListScreen.dart';
import 'package:prodajanekretnina_mobile_novi/screens/NekretnineDetaljiScreen.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekrNovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikUloge_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/status_provider.dart';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';
import 'package:flutter/material.dart';
import 'l10n/l10n.dart';
//import 'package:prodajanekretnina_mobile_novi/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:prodajanekretnina_mobile_novi/screens/RegistracijaScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NekretnineProvider()),
      ChangeNotifierProvider(create: (_) => NekretnineeProvider()),
      ChangeNotifierProvider(create: (_) => SlikeProvider()),
      ChangeNotifierProvider(create: (_) => GradoviProvider()),
      ChangeNotifierProvider(create: (_) => LokacijeProvider()),
      ChangeNotifierProvider(create: (_) => DrzaveProvider()),
      ChangeNotifierProvider(create: (_) => TipoviNekretninaProvider()),
      ChangeNotifierProvider(create: (_) => TipAkcijeProvider()),
      ChangeNotifierProvider(create: (_) => NekretninaTipAkcijeProvider()),
      ChangeNotifierProvider(create: (_) => NekretninaAgentiProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => ObilazakProvider()),
      ChangeNotifierProvider(create: (_) => KomentariAgentimaProvider()),
      ChangeNotifierProvider(create: (_) => KupciProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikNekretninaWishProvider()),
      ChangeNotifierProvider(create: (_) => ProblemProvider()),
      ChangeNotifierProvider(create: (_) => RecenzijaProvider()),
      ChangeNotifierProvider(create: (_) => StatusProvider()),
      ChangeNotifierProvider(create: (_) => TipNekretninaProvider()),
      ChangeNotifierProvider(create: (_) => ReccomendResultProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikUlogeProvider()),
      ChangeNotifierProvider(create: (_) => AgencijaProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikAgencijaProvider()),
      ChangeNotifierProvider(create: (_) => KupovinaProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 65, 9, 70),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 65, 9, 70), textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      supportedLocales: L10n.all,
      //locale: Locale(appState.lang),
      localizationsDelegates: const [
        //AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: navigatorKey,
      home: HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == NekretnineListScreen.routeName) {
          return MaterialPageRoute(
              builder: ((context) => NekretnineListScreen()));
        } else if (settings.name == NekretnineDetaljiScreen.routeName) {
          return MaterialPageRoute(
              builder: ((context) => NekretnineDetaljiScreen()));
        }

        /*var uri = Uri.parse(settings.name!);
          if (uri.pathSegments.length == 2 &&
              "/${uri.pathSegments.first}" == ProductDetailsScreen.routeName) {
            var id = uri.pathSegments[1];
            return MaterialPageRoute(builder: (context) => ProductDetailsScreen(id));
          }
*/
      },
      
    ),
  ));
}

class HomePage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  late NekretnineProvider _nekretnineProvider;
  @override
  Widget build(BuildContext context) {
    _nekretnineProvider = Provider.of<NekretnineProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/bck.jpg', // Path to the background image
            fit: BoxFit.cover,
            height: double.infinity, // Ensure the image covers the entire screen
            width: double.infinity,  // Ensure the image covers the entire screen
          ),
          // Dark overlay for the background image
          
          // Your form and other content
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                  
                  child: Stack(
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 169, 9, 9),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(198, 173, 137, 0.745),
                         Color.fromARGB(255, 78, 62, 38),
                        
                      ],
                    ),
                  ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                       Color.fromRGBO(198, 173, 137, 0.745),
                         Color.fromARGB(255, 78, 62, 38),
                        
                      ],
                    ),
                  ),
                  child: InkWell(
  onTap: () async {
    try {
      Authorization.username = _usernameController.text;
      Authorization.password = _passwordController.text;

      await _nekretnineProvider.get();

      Navigator.pushNamed(context, NekretnineListScreen.routeName);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Greška!"),
          content: Text("Neispravna lozinka ili korisničko ime, pokušajte ponovo"),
          actions: [
            TextButton(
              child: Text("Uredu"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  },
  splashColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5), // Tap effect color
  child: Container(
    height: 50,
    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
    
    child: Center(
      child: Text(
        "Prijavi se",
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), // Text color
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegistracijaScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Registruj se",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      
                      fontSize: 18
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
