import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/kategorijeNekretnina.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/problemi.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/status.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/kategorijeNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/status_provider.dart';
import 'package:prodajanekretnina_admin/providers/problemi_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import '../utils/util.dart';

class PrijavljeniProblemiScreen extends StatefulWidget {
  Problem? problem;
  Grad? grad;

  PrijavljeniProblemiScreen({Key? key, this.problem}) : super(key: key);

  @override
  State<PrijavljeniProblemiScreen> createState() =>
      _PrijavljeniProblemiScreenState();
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

class _PrijavljeniProblemiScreenState extends State<PrijavljeniProblemiScreen> {
  int? selectedStatusId;

  void _updateSelectedStatus(int newValue) {
    setState(() {
      selectedStatusId = newValue;
    });
  }

  final TextEditingController _datumController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
   late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  late KategorijeNekretninaProvider _kategorijeNekretninaProvider;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  late StatusProvider _statusProvider;
  late ProblemProvider _problemProvider;
  bool isLoading = true;
List<int> nekretninaIdAgencije = [];
  SearchResult<Korisnik>? korisniciResult;
  SearchResult<Nekretnina>? nekretnineResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
  SearchResult<KategorijaNekretnine>? kategorijeResult;
  SearchResult<Grad>? gradoviResult;
  SearchResult<Status>? statusResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  SearchResult<Problem>? problemiResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
  
  @override
  void initState() {
    super.initState();

    _initialValue = {};
    _statusProvider = StatusProvider();
    _nekretnineProvider = NekretnineProvider();
    _kategorijeNekretninaProvider = KategorijeNekretninaProvider();
    _korisniciProvider = context.read<KorisniciProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _korisnikAgencijaProvider =
        context.read<KorisnikAgencijaProvider>();
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
      statusResult = await _statusProvider.get();
      print(statusResult);
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
korisnikAgencijaResult = await _korisnikAgencijaProvider.get(); 
      print('nekrAgenti $nekretninaAgentiResult');
      problemiResult = await _problemProvider.get();
       NadjiKojojAgencijiPripadaKorisnik();
nekretninaIdAgencije = NadjiNekretnineZaAgenciju();
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
        title: const Text('Prijavljeni problemi'),
      ),
      body: _buildBody(),
    );
  }
int korisnikID=0;
  String username = Authorization.username ?? "";
  int? korisnikId() {
    List<dynamic> filteredData = korisniciResult!.result
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();
    if (filteredData.isNotEmpty) {
      korisnikID = filteredData[0].korisnikId!;
      print('korisnikIDDD: $korisnikID');
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }

int? agencijaIdd() {
    List<dynamic> filteredData = korisnikAgencijaResult!.result
        .where((korisnik) => korisnik.korisnikId == korisnikId())
        .toList();
    if (filteredData.isNotEmpty) {
      return filteredData[0].agencijaId;
    } else {
      return null;
    }
  }
List<int> NadjiNekretnineZaAgenciju() {
  // 1. Nađi sve korisnike koji pripadaju agenciji
  List<int> agentiAgencije = korisnikAgencijaResult!.result
      .where((entry) => entry.agencijaId == pripadajucaAgencija)
      .map((entry) => entry.korisnikId!)
      .toList();
      print('agentiAgencije: ${agentiAgencije}');

  
 List<int> nekretnineAgencije = [];

for (var entry in agentiAgencije) {
  nekretnineAgencije.addAll(
    nekretninaAgentiResult!.result
        .where((na) => na.korisnikId == entry)
        .map((na) => na.nekretninaId!)
        .toList(),
  );
}


      
print('nekretnineAgencije: ${nekretnineAgencije}');
  return nekretnineAgencije;
}
  int? pripadajucaAgencija;
int? NadjiKojojAgencijiPripadaKorisnik() {
    for (var entry in korisnikAgencijaResult!.result) {
      print(
          'entry.agencijaId: ${entry.agencijaId}, agencijaId: ${agencijaIdd()}');
      print('Before if condition');
      if (entry.korisnikId == korisnikID) {
        print('Inside if condition');
        print('korisnik pripada agenciji: ${entry.agencijaId}');
        pripadajucaAgencija = entry.agencijaId;
      }
    }
    return pripadajucaAgencija ;
  }
  Widget _buildBody() {
    // Filter nekretnine based on nekretninaTipAkcijeResult
    List<Problem> filteredNekretnine = problemiResult?.result
            .where((status) => status.statusId != 3)
            .toList() ??
        [];
        final filteredByAgencija = filteredNekretnine
    .where((n) => nekretninaIdAgencije.contains(n.nekretninaId))
    .toList();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          _buildSearch(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Changed to vertical
              child: Column(
                children: filteredByAgencija.map((Problem e) {
                  return SizedBox(
                    width: 700,
                    child: GestureDetector(
                      onTap: () async {
  var result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ProblemDetailScreen(
        problem: e,
        korisniciResult: korisniciResult,
        nekretnineResult: nekretnineResult,
        lokacijeResult: lokacijeResult,
        gradoviResult: gradoviResult,
        problemProvider: _problemProvider,
        statusResult: statusResult,
      ),
    ),
  );

  if (result == true) {
    await initForm(); // ponovo učita podatke
    setState(() {});  // osvježi UI
  }
},

                      child: Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  color: const Color.fromARGB(220, 250, 250, 250),
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Levi deo - ID problema
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.report_problem, color: Colors.redAccent),
                  const SizedBox(width: 6),
                  Text(
                    'Problem #${e.problemId?.toString() ?? ""}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.blueGrey),
                  const SizedBox(width: 6),
                  Text(
                    'Datum: ${_formatDates(e.datumPrijave)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Srednji deo - Nekretnina i vlasnik
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.home_work, size: 16, color: Colors.teal),
                  const SizedBox(width: 6),
                  Text(
                    'Nekretnina: ${e.nekretninaId?.toString() ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.indigo),
                  const SizedBox(width: 6),
                  Text(
                    'Vlasnik: ${_getVlasnik(e.nekretninaId)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Desni deo - Status
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _getIconForStatus(e.statusId!),
                  const SizedBox(width: 6),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Status: ',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: _getStringStatusa(e.statusId),
                            style: const TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDates(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd.MM.yyyy. HH:mm').format(date)+ 'h';
  }

  String _getStringStatusa(int? statusId) {
    Status? statusi = statusResult?.result.firstWhere(
      (element) => element.statusId == statusId,
      // Default value
    );

    return '${statusi?.opis} ';
  }

  String _getVlasnik(int? nekretninaId) {
    Nekretnina? nekretnine = nekretnineResult?.result.firstWhere(
      (element) => element.nekretninaId == nekretninaId,orElse: () => Nekretnina(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null),
      // Default value
    );
    var korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == nekretnine?.korisnikId, orElse: () => Korisnik(null, null, null, null, null, null, null, null, null, null),
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
    }//ovdje

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

  Icon _getIconForStatus(int statusId) {
  switch (statusId) {
    case 1: // npr. U toku
      return Icon(Icons.timelapse, size: 16, color: Colors.orange);
    case 2: // Zavrsen
      return Icon(Icons.check_circle_outline, size: 16, color: Colors.green);
    case 3: // Procesiran
      return Icon(Icons.autorenew, size: 16, color: Colors.blue);
    case 4: // Na cekanju
      return Icon(Icons.pause_circle_outline, size: 16, color: Colors.grey);
    default:
      return Icon(Icons.info_outline, size: 16, color: Colors.orange);
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
  final SearchResult<Status>? statusResult;
  final NekretninaAgentiProvider _nekretninaAgentiProvider;
  //final SearchResult<TipNekretnine>? tipNekretnineResult;
  ProblemDetailScreen({super.key, 
    required this.problem,
    required this.korisniciResult,
    required this.nekretnineResult,
    required this.lokacijeResult,
    required this.gradoviResult,
    required this.problemProvider,
    required this.statusResult,
    //required this.tipNekretnineResult,
  }) : _nekretninaAgentiProvider = NekretninaAgentiProvider();
  @override
  Widget build(BuildContext context) {
    String defaultDatumRjesenja = problem.datumRjesenja != null
        ? problem.datumRjesenja!
        : DateTime.now().toIso8601String();
    TextEditingController datumPopravkeController =TextEditingController(text: "");
       // TextEditingController(text: defaultDatumRjesenja);
    print('datum contr ${problem.datumRjesenja}');
    TextEditingController opisPopravkeController =
        TextEditingController(text: problem.opisRjesenja);
    TextEditingController statusProblemaController = TextEditingController();
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
        datumPopravkeController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(selectedDate.value!);
      }
    }

    void launchEmail(int korisnikId) async {
      String email = _getEmail(korisnikId);

      if (await canLaunch('mailto:$email')) {
        await launch('mailto:$email');
      } else {
        // Ne može se otvoriti email, dodajte odgovarajući tretman ovdje
      }
    }

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
                            Icons.help_outline,
                            color: Colors.blue, // Promijenite boju ako želite
                            size: 24.0, // Prilagodite veličinu prema potrebi
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Prijavljeni problemi ',
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
                            onPressed: () => launchEmail(problem.korisnikId!),
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
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey, size: 20),
                          const SizedBox(width: 5),
                          const Text(
                            'Lokacija: ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 130, 130, 130),
                            ),
                          ),
                          //Text(
                          //  _getAdresaNekretnine(problem.nekretninaId),
                          //),
                        ],
                      ),
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
                        Text('Nekretnina ID: ${problem.nekretninaId}')
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
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              
                              readOnly: true,
                              onTap: () => selectDate(context),
                              decoration: const InputDecoration(
                                labelText: 'Datum popravke',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              controller: datumPopravkeController,
                            ),
                          ),
                          const SizedBox(width: 70),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Status (ukoliko oznacite Zavrsen problem ce biti uklonjen iz liste): '),
                                DropdownButtonFormField<int>(
                                  value: selectedStatusId,
                                  onChanged: (newValue) {
                                    _formKey.currentState?.save();
                                    selectedStatusId = newValue;
                                  },
                                  items: statusResult?.result
                                      .map<DropdownMenuItem<int>>(
                                          (Status status) {
                                    return DropdownMenuItem<int>(
                                      value: status.statusId,
                                      child: Text(status.opis ?? ''),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Prazno polje";
                          }
                          return null;
                        },
                        controller: opisPopravkeController,
                        decoration: const InputDecoration(
                          labelText: 'Opis popravke',
                          border:
                              OutlineInputBorder(), // Add this line to create a box border
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: problem.statusId == 3
                            ? null
                            : () async {

                              if(datumPopravkeController.text.isEmpty) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Greška'),
                                        content: Text(
                                            'Odaberite datum popravke.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('U redu'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                              }
                              
                                DateFormat inputFormat =
                                    DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
                                DateTime parsedDate = inputFormat
                                    .parse(datumPopravkeController.text);

                                Map<String, dynamic> request = {
                                  'statusId': selectedStatusId,
                                  'korisnikId': problem.korisnikId,
                                  'nekretninaId': problem.nekretninaId,
                                  'datumPrijave': problem.datumPrijave,
                                  'datumNastankaProblema':
                                      problem.datumNastankaProblema,
                                  'datumRjesenja':
                                      selectedDate.value?.toIso8601String() ??
                                          '',
                                  'opisRjesenja':
                                      opisPopravkeController.text.isEmpty
                                          ? problem.opisRjesenja
                                          : opisPopravkeController.text,
                                  'opis': problem.opis,
                                };

                                print('datum $parsedDate');
                                try {
                                  var result = await problemProvider.update(
                                    problem.problemId!,
                                    request,
                                  );

                                  // Prikazuje dijalog o uspješnom završetku
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Uspješno obavljeno'),
                                        content: Text(
                                            'Podaci su uspješno spremljeni.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            Navigator.of(context).pop(true);
                                            },
                                            child: Text('U redu'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                                                } catch (error) {
                                  // Prikazuje dijalog o grešci
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Greška'),
                                        content: const Text(
                                            'Došlo je do greške prilikom spremanja podataka.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('U redu'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Ovde postavi boju buttona
                        ),
                        child: const Text(
                          'Spremi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
   return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(date)+ 'h';
  }

  String _getStringStatusa(int? statusId) {
    Status? statusi = statusResult?.result.firstWhere(
      (element) => element.statusId == statusId,
      orElse: () => Status(0, 'Nepoznat status'),
      // Default value
    );

    return '${statusi?.opis} ';
  }

  int? selectedStatusId = 1;
  void _onStatusChanged(int? newValue) {
    selectedStatusId = newValue;
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
