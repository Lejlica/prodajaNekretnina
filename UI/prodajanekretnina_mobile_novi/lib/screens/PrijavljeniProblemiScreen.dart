import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_mobile_novi/models/drzave.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/problemi.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/models/lokacije.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/status.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/status_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/problem_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/util.dart';

class PrijavljeniProblemiScreen extends StatefulWidget {
  Problem? problem;
  Grad? grad;

  PrijavljeniProblemiScreen({Key? key, this.problem}) : super(key: key);

  @override
  State<PrijavljeniProblemiScreen> createState() =>
      _PrijavljeniProblemiScreenState();
}



class _PrijavljeniProblemiScreenState extends State<PrijavljeniProblemiScreen> {
  int? selectedStatusId;

  void _updateSelectedStatus(int newValue) {
    setState(() {
      selectedStatusId = newValue;
    });
  }

  TextEditingController _problemIdController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;

  late NekretnineProvider _nekretnineProvider;

  late StatusProvider _statusProvider;
  late ProblemProvider _problemProvider;
  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<Nekretnina>? nekretnineResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;

  SearchResult<Grad>? gradoviResult;
  SearchResult<Status>? statusResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  SearchResult<Problem>? problemiResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  List<dynamic> NekretnineData = [];
  List<dynamic> KorisniciData = [];
  List<dynamic> ProblemiData = [];
  @override
  void initState() {
    super.initState();

    _initialValue = {};
    _statusProvider = StatusProvider();
    _nekretnineProvider = NekretnineProvider();

    _korisniciProvider = context.read<KorisniciProvider>();

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
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpNekretnineData = await _nekretnineProvider?.get(null);
      var tmpProblemiData = await _problemProvider?.get(null);
      var tmpStatusData = await _statusProvider?.get();
      setState(() {
        KorisniciData = tmpKorisniciData!;
        ProblemiData = tmpProblemiData!;
        NekretnineData = tmpNekretnineData!;
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
        title: Text(
          'Prijavljeni problemi',
          style: TextStyle(fontSize: 20), 
        ),
      ),
      body: _buildBody(),
    );
  }

  int? korisnikId() {
    List<dynamic> filteredData = KorisniciData!
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();

    if (filteredData.isNotEmpty) {
      print("Kora ${filteredData[0].korisnikId}");
      return filteredData[0].korisnikId;
    } else {
      print("Nema");
      return null;
    }
  }

  String username = Authorization.username ?? "";
 Widget _buildBody() {
  if (isLoading) {
    return Center(child: CircularProgressIndicator());
  }

 
  List<dynamic> filteredNekretnine =
      ProblemiData.where((status) => status.korisnikId == korisnikId())
          .toList();

  print("USRNM ${username}");
 if (filteredNekretnine.isEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Nemate prijavljenih problema.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      children: [
        SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: filteredNekretnine.map((dynamic e) {
                return SizedBox(
                  width: 700,
                  child: Container(
                    color: _getColorByStatus(e.statusId),
                    margin: EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
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
                              statusResult: statusResult,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Datum prijave: ${_formatDate(e.datumPrijave)}',
                            ),
                            SizedBox(height: 5),
                            Text.rich(
                              TextSpan(
                                text: 'Status rješavanja problema: ',
                                children: [
                                  TextSpan(
                                    text: _getStringStatusa(e.statusId),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 200,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    var result = await _problemProvider
                                        .delete(e.problemId!);

                                    if (result) {
                                      print('Problem uspješno uklonjen.');
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PrijavljeniProblemiScreen(),
                                        ),
                                      );
                                      await initForm();
                                      setState(() {});
                                    } else {
                                      print('Otkazivanje nije uspjelo.');
                                    }
                                  } catch (e) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PrijavljeniProblemiScreen(),
                                      ),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Problem uspješno uklonjen.',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Uredu'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text("Otkaži prijavu problema"),
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


  Color _getColorByStatus(int? statusId) {
    if (statusId == 3) {
      return const Color.fromARGB(255, 101, 248, 160);
    } else {
      return const Color.fromARGB(255, 207, 188, 167);
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A';
    }

    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd.MM.yyyy.').format(date);
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
      (element) => element.nekretninaId == nekretninaId,
      // Default value
    );
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == nekretnine?.korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }

  Widget _buildSearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: "ID nekretnine"),
            controller: _problemIdController,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            var searchFilters = {'problemId': _problemIdController.text};
            var data = await _problemProvider.get(searchFilters);

            setState(() {
              ProblemiData = data;
            });
          },
          child: Text("Pretraga"),
        ),
      ],
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
        return Text('Unknown Agent');
      }
    } else {
      return Text('Unknown Agent');
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
  ProblemDetailScreen({
    required this.problem,
    required this.korisniciResult,
    required this.nekretnineResult,
    required this.lokacijeResult,
    required this.gradoviResult,
    required this.problemProvider,
    required this.statusResult,
   
  }) : _nekretninaAgentiProvider = NekretninaAgentiProvider();
  
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    String defaultDatumRjesenja = problem.datumRjesenja != null
        ? problem.datumRjesenja!
        : DateTime.now().toIso8601String();
    TextEditingController datumPopravkeController =
        TextEditingController(text: defaultDatumRjesenja);
    TextEditingController opisPopravkeController =
        TextEditingController(text: problem.opisRjesenja);
    ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);

    void _selectDate(BuildContext context) async {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji o problemu'),
      ),
       body: SingleChildScrollView(
        child: Center(
  child: ConstrainedBox(
  constraints: BoxConstraints(maxWidth: 600),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.orange, 
              size: 28, 
            ),
            SizedBox(width: 8), 
            Text(
              'Opis problema',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
  children: [
    
     
    Expanded(
      child: Text(
        problem.opis!,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.visible, 
        softWrap: true, 
      ),
    ),
  ],
),

        SizedBox(height: 18), 

       
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: const Color.fromARGB(255, 228, 216, 203), 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(context, Icons.home_work, 'Nekretnina ID', '${problem.nekretninaId}'),
                Divider(),
                _buildInfoRow(context, Icons.description_rounded, 'Opis problema', problem.opis!),
                Divider(),
                _buildInfoRow(context, Icons.help_outline, 'Prijavljivan ranije', problem.isVecPrijavljen == true ? 'Da' : 'Ne'),
                Divider(),
                _buildInfoRow(context, Icons.calendar_today, 'Datum prijave', _formatDate(problem.datumPrijave)),
                Divider(),
                _buildInfoRow(context, Icons.location_on, 'Lokacija', _getAdresaNekretnine(problem.nekretninaId)),
                Divider(),
                _buildInfoRow(context, Icons.timelapse, 'Status problema', _getStringStatusa(problem.statusId)),
                Divider(),
                _buildInfoRow(context, Icons.build, 'Očekivani datum popravke', _formatDate(problem.datumRjesenja)),
                Divider(),
                _buildInfoRow(context, Icons.note_alt, 'Opis popravke', problem.opisRjesenja ?? 'Nema opisa'),
              ],
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

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A'; // Return 'N/A' if the date is null
    }

    DateTime date = DateTime.parse(dateString); // Parse the String to DateTime
    return DateFormat('dd.MM.yyyy.').format(date);
  }

  String _getStringStatusa(int? statusId) {
    Status? statusi = statusResult?.result.firstWhere(
      (element) => element.statusId == statusId,
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
  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
      final theme = Theme.of(context);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 28),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    ],
  );
}

  String _getKorisnikName(int? korisnikId) {
    Korisnik? korisnik = korisniciResult?.result.firstWhere(
      (element) => element.korisnikId == korisnikId,
      // Default value
    );

    return '${korisnik?.ime} ${korisnik?.prezime}';
  }

  

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
