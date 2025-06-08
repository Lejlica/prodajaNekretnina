import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/problemi_provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:prodajanekretnina_admin/providers/kategorijeNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/status_provider.dart';
import 'package:prodajanekretnina_admin/providers/uloge_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_uloge_provider.dart';
import 'package:prodajanekretnina_admin/providers/agencije_provider.dart';
import 'package:prodajanekretnina_admin/screens/nekretnine_lista_screen.dart';
import 'package:prodajanekretnina_admin/screens/registracijaScreen.dart';
import 'package:prodajanekretnina_admin/utils/util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NekretnineProvider()),
      ChangeNotifierProvider(create: (_) => DrzaveProvider()),
      ChangeNotifierProvider(create: (_) => GradoviProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => LokacijeProvider()),
      ChangeNotifierProvider(create: (_) => KategorijeNekretninaProvider()),
      ChangeNotifierProvider(create: (_) => TipoviNekretninaProvider()),
      ChangeNotifierProvider(create: (_) => SlikeProvider()),
      ChangeNotifierProvider(create: (_) => NekretninaAgentiProvider()),
      ChangeNotifierProvider(create: (_) => ObilazakProvider()),
      ChangeNotifierProvider(create: (_) => NekretninaTipAkcijeProvider()),
      ChangeNotifierProvider(create: (_) => TipAkcijeProvider()),
      ChangeNotifierProvider(create: (_) => ProblemProvider()),
      ChangeNotifierProvider(create: (_) => StatusProvider()),
      ChangeNotifierProvider(create: (_) => UlogeProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciUlogeProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikAgencijaProvider()),
      ChangeNotifierProvider(create: (_) => AgencijaProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS II Material app',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  late NekretnineProvider _nekretnineProvider;

  @override
  Widget build(BuildContext context) {
    
    _nekretnineProvider = context.read<NekretnineProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 400, maxWidth: 450),
          child: Card(
            child: Card(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/sem2.png",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Opacity(
                    opacity: 0.65,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 100),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromRGBO(255, 255, 255, 0.6),
                              ),
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: "Korisničko ime",
                                  prefixIcon: Icon(Icons.email),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                controller: usernameController,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromRGBO(255, 255, 255, 0.6),
                              ),
                              child: TextField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Lozinka",
                                  prefixIcon: Icon(Icons.password),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: passwordController,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 14),
                            ElevatedButton(
                              onPressed: () async {
                                var username = usernameController.text;
                                var password = passwordController.text;
                                print("Login proceed $username $password");

                                Authorization.username = username;
                                Authorization.password = password;

                                try {
                                 // await _nekretnineProvider.get();

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NekretnineListScreen(),
                                    ),
                                  );
                                } on Exception catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text("Error"),
                                            content: Text(e.toString()),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text("OK"))
                                            ],
                                          ));
                                }
                              },
                              child: const Text("Login"),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegistracijaScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Registruj se",
                                style: TextStyle(
                                  color: Colors.white, // Set the color to blue
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
