import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_mobile/models/drzave.dart';
import 'package:prodajanekretnina_mobile/models/gradovi.dart';

import 'package:prodajanekretnina_mobile/models/korisnici.dart';
import 'package:prodajanekretnina_mobile/models/problemi.dart';
import 'package:prodajanekretnina_mobile/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile/models/lokacije.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/status.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';

import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/status_provider.dart';
import 'package:prodajanekretnina_mobile/providers/problem_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          style: TextStyle(fontSize: 20), // Prilagodi veličinu fonta ovdje
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
    // Filter nekretnine based on nekretninaTipAkcijeResult
    List<dynamic> filteredNekretnine =
        ProblemiData.where((status) => status.korisnikId == korisnikId())
                .toList() ??
            [];
    korisnikId();

    print("USRNM ${username}");

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          //_buildSearch(),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Changed to vertical
              child: Column(
                children: filteredNekretnine.map((dynamic e) {
                  return SizedBox(
                    width: 700,
                    child: Container(
                      color: _getColorByStatus(e.statusId),
                      margin: EdgeInsets.only(bottom: 16), // Dodaj razmak ovdje
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
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 14),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: _getStringStatusa(e.statusId),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20), // Dodaj dodatni razmak
                              Container(
                                width: 200,
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      var result = await _problemProvider
                                          .delete(e.problemId!);

                                      // Check the result
                                      if (result) {
                                        // Deletion was successful
                                        print('Problem uspješno uklonjen.');
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PrijavljeniProblemiScreen(),
                                          ),
                                        );

                                        // Refresh the content by calling initForm() and triggering a rebuild
                                        await initForm();
                                        setState(() {});
                                      } else {
                                        // Deletion failed
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
      return const Color.fromARGB(255, 168, 243, 170);
    } else {
      return Color.fromARGB(255, 247, 173, 138);
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A';
    }

    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(date);
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
    //required this.tipNekretnineResult,
  }) : _nekretninaAgentiProvider = NekretninaAgentiProvider();
  /* @override
  Widget build(BuildContext context) {
    String defaultDatumRjesenja = problem.datumRjesenja != null
        ? problem.datumRjesenja!
        : DateTime.now().toIso8601String();
    TextEditingController datumPopravkeController =
        TextEditingController(text: defaultDatumRjesenja);
    print('datum contr ${problem.datumRjesenja}');
    TextEditingController opisPopravkeController =
        TextEditingController(text: problem.opisRjesenja);
    TextEditingController statusProblemaController = TextEditingController();
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
      body: ListView(children: [
        Center(
          child: Column(children: [
            SizedBox(height: 16),
            Text(
              'Opis problema: ${problem.opis}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 200, vertical: 10),
              color: Color.fromARGB(128, 253, 253, 254),
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informacije o problemu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Nekretnina ID: ${problem.nekretninaId}'),
                              Text(
                                  'Datum prijave: ${_formatDate(problem.datumPrijave)}'),
                              Text('Opis problema: ${problem.opis}'),
                              Text(
                                  'Je li problem ranije prijavljivan? ${problem.isVecPrijavljen == true ? "Da" : "Ne"}'),
                              Text(
                                  'Lokacija: ${_getAdresaNekretnine(problem.nekretninaId)}'),
                              Text(
                                  'Status rješavanja problema: ${_getStringStatusa(problem.statusId)}'),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kontakt podaci vlasnika',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Vlasnik: ${_getVlasnik(problem.nekretninaId)}'),
                              Text(
                                  'E-mail: ${_getEmaill(problem.nekretninaId)}'),
                              Text(
                                  'Broj telefona: ${_getBrTele(problem.nekretninaId)}'),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        /*Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informacije o prodavcu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Ime i prezime: ${_getKorisnikName(nekretnina.korisnikId)}'),
                              Text('Email: ${_getEmail(nekretnina.korisnikId)}'),
                              Text(
                                  'Broj telefona: ${_getBrTel(nekretnina.korisnikId)}'),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: FormBuilderDropdown<String>(
                                  name: 'korisnikId',
                                  decoration: InputDecoration(
                                    labelText: 'Dodajte agenta za nekretninu',
                                    suffix: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        _formKey
                                            .currentState!.fields['korisnikId']
                                            ?.reset();
                                      },
                                    ),
                                    hintText: 'Odaberite agenta',
                                  ),
                                  onChanged: (newValue) async {
                                    Map<String, dynamic> request = {
                                      'korisnikId': newValue,
                                      'nekretninaId': nekretnina.nekretninaId,
                                    };
                                    print('new value ${newValue}');
                                    print('new value ${request}');
                                    var agentId = request['korisnikId'];
                                    if (agentId != null) {
                                      await _nekretninaAgentiProvider
                                          .insert(request);
                                    }
                                  },
                                  items: korisniciResult?.result
                                          .map((Korisnik k) => DropdownMenuItem(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                value: k.korisnikId.toString(),
                                                child: Text(k.ime.toString()),
                                              ))
                                          .toList() ??
                                      [],
                                ),
                              ),
                            ],
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(height: 16),
                    /*TextFormField(
                      controller: datumPopravkeController,
                      decoration: InputDecoration(labelText: 'Datum popravke'),
                    ),*/
                    TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText: 'Datum popravke',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: datumPopravkeController,
                    ),
                    TextFormField(
                      controller: opisPopravkeController,
                      decoration: InputDecoration(labelText: 'Opis popravke'),
                    ),
                    SizedBox(height: 16),
                    Text('Odaberite status rješavanja problema:'),
                    DropdownButtonFormField<int>(
                      value: selectedStatusId,
                      onChanged: (newValue) {
                        _formKey.currentState
                            ?.save(); // Save the form to trigger validation

                        selectedStatusId = newValue;
                      },
                      items: statusResult?.result
                          .map<DropdownMenuItem<int>>((Status status) {
                        return DropdownMenuItem<int>(
                          value: status.statusId,
                          child: Text(status.opis ?? ''),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        DateFormat inputFormat =
                            DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
                        DateTime parsedDate =
                            inputFormat.parse(datumPopravkeController.text);

                        Map<String, dynamic> request = {
                          'statusId': selectedStatusId,
                          'korisnikId': problem.korisnikId,
                          'nekretninaId': problem.nekretninaId,
                          'datumPrijave': problem.datumPrijave,
                          'datumNastankaProblema':
                              problem.datumNastankaProblema,
                          //'datumRjesenja': parsedDate.toIso8601String(),
                          'datumRjesenja':
                              selectedDate.value?.toIso8601String() ?? '',
                          'opisRjesenja': opisPopravkeController.text.isEmpty
                              ? problem
                                  .opisRjesenja // Use the existing value if not modified
                              : opisPopravkeController.text,
                          'opis': problem.opis,
                        };

                        print('datum ${parsedDate}');
                        var result = problemProvider.update(
                          problem.problemId!,
                          request,
                        );
                      },
                      child: Text('Spremi'),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ]),
    );
  }*/
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Opis problema: ${problem.opis}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                color: Color.fromARGB(128, 253, 253, 254),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Informacije o problemu',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text('Nekretnina ID: ${problem.nekretninaId}'),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.description_rounded,
                                        color: Colors.orange),
                                    SizedBox(
                                        width:
                                            8), // Adjust the spacing as needed
                                    Expanded(
                                      child: Text(
                                        'Opis problema: ${(problem.opis)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines:
                                            2, // Set the maximum number of lines
                                        overflow: TextOverflow
                                            .ellipsis, // Display ellipsis (...) for overflow
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.help_outline,
                                        color: Colors.orange),

                                    SizedBox(
                                        width:
                                            8), // Adjust the spacing as needed
                                    Text(
                                        'Je li problem ranije prijavljivan? ${problem.isVecPrijavljen == true ? "Da" : "Ne"}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.calendar_month_outlined,
                                        color: Colors.orange),

                                    SizedBox(
                                        width:
                                            8), // Adjust the spacing as needed
                                    Text(
                                      'Datum prijave: ${_formatDate(problem.datumPrijave)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.orange),

                                    SizedBox(
                                        width:
                                            8), // Adjust the spacing as needed
                                    Text(
                                      'Lokacija: ${_getAdresaNekretnine(problem.nekretninaId)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.access_time,
                                        color: Colors.orange),

                                    SizedBox(
                                        width:
                                            8), // Adjust the spacing as needed
                                    Text(
                                      'Status rješavanja problema: ${_getStringStatusa(problem.statusId)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          /*Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kontakt podaci vlasnika',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    'Vlasnik: ${_getVlasnik(problem.nekretninaId)}'),
                                Text(
                                    'E-mail: ${_getEmaill(problem.nekretninaId)}'),
                                Text(
                                    'Broj telefona: ${_getBrTele(problem.nekretninaId)}'),
                              ],
                            ),
                          ),*/
                          SizedBox(width: 20),
                          /*Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Informacije o prodavcu',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      'Ime i prezime: ${_getKorisnikName(nekretnina.korisnikId)}'),
                                  Text('Email: ${_getEmail(nekretnina.korisnikId)}'),
                                  Text(
                                      'Broj telefona: ${_getBrTel(nekretnina.korisnikId)}'),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: FormBuilderDropdown<String>(
                                      name: 'korisnikId',
                                      decoration: InputDecoration(
                                        labelText: 'Dodajte agenta za nekretninu',
                                        suffix: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            _formKey
                                                .currentState!.fields['korisnikId']
                                                ?.reset();
                                          },
                                        ),
                                        hintText: 'Odaberite agenta',
                                      ),
                                      onChanged: (newValue) async {
                                        Map<String, dynamic> request = {
                                          'korisnikId': newValue,
                                          'nekretninaId': nekretnina.nekretninaId,
                                        };
                                        print('new value ${newValue}');
                                        print('new value ${request}');
                                        var agentId = request['korisnikId'];
                                        if (agentId != null) {
                                          await _nekretninaAgentiProvider
                                              .insert(request);
                                        }
                                      },
                                      items: korisniciResult?.result
                                              .map((Korisnik k) => DropdownMenuItem(
                                                    alignment:
                                                        AlignmentDirectional.center,
                                                    value: k.korisnikId.toString(),
                                                    child: Text(k.ime.toString()),
                                                  ))
                                              .toList() ??
                                          [],
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          labelText: 'Datum popravke',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: datumPopravkeController,
                      ),
                      TextFormField(
                        controller: opisPopravkeController,
                        decoration: InputDecoration(labelText: 'Opis popravke'),
                      ),
                      SizedBox(height: 16),
                      /* Text('Odaberite status rješavanja problema:'),
                      DropdownButtonFormField<int>(
                        value: selectedStatusId,
                        onChanged: (newValue) {
                          _formKey.currentState?.save();
                          selectedStatusId = newValue;
                        },
                        items: statusResult?.result
                            .map<DropdownMenuItem<int>>((Status status) {
                          return DropdownMenuItem<int>(
                            value: status.statusId,
                            child: Text(status.opis ?? ''),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      Align(
                          alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            DateFormat inputFormat =
                                DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
                            DateTime parsedDate =
                                inputFormat.parse(datumPopravkeController.text);
                        
                            Map<String, dynamic> request = {
                              'statusId': selectedStatusId,
                              'korisnikId': problem.korisnikId,
                              'nekretninaId': problem.nekretninaId,
                              'datumPrijave': problem.datumPrijave,
                              'datumNastankaProblema':
                                  problem.datumNastankaProblema,
                              'datumRjesenja':
                                  selectedDate.value?.toIso8601String() ?? '',
                              'opisRjesenja': opisPopravkeController.text.isEmpty
                                  ? problem.opisRjesenja
                                  : opisPopravkeController.text,
                              'opis': problem.opis,
                            };
                        
                            print('datum ${parsedDate}');
                            var result = problemProvider.update(
                              problem.problemId!,
                              request,
                            );
                          },
                          child: Text('Spremi'),
                        ),
                      ),*/
                    ],
                  ),
                ),
              )
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
    return DateFormat('dd-MM-yyyy').format(date);
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
