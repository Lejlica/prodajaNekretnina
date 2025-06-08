import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/kategorijeNekretnina.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/problemi.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/kategorijeNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/problemi_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_admin/screens/prijavljeni_problemi.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import '../utils/util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class RijeseniProblemiScreen extends StatefulWidget {
  Problem? problem;
  Grad? grad;

  RijeseniProblemiScreen({Key? key, this.problem}) : super(key: key);

  @override
  State<RijeseniProblemiScreen> createState() => _RijeseniProblemiScreenState();
}

/*Future<Uint8List?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Read the selected image as bytes
    Uint8List? bytes = await pickedFile.readAsBytes();
    return bytes;
  }

  return null;
}*/

class _RijeseniProblemiScreenState extends State<RijeseniProblemiScreen> {
  final TextEditingController _problemIdController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  late KategorijeNekretninaProvider _kategorijeNekretninaProvider;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  late ProblemProvider _problemProvider;
  bool isLoading = true;
final TextEditingController _datumController = TextEditingController();
  SearchResult<Korisnik>? korisniciResult;
  SearchResult<Nekretnina>? nekretnineResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
  SearchResult<KategorijaNekretnine>? kategorijeResult;
  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  SearchResult<Problem>? problemiResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  @override
  void initState() {
    super.initState();

    _initialValue = {};

    _nekretnineProvider = NekretnineProvider();
    _kategorijeNekretninaProvider = KategorijeNekretninaProvider();
    _korisniciProvider = context.read<KorisniciProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _kategorijeNekretninaProvider =
        context.read<KategorijeNekretninaProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _drzaveProvider = context.read<DrzaveProvider>();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _problemProvider = context.read<ProblemProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      nekretnineResult = await _nekretnineProvider.get();
      print(nekretnineResult);
      korisniciResult = await _korisniciProvider.get();
      print(korisniciResult);
      tipoviResult = await _tipoviNekretninaProvider.get();
      print(tipoviResult);
      lokacijeResult = await _lokacijeProvider.get();
      print(lokacijeResult);
      kategorijeResult = await _kategorijeNekretninaProvider.get();
      print(kategorijeResult);
      gradoviResult = await _gradoviProvider.get();
      print(gradoviResult);
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();

      print('nekrAgenti $nekretninaAgentiResult');
      problemiResult = await _problemProvider.get();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riješeni problemi'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Filter nekretnine based on nekretninaTipAkcijeResult
    List<Problem> filteredNekretnine = problemiResult?.result
            .where((status) => status.statusId == 3)
            .toList() ??
        [];
    int brojNaCekanju = problemiResult?.result
            .where((status) => status.statusId != 3)
            .toList()
            .length ??
        0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildSearch(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Changed to vertical
              child: Column(
                children: filteredNekretnine.map((Problem e) {
                  return Center(
  child: SizedBox(
    width: 600,
    child: Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color.fromARGB(180, 255, 255, 255),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProblemDetailScreen(
                problem: e,
                korisniciResult: korisniciResult,
                problemProvider: _problemProvider,
                nekretnineResult: nekretnineResult,
                lokacijeResult: lokacijeResult,
                gradoviResult: gradoviResult,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Naslov sa ID problema
              Row(
                children: [
                  const Icon(Icons.report_problem_outlined, color: Colors.redAccent),
                  const SizedBox(width: 8),
                  Text(
                    'Problem br. ${e.problemId?.toString() ?? ""}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Informacije o nekretnini
              Row(
                children: [
                  const Icon(Icons.home, size: 20, color: Colors.blue),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Rb. nekretnine: ${e.nekretninaId?.toString() ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Vlasnik
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 20, color: Colors.indigo),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Vlasnik: ${_getVlasnik(e.nekretninaId)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Datum prijave
              Row(
                children: [
                  const Icon(Icons.calendar_month, size: 20, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Datum prijave: ${_formatDate(e.datumPrijave)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);

                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  margin: const EdgeInsets.only(bottom: 12),
  decoration: BoxDecoration(
    color: Colors.red.withOpacity(0.1),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.redAccent),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
      ),
      const SizedBox(width: 8),
      Text(
        'Na čekanju: $brojNaCekanju',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

          const SizedBox(height: 16),
          ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 87, 88, 171),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 3,
  ),
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PrijavljeniProblemiScreen(),
      ),
    );
  },
  icon: const Icon(Icons.list_alt), // ikonica za prikaz liste problema
  label: const Text(
    'Pregledaj prijavljene probleme',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  ),
),
SizedBox(height: 16),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd.MM.yyyy.').format(date);
  }

  String _getVlasnik(int? nekretninaId) {
    Nekretnina? nekretnine = nekretnineResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
      // Default value
    );
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == nekretnine?.korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }
ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);
void selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        selectedDate.value = picked;
        _datumController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(selectedDate.value!);
      }
    }

  Widget _buildSearch() {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(16.0),
      constraints: const BoxConstraints(maxWidth: 500), // ograničena širina
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              readOnly: true,
              controller: _datumController,
              onTap: () => selectDate(context),
              decoration: InputDecoration(
                labelText: 'Datum prijave problema',
                filled: true,
                fillColor: Colors.blueGrey.shade50,
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12), // razmak
          Flexible(
            flex: 2,
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () async {
                  var data = await _problemProvider.get(
                    filter: {
                      'DatumPrijave': _datumController.text,
                    },
                  );

                  setState(() {
                    problemiResult = data;
                  });
                },
                icon: const Icon(Icons.search),
                label: const Text("Pretraga"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 88, 171),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildKorisnikNameCell(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return Text('${korisnik?.ime} ${korisnik?.prezime}');
  }

  Widget _buildKorisnikEmailCell(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return Text('${korisnik?.email}');
  }

  Widget _buildAgentNameCell(int? nekretninaId) {
    NekretninaAgenti? agent = nekretninaAgentiResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
    );

    if (agent != null) {
      Korisnik? korisnik = korisniciResult?.result.firstWhere(
        (element) => element.korisnikId == agent.korisnikId,
      );

      if (korisnik != null) {
        return Text('${korisnik.ime} ${korisnik.prezime}');
      } else {
        return const Text('Unknown Agent');
      }
    } else {
      return const Text('Unknown Agent');
    }
  }
}

class ProblemDetailScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final Problem problem;

  final SearchResult<Korisnik>? korisniciResult;
  final SearchResult<Nekretnina>? nekretnineResult;
  final SearchResult<Lokacija>? lokacijeResult;
  final SearchResult<Grad>? gradoviResult;
  final ProblemProvider problemProvider;
  final NekretninaAgentiProvider _nekretninaAgentiProvider;
  //final SearchResult<TipNekretnine>? tipNekretnineResult;
  ProblemDetailScreen({super.key, 
    required this.problem,
    required this.korisniciResult,
    required this.nekretnineResult,
    required this.lokacijeResult,
    required this.gradoviResult,
    required this.problemProvider,

    //required this.tipNekretnineResult,inser
  }) : _nekretninaAgentiProvider = NekretninaAgentiProvider();

  void _launchEmail(int korisnikId) async {
    String email = _getEmail(korisnikId);

    if (await canLaunch('mailto:$email')) {
      await launch('mailto:$email');
    } else {
      // Ne može se otvoriti email, dodajte odgovarajući tretman ovdje
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalji o problemu'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue, // Promijenite boju ako želite
                            size: 24.0, // Prilagodite veličinu prema potrebi
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Riješeni problemi ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '| ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Detalji/rješenje za prijavljeni problem',
                            style: TextStyle(
                              color: Color.fromARGB(239, 158, 158, 158),
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 3,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const VerticalDivider(
                          width: 1, thickness: 1, color: Colors.blue),
                      const Text(
                        'Informacije',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.send, color: Colors.grey, size: 17),
                          const SizedBox(width: 5),
                          const Text(
                            'Zahtjev poslao: ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 130, 130, 130),
                            ),
                          ),
                          Text(_getKorisnikName(problem.korisnikId)),
                          TextButton(
                            onPressed: () => _launchEmail(problem.korisnikId!),
                            child: Text(
                              _getEmail(problem.korisnikId),
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Icon(Icons.calendar_today,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 5),
                        const Text(
                          'Datum prijave: ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 130, 130),
                          ),
                        ),
                        Text(
                          '${DateFormat('dd.MM.yyyy. HH:mm').format(DateTime.parse(problem.datumPrijave?.toString() ?? ""))}h',
                        ),
                      ]),
                      const SizedBox(height: 10),
                      
                      const SizedBox(height: 10),
                      const Row(children: [
                        Text(
                          'Detalji: ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 130, 130),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 5),
                      Row(children: [
                        const SizedBox(width: 10),
                        Text('Rb. nekretnine: ${problem.nekretninaId}')
                      ]),
                      Row(children: [
                        const SizedBox(width: 10),
                        Text('Broj telefona: ${_getBrTel(problem.korisnikId)}')
                      ]),
                      Row(children: [
                        const SizedBox(width: 10),
                        Text.rich(
                          TextSpan(
                            text: 'Je li problem ranije prijavljivan?: ',
                            children: <InlineSpan>[
                              problem.isVecPrijavljen == true
                                  ? const WidgetSpan(
                                      child: Icon(Icons.check,
                                          color: Colors.green),
                                    )
                                  : const WidgetSpan(
                                      child:
                                          Icon(Icons.close, color: Colors.red),
                                    ),
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      const Divider(
                        height: 3,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Rješenje',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        const Icon(Icons.calendar_today,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 5),
                        const Text(
                          'Datum rješenja: ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 130, 130),
                          ),
                        ),
                        Text(
                          '${DateFormat('dd.MM.yyyy. HH:mm').format(DateTime.parse(problem.datumRjesenja?.toString() ?? ""))}h',
                        ),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        const Icon(Icons.note_alt, size: 18, color: Colors.grey),
                        const SizedBox(width: 5),
                        const Text(
                          'Opis rješenja: ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 130, 130),
                          ),
                        ),
                        Text(
                          '${problem.opisRjesenja?.toString()}',
                        ),
                      ]),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd.MM.yyyy.').format(date);
  }

  String _getAdresaNekretnine(int? nekretninaId) {
    Nekretnina? nekretnina = nekretnineResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
      // Default value
    );
    Lokacija? lokacija = lokacijeResult?.result.firstWhere(
      (element) => element.lokacijaId == nekretnina?.lokacijaId,
      // Default value
    );
    Grad? grad = gradoviResult?.result.firstWhere(
      (element) => element.gradId == lokacija?.lokacijaId,
      // Default value
    );

    return '${grad?.naziv}';
  }

  String _getKorisnikName(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }

  /* String _getTipNekretnineName(int? tipNekretnineId) {
    TipNekretnine? tipNekretnine = tipNekretnineResult?.result.firstWhere(
      (element) => element.tipNekretnineId == tipNekretnineId,
      // Default value
    );

    return tipNekretnine?.nazivTipa ??
        'Unknown Type'; // Return the name or 'Unknown Type'
  }*/

  String _getBrTel(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.telefon}';
  }

  String _getVlasnik(int? nekretninaId) {
    Nekretnina? nekretnine = nekretnineResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
      // Default value
    );
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == nekretnine?.korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }

  String _getEmaill(int? nekretninaId) {
    Nekretnina? nekretnine = nekretnineResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
      // Default value
    );
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == nekretnine?.korisnikId,
      // Default value
    );

    return '${korisnik?.email} ';
  }

  String _getBrTele(int? nekretninaId) {
    Nekretnina? nekretnine = nekretnineResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,
      // Default value
    );
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == nekretnine?.korisnikId,
      // Default value
    );

    return '${korisnik?.telefon} ';
  }

  String _getEmail(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.email}';
  }
}
