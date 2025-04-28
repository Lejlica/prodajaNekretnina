import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_mobile/models/drzave.dart';
import 'package:prodajanekretnina_mobile/models/gradovi.dart';
import 'package:prodajanekretnina_mobile/models/problemi.dart';

import 'package:prodajanekretnina_mobile/models/korisnici.dart';

import 'package:prodajanekretnina_mobile/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile/models/lokacije.dart';
import 'package:prodajanekretnina_mobile/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile/models/search_result.dart';
import 'package:prodajanekretnina_mobile/models/slike.dart';
import 'package:prodajanekretnina_mobile/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile/providers/problem_provider.dart';
import 'package:prodajanekretnina_mobile/providers/gradovi_provider.dart';
import 'package:intl/intl.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';

import 'package:prodajanekretnina_mobile/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_mobile/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile/providers/slike_provider.dart';
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

class PrijaviProblemScreen extends StatefulWidget {
  Problem? problem;
  Nekretnina? nekretnina;
  PrijaviProblemScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<PrijaviProblemScreen> createState() => _PrijaviProblemScreenState();
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

class _PrijaviProblemScreenState extends State<PrijaviProblemScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  Nekretnina? nekretnina;
  late ProblemProvider _problemProvider;
  late GradoviProvider _gradoviProvider;
  late DrzaveProvider _drzaveProvider;
  late NekretnineProvider _nekretnineProvider;
  late SlikeProvider _slikeProvider;

  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  bool isLoading = true;

  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;

  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  List<dynamic> data = [];
  List<dynamic> dataProblem = [];
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  @override
  void initState() {
    super.initState();

    _initialValue = {
      /* 'opis': widget.problem?.opis?.toString(),
      'datumPrijave': widget.problem?.datumPrijave?.toString(),
      'isVecPrijavljen': widget.problem?.isVecPrijavljen?.toString(),
      'datumNastankaProblema':
          widget.problem?.datumNastankaProblema?.toString(),
      'datumRjesenja': widget.problem?.datumRjesenja?.toString(),
      'opisRjesenja': widget.problem?.opisRjesenja?.toString(),
      'korisnikId': widget.problem?.korisnikId?.toString(),
      'nekretninaId': widget.problem?.nekretninaId?.toString(),
      'statusId': widget.problem?.statusId?.toString()*/
    };

    _nekretnineProvider = NekretnineProvider();
    _problemProvider = context.read<ProblemProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();

    _gradoviProvider = context.read<GradoviProvider>();
    _drzaveProvider = context.read<DrzaveProvider>();
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    initForm();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      var tmpKorisniciData = await _korisniciProvider?.get(null);
      var tmpProblemData = await _problemProvider?.get(null);
      print("tmpKorisniciData ${tmpKorisniciData}");
      print("tmpProblemData ${tmpProblemData}");
      setState(() {
        isLoading = false;
        data = tmpKorisniciData!;
        dataProblem = tmpProblemData!;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      // ignore: sort_child_properties_last
      child: Column(
        children: [
          _formBuild(),
        ],
      ),
      title: 'Prijavi problem',
    );
  }

  bool isVecPrijavljenChecked = false;
  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
                height: 500,
                decoration: BoxDecoration(
                    // Add your decoration properties here
                    ),
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      FormBuilderTextField(
                        name: 'opis',
                        decoration: InputDecoration(
                          labelText: 'Opis problema',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 100.0), // Prilagodite visinu ovdje
                        ),
                      ),
                      FormBuilderTextField(
                        name: 'datumNastankaProblema',
                        decoration: InputDecoration(
                          labelText: 'Odaberite datum nastanka problema',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () => _selectDate(context),
                        controller: datumPopravkeController,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Da li je već prijavljen problem?',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 121, 121, 121)),
                            // Postavite željenu veličinu fonta ovdje
                          ),
                          SizedBox(width: 35),
                          Checkbox(
                            value: isVecPrijavljenChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isVecPrijavljenChecked = newValue ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            DateFormat inputFormat =
                                DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSSS');
                            DateTime parsedDate =
                                inputFormat.parse(datumPopravkeController.text);
                            // Create a request object with form field values
                            Map<String, dynamic> request = {
                              'opis':
                                  _formKey.currentState?.fields['opis']?.value,
                              'datumPrijave': DateTime.now().toIso8601String(),
                              'isVecPrijavljen': isVecPrijavljenChecked,
                              'datumNastankaProblema':
                                  selectedDate.value?.toIso8601String() ?? '',
                              'datumRjesenja': DateTime.now().toIso8601String(),
                              'opisRjesenja': '',
                              'korisnikId': korisnikId(),
                              'nekretninaId': widget.nekretnina?.nekretninaId,
                              'statusId': 4,
                            };
                            print("ID bb ${widget.nekretnina?.nekretninaId}");
                            Problem insertedProblem =
                                await _problemProvider.insert(request);
                            int? insertedProblemId;
                            if (insertedProblem != null) {
                              insertedProblemId = insertedProblem.problemId;
                              _formKey.currentState?.reset();
                              datumPopravkeController.clear();
                              isVecPrijavljenChecked = false;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Uspješno ste prijavili problem!',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Uredu',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors
                                                  .blue // Postavite veličinu fonta prema potrebi
                                              ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              // Now you can use insertedKorisnikId as needed
                            }
                          },
                          child: Text('Prijavi problem'))
                    ])))));
  }

  String username = Authorization.username ?? "";
  ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);
  TextEditingController datumPopravkeController = TextEditingController();
  void _selectDate(BuildContext context) async {
    print("Selected Date: $selectedDate");
    print("Datum Popravke Controller: ${datumPopravkeController.text}");

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      selectedDate.value = picked;
      datumPopravkeController.text =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSSS').format(selectedDate.value!);
    }
  }

  int? korisnikId() {
    List<dynamic> filteredData =
        data!.where((korisnik) => korisnik.korisnickoIme == username).toList();

    if (filteredData.isNotEmpty) {
      return filteredData[0].korisnikId;
    } else {
      return null;
    }
  }
}
