import 'package:prodajanekretnina_mobile/models/komentariAgentima.dart';
import 'package:prodajanekretnina_mobile/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile/providers/komentariAgentima_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile/providers/problem_provider.dart';
import 'package:prodajanekretnina_mobile/providers/reccomend_results_provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile/providers/recenzija_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipNekr_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineListScreen.dart';
import 'package:prodajanekretnina_mobile/screens/NekretnineDetaljiScreen.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/korisnikNekretninaWish_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_mobile/providers/kupci_provider.dart';
import 'package:prodajanekretnina_mobile/providers/status_provider.dart';
import 'package:prodajanekretnina_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'l10n/l10n.dart';
import 'package:prodajanekretnina_mobile/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:prodajanekretnina_mobile/screens/RegistracijaScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NekretnineProvider()),
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
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: Colors.deepPurple,
                textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      supportedLocales: L10n.all,
      //locale: Locale(appState.lang),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
  //late UserProvider _userProvider;
  late NekretnineProvider _nekretnineProvider;
  @override
  Widget build(BuildContext context) {
    _nekretnineProvider =
        Provider.of<NekretnineProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/sem2.png"),
                      fit: BoxFit.fill)),
              child: Stack(children: [
                /*Positioned(
                    left: 110,
                    top: 0,
                    width: 90,
                    height: 120,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                      image: AssetImage("assets/images/light-1.png"),
                    )))),
                Positioned(
                    right: 60,
                    top: 0,
                    width: 80,
                    height: 120,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                      image: AssetImage("assets/images/clock.png"),
                    )))),*/
                Container(
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Pasword",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6)
                ]),
              ),
              child: InkWell(
                onTap: () async {
                  try {
                    Authorization.username = _usernameController.text;
                    Authorization.password = _passwordController.text;

                    await _nekretnineProvider.get();

                    Navigator.pushNamed(
                        context, NekretnineListScreen.routeName);
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Greška!"),
                        content: Text(
                            "Neispravna lozinka ili korisničko ime, pokušajte ponovo"),
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
                child: Center(child: Text("Prijavi se")),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Zaboravili ste lozinku?"),
            SizedBox(
              height: 30,
            ),
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
                  color:
                      Color.fromARGB(255, 33, 96, 148), // Set the color to blue
                  decoration: TextDecoration.underline, // Add an underline
                ),
              ),
            ),
          ],
        ),
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
