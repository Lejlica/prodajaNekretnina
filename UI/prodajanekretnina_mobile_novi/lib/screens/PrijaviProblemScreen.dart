import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_mobile_novi/models/drzave.dart';
import 'package:prodajanekretnina_mobile_novi/models/gradovi.dart';
import 'package:prodajanekretnina_mobile_novi/models/problemi.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/models/lokacije.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/models/search_result.dart';
import 'package:prodajanekretnina_mobile_novi/models/slike.dart';
import 'package:prodajanekretnina_mobile_novi/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_mobile_novi/providers/drzave_provide.dart';
import 'package:prodajanekretnina_mobile_novi/providers/problem_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/gradovi_provider.dart';
import 'package:intl/intl.dart';
import 'package:prodajanekretnina_mobile_novi/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_mobile_novi/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_mobile_novi/screens/saljiMail.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_mobile_novi/providers/slike_provider.dart';
import '../utils/util.dart';

class PrijaviProblemScreen extends StatefulWidget {
  Problem? problem;
  Nekretnina? nekretnina;
  PrijaviProblemScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<PrijaviProblemScreen> createState() => _PrijaviProblemScreenState();
}



class _PrijaviProblemScreenState extends State<PrijaviProblemScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisniciProvider _korisniciProvider;
  Nekretnina? nekretnina;
  late ProblemProvider _problemProvider;
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
     
    };

    
    _problemProvider = context.read<ProblemProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
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
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUvodnaPoruka(),
          
          ],
        ),

            
            FormBuilderTextField(
  name: 'opis',
  maxLines: 5,
  decoration: InputDecoration(
    labelText: 'Opis problema',
    alignLabelWithHint: true,
    prefixIcon: Icon(Icons.report_problem, color: Colors.redAccent),
   
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFFD700), width: 2), // Zlatna boja
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Opis problema je obavezan';
    }
    return null;
  },
),

            SizedBox(height: 16),

         
            FormBuilderTextField(
              name: 'datumNastankaProblema',
              readOnly: true,
              controller: datumPopravkeController,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Datum nastanka problema',
                prefixIcon: Icon(Icons.calendar_today, color: Colors.blueGrey),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFFD700), width: 2), // Zlatna boja
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Datum nastanka problema je obavezan';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Već ranije prijavljen problem?',
                  style: TextStyle(fontSize: 16),
                ),
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
            SizedBox(height: 20),

        
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.send, color: Colors.white),
                label: Text(
                  'Prijavi problem',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    DateFormat inputFormat =
                        DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSSS');
                    DateTime parsedDate = inputFormat.parse(datumPopravkeController.text);
                    Map<String, dynamic> request = {
                      'opis': _formKey.currentState?.fields['opis']?.value,
                      'datumPrijave': DateTime.now().toIso8601String(),
                      'isVecPrijavljen': isVecPrijavljenChecked,
                      'datumNastankaProblema': selectedDate.value?.toIso8601String() ?? '',
                      'datumRjesenja': DateTime.now().toIso8601String(),
                      'opisRjesenja': '',
                      'korisnikId': korisnikId(),
                      'nekretninaId': widget.nekretnina?.nekretninaId,
                      'statusId': 4,
                    };
                    Problem insertedProblem = await _problemProvider.insert(request);
                    if (insertedProblem != null) {
                      _formKey.currentState?.reset();
                      datumPopravkeController.clear();
                      isVecPrijavljenChecked = false;
                      ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(width: 8),
        Expanded(child: Text('Uspješno ste prijavili problem!')),
      ],
    ),
    backgroundColor: Colors.grey[800],
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
    duration: Duration(seconds: 3),
  ),
);
Future.delayed(Duration(seconds: 3), () {
  Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PrijaviSmetnju(
                              korisnikId: widget.nekretnina!.korisnikId!,
                            ),
                          ),
                        );
});
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
          DateFormat('dd-MM-yyyy HH:mm:ss.SSSSSSS').format(selectedDate.value!);
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
  Widget buildUvodnaPoruka() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFD700), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Color(0xFFB8860B), size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'U formu ispod unesite opis problema i datum kada se problem pojavio.\n\n'
            'Nakon što unesete sve potrebne podatke, kliknite na "Prijavi problem" kako biste poslali prijavu.\n\n'
            'Nastojat ćemo riješiti problem u najkraćem mogućem roku.\n\n'
            'Hvala vam na strpljenju!',
            style: TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: Color(0xFF444444),
            ),
          ),
        ),
      ],
    ),
  );
}

}
