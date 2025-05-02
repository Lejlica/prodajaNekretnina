import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/agencija.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipAkcije.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaTipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipAkcije_provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/providers/agencije_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/screens/dodaj_agenta_screen.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../utils/util.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/models/kategorijeNekretnina.dart';
import 'package:prodajanekretnina_admin/models/korisnici.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prodajanekretnina_admin/models/korisnici_uloge.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';
import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/kategorijeNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_uloge_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretninaAgenti_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/nekretnine_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnikAgencija_provider.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:provider/provider.dart';
import 'package:prodajanekretnina_admin/providers/slike_provider.dart';
import 'package:prodajanekretnina_admin/providers/agencije_provider.dart';
import 'package:prodajanekretnina_admin/models/agencija.dart';
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

class AgentCard extends StatelessWidget {
  final String ime;
  final String prezime;
  final String telefon;
  final String email;
  final int brojUspjesnoProdanihNekretnina;
  final Uint8List bytes; // Slika agenta

  const AgentCard({super.key, 
    required this.ime,
    required this.prezime,
    required this.telefon,
    required this.email,
    required this.brojUspjesnoProdanihNekretnina,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(bytes),
            ),
            const SizedBox(height: 10),
            Text(
              '$ime $prezime',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Telefon: $telefon',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              'E-mail: $email',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              'Prodane nekretnine: $brojUspjesnoProdanihNekretnina',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaAgenataScreen extends StatefulWidget {
  final Nekretnina? nekretnina;
  const ListaAgenataScreen({Key? key, this.nekretnina}) : super(key: key);
  @override
  _ListaAgenataScreenState createState() => _ListaAgenataScreenState();
}

class _ListaAgenataScreenState extends State<ListaAgenataScreen> {
  late ObilazakProvider _obilazakProvider;
  SearchResult<Nekretnina>? result;
  final TextEditingController _nekretninaIdController = TextEditingController();
  late KorisniciProvider _korisniciProvider;
  late NekretninaTipAkcijeProvider _nekretninaTipAkcijeProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  late NekretnineProvider _nekretnineProvider;
  late TipAkcijeProvider _tipAkcijeProvider;
  late TipoviNekretninaProvider _tipoviNekretninaProvider;
  late LokacijeProvider _lokacijeProvider;
  late AgencijaProvider _agencijaProvider;
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  SearchResult<Lokacija>? lokacijeResult;
  late GradoviProvider _gradoviProvider;
  SearchResult<Grad>? gradoviResult;
  bool isLoading = true;
  SearchResult<Korisnik>? korisniciResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<NekretninaTipAkcije>? nekretninaTipAkcijeResult;
  SearchResult<TipAkcije>? tipAkcijeResult;
  SearchResult<TipNekretnine>? tipoviNekretninaResult;
  SearchResult<Agencija>? agencijaResult;
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
  @override
  void initState() {
    super.initState();
    print('Init State called');
    _nekretninaAgentiProvider = context.read<NekretninaAgentiProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _obilazakProvider = context.read<ObilazakProvider>();
    _nekretninaTipAkcijeProvider = context.read<NekretninaTipAkcijeProvider>();
    _nekretnineProvider = context.read<NekretnineProvider>();
    _tipAkcijeProvider = context.read<TipAkcijeProvider>();
    _tipoviNekretninaProvider = context.read<TipoviNekretninaProvider>();
    _lokacijeProvider = context.read<LokacijeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _agencijaProvider = context.read<AgencijaProvider>();
    _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
    initForm();
  }

  Future<void> initForm() async {
    try {
      korisniciResult = await _korisniciProvider.get();
      print(korisniciResult);
      nekretninaAgentiResult = await _nekretninaAgentiProvider.get();
      print(nekretninaAgentiResult);
      nekretninaTipAkcijeResult = await _nekretninaTipAkcijeProvider.get();
      print(nekretninaTipAkcijeResult);
      tipAkcijeResult = await _tipAkcijeProvider.get();
      print(tipAkcijeResult);
      tipoviNekretninaResult = await _tipoviNekretninaProvider.get();
      print(tipoviNekretninaResult);
      lokacijeResult = await _lokacijeProvider.get();
      print(lokacijeResult);
      gradoviResult = await _gradoviProvider.get();
      print(gradoviResult);
      agencijaResult = await _agencijaProvider.get();
      print(agencijaResult);
      korisnikAgencijaResult = await _korisnikAgencijaProvider.get();
      print(korisnikAgencijaResult);
      List<int> nekretnineIdsForProdaja = [];
      print('korisnikIds after initForm: $korisnikIds');
      NadjiKorisnikIds();
      // Iterate through tipAkcije items to find matching nekretninaId values
      for (var nekretninaTipAkcije in nekretninaTipAkcijeResult!.result) {
        if (nekretninaTipAkcije.tipAkcijeId == 2) {
          nekretnineIdsForProdaja.add(nekretninaTipAkcije.nekretninaId!);
        }
      }
      result = await _nekretnineProvider.get(
        filter: {
          'nekretninaId': nekretnineIdsForProdaja,
        },
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  String username = Authorization.username ?? "";
  int? korisnikId() {
    List<dynamic> filteredData = korisniciResult!.result
        .where((korisnik) => korisnik.korisnickoIme == username)
        .toList();
    if (filteredData.isNotEmpty) {
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

  List<int?> NadjiKorisnikIds() {
    for (var entry in korisnikAgencijaResult!.result) {
      print(
          'entry.agencijaId: ${entry.agencijaId}, agencijaId: ${agencijaIdd()}');
      print('Before if condition');
      if (entry.agencijaId == agencijaIdd()) {
        print('Inside if condition');
        print('entry.korisnikId: ${entry.korisnikId}');
        korisnikIds.add(entry.korisnikId);
      }
    }
    print('korisnikIds: $korisnikIds');
    return korisnikIds;
  }

  List<int?> korisnikIds = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista agenata'),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: korisnikIds.length +
                  1, // Dodajte jedan za karticu za dodavanje novog agenta
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Kartica za dodavanje novog agenta
                  return buildAddAgentCard();
                } else {
                  int? korisnikId = korisnikIds[index - 1];
                  return SizedBox(
                    width: 120,
                    height: 120,
                    child: buildAgentCard(korisnikId),
                  );
                }
              },
            ),
    );
  }

  Widget buildAddAgentCard() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DodajAgentaScreen();
          },
        );
      },
      child: const SizedBox(
        width: 120,
        height: 180,
        child: Center(
          child: Icon(
            Icons.add,
            size: 48.0,
            color: Colors.blue,
          ),
        ),
      ),
    );
    /*return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DodajAgentaScreen(),
          ),
        );
      },
      child: SizedBox(
        width: 120,
        height: 180,
        child: Center(
          child: Icon(
            Icons.add,
            size: 48.0,
            color: Colors.blue,
          ),
        ),
      ),
    );*/
  }

  Widget buildAgentCard(int? korisnikId) {
    Korisnik? korisnik =
        korisniciResult!.result.firstWhere((k) => k.korisnikId == korisnikId);

    String bajtovii = korisnik.bajtoviSlike.toString();
    Uint8List bytes = base64.decode(bajtovii ?? '');

    return AgentCard(
      ime: korisnik.ime ?? 'Nepoznato',
      prezime: korisnik.prezime ?? 'Nepoznato',
      telefon: korisnik.telefon ?? 'Nepoznato',
      email: korisnik.email ?? 'Nepoznato',
      brojUspjesnoProdanihNekretnina:
          korisnik.brojUspjesnoProdanihNekretnina ?? 0,
      bytes: bytes,
    );
  }
}

class DodajAgentaScreen extends StatefulWidget {
  Nekretnina? nekretnina;
  Grad? grad;

  DodajAgentaScreen({Key? key, this.nekretnina}) : super(key: key);

  @override
  State<DodajAgentaScreen> createState() => _DodajAgentaScreenState();
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

class _DodajAgentaScreenState extends State<DodajAgentaScreen> {
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
  late KorisniciUlogeProvider _korisniciUlogeProvider;
  late NekretninaAgentiProvider _nekretninaAgentiProvider;
  late KorisnikAgencijaProvider _korisnikAgencijaProvider;
  late AgencijaProvider _agencijaProvider;
  bool isLoading = true;

  SearchResult<Korisnik>? korisniciResult;
  SearchResult<Agencija>? agencijeResult;
  SearchResult<TipNekretnine>? tipoviResult;
  SearchResult<Lokacija>? lokacijeResult;
  SearchResult<KategorijaNekretnine>? kategorijeResult;
  SearchResult<Grad>? gradoviResult;
  SearchResult<Drzava>? drzaveResult;
  SearchResult<Slika>? slikeResult;
  SearchResult<KorisniciUloge>? korisniciUlogeResult;
  SearchResult<NekretninaAgenti>? nekretninaAgentiResult;
  SearchResult<KorisnikAgencija>? korisnikAgencijaResult;
  @override
  void initState() {
    super.initState();

    _initialValue = {
      'cijena': widget.nekretnina?.cijena?.toString(),
      'datumDodavanja': widget.nekretnina?.datumDodavanja.toString(),
      'datumIzmjene': widget.nekretnina?.datumIzmjene?.toString(),
      'isOdobrena': widget.nekretnina?.isOdobrena?.toString(),
      'kategorijaId': widget.nekretnina?.kategorijaId?.toString(),
      'korisnikId': widget.nekretnina?.korisnikId?.toString(),
      'lokacijaId': widget.nekretnina?.lokacijaId?.toString(),
      'tipNekretnineId': widget.nekretnina?.tipNekretnineId?.toString(),
      'nekretninaId': widget.nekretnina?.nekretninaId?.toString(),
      'gradId': lokacija?.gradId.toString(),
      'nekretninaId': widget.nekretnina?.nekretninaId.toString(),
      'korisnikAgentId': agent?.korisnikId.toString(),
      'korisnikAgencijaId': (-1).toString(),
      'agencijaId': (-1).toString(),
    };
    _korisniciUlogeProvider = KorisniciUlogeProvider();
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
    _korisnikAgencijaProvider = context.read<KorisnikAgencijaProvider>();
    _agencijaProvider = context.read<AgencijaProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    try {
      korisniciUlogeResult = await _korisniciUlogeProvider.get();
      print(korisniciUlogeResult);
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
      korisnikAgencijaResult = await _korisnikAgencijaProvider.get();
      print('korisnikAgencijaResult $korisnikAgencijaResult');
      agencijeResult = await _agencijaProvider.get();
      print('agencijeResult $agencijeResult');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error in initForm: $e');
    }
  }

  String convertBytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _formBuild(),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String value) {
    // Define your regex pattern for the phone number format
    final RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{4}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  String selectedAgencijaId = '';

  FormBuilder _formBuild() {
    String username = Authorization.username ?? "";
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const Text(
                "Dodaj agenta",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
              FormBuilderTextField(
                name: 'ime',
                decoration: const InputDecoration(labelText: 'Ime *'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              FormBuilderTextField(
                name: 'prezime',
                decoration: const InputDecoration(labelText: 'Prezime *'),
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email *'),
              ),
              FormBuilderTextField(
                name: 'telefon',
                decoration: const InputDecoration(
                  labelText: 'Telefon *',
                  helperText: 'Format: 000-000-0000',
                  helperStyle:
                      TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
              FormBuilderTextField(
                name: 'korisnickoIme',
                decoration: const InputDecoration(labelText: 'Korisničko ime *'),
              ),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Lozinka *'),
                obscureText: true,
              ),
              FormBuilderTextField(
                name: 'passwordPotvrda',
                decoration: const InputDecoration(labelText: 'Potvrdite lozinku *'),
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Create a request object with form field values
                        Map<String, dynamic> request = {
                          'ime': _formKey.currentState?.fields['ime']?.value,
                          'prezime':
                              _formKey.currentState?.fields['prezime']?.value,
                          'email':
                              _formKey.currentState?.fields['email']?.value,
                          'telefon':
                              _formKey.currentState?.fields['telefon']?.value,
                          'korisnickoIme': _formKey
                              .currentState?.fields['korisnickoIme']?.value,
                          'password':
                              _formKey.currentState?.fields['password']?.value,
                          'passwordPotvrda': _formKey
                              .currentState?.fields['passwordPotvrda']?.value,
                        };
                        List<Korisnik> filteredKorisnici = korisniciResult
                                ?.result
                                .where((korisnik) =>
                                    korisnik.korisnickoIme ==
                                    _formKey.currentState
                                        ?.fields['korisnickoIme']?.value)
                                .toList() ??
                            [];
                        final RegExp phoneRegex =
                            RegExp(r'^\d{3}-\d{3}-\d{4}$');
                        if (filteredKorisnici.isEmpty) {
                          if (phoneRegex.hasMatch(_formKey
                              .currentState?.fields['telefon']?.value)) {
                            Korisnik insertedKorisnik =
                                await _korisniciProvider.insert(request);
                            int? insertedKorisnikId;
                            insertedKorisnikId = insertedKorisnik.korisnikId;
                            _formKey.currentState?.reset();
                          
                            if (insertedKorisnikId != -1) {
                              Map<String, dynamic> ulogeRequest = {
                                'korisnikId': insertedKorisnikId,
                                'ulogaId': 2,
                              };

                              // Call the insert method from korisniciUlogeProvider
                              _korisniciUlogeProvider.insert(ulogeRequest);
                            }

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Potvrda"),
                                  content: SingleChildScrollView(
                                    child: FormBuilderDropdown<String>(
                                      name: 'korisnikAgencijaId',
                                      decoration: InputDecoration(
                                        labelText: 'Agencija*',
                                        suffix: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            _formKey.currentState!
                                                .fields['korisnikAgencijaId']
                                                ?.reset();
                                          },
                                        ),
                                        hintText: 'Odaberite agenciju',
                                      ),
                                      onChanged: (newValue) {
                                        _formKey.currentState
                                            ?.fields['korisnikAgencijaId']
                                            ?.didChange(newValue);
                                        selectedAgencijaId = newValue ?? '';
                                      },
                                      items: agencijeResult?.result
                                              .map((Agencija k) =>
                                                  DropdownMenuItem(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    value:
                                                        k.agencijaId.toString(),
                                                    child: Text(
                                                        k.naziv.toString()),
                                                  ))
                                              .toList() ??
                                          [],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Map<String, dynamic>
                                            korisnikAgencijaRequest = {
                                          'korisnikId': insertedKorisnikId,
                                          'agencijaId': selectedAgencijaId,
                                        };

                                        _korisnikAgencijaProvider
                                            .insert(korisnikAgencijaRequest);

                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListaAgenataScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Upozorenje"),
                                  content: const Text(
                                      "Neispravan format telefona Zahtijevani format je: 000-000-0000"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the alert dialog
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Upozorenje"),
                                content: const Text(
                                    "Korisničko ime već postoji. Molimo odaberite drugo."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the alert dialog
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        //_korisniciProvider.insert(request);
                      },
                      child: const Text('Potvrdi'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'Odustani',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Lokacija? lokacija;
  void getGrad() {
    var lokacijaId = widget.nekretnina?.lokacijaId;
    if (lokacijaId != null &&
        lokacijeResult != null &&
        lokacijeResult?.result != null) {
      lokacija = lokacijeResult?.result.firstWhere(
        (lokacija) => lokacija.lokacijaId == lokacijaId,
      );
    }
  }

  NekretninaAgenti? agent;
  void getAgent() {
    var nekretninaId = widget.nekretnina?.nekretninaId;
    if (nekretninaId != null &&
        nekretninaAgentiResult != null &&
        nekretninaAgentiResult?.result != null) {
      agent = nekretninaAgentiResult?.result.firstWhere(
        (agent) => agent.nekretninaId == nekretninaId,
      );
    }
  }

  File? _image;
  String? _base64Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }

  Widget buildImageColumn(int nekretninaId) {
    return FutureBuilder<SearchResult<Slika>>(
      future: SlikeProvider().get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SearchResult<Slika>? slike = snapshot.data;

          if (slike != null && slike.result.isNotEmpty) {
            return Column(
              children: slike.result
                  .where((slika) => slika.nekretninaId == nekretninaId)
                  .map((slika) {
                print(slika.bajtoviSlike);
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: imageFromBase64String(slika.bajtoviSlike ?? ""),
                );
              }).toList(),
            );
          } else {
            return const Text('Nema slika');
          }
        } else if (snapshot.hasError) {
          return const Text('Greška prilikom dobavljanja slika');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
