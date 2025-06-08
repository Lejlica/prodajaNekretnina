import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/agencija.dart';
import 'package:prodajanekretnina_admin/models/korisnikAgencija.dart';
import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart';
import 'package:prodajanekretnina_admin/models/nekretnine.dart';
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
import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/providers/agencije_provider.dart';
import 'package:prodajanekretnina_admin/providers/lokacije_provider.dart';
import 'package:prodajanekretnina_admin/providers/gradovi_provider.dart';
import 'package:prodajanekretnina_admin/providers/tipoviNekretnina_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../utils/util.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/models/kategorijeNekretnina.dart';
import 'package:flutter/services.dart';
import 'package:prodajanekretnina_admin/models/korisnici_uloge.dart';
import 'package:prodajanekretnina_admin/providers/drzave_provide.dart';
import 'package:prodajanekretnina_admin/providers/kategorijeNekretnina_provider.dart';
import 'package:prodajanekretnina_admin/providers/korisnici_uloge_provider.dart';

class AgentCard extends StatelessWidget {
  final String ime;
  final String prezime;
  final String telefon;
  final String email;
  final int brojUspjesnoProdanihNekretnina;
  final String bajtoviSlike; // Slika agenta

  const AgentCard({super.key, 
    required this.ime,
    required this.prezime,
    required this.telefon,
    required this.email,
    required this.brojUspjesnoProdanihNekretnina,
    required this.bajtoviSlike,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    try {
      if (bajtoviSlike.isNotEmpty) {
        imageBytes = Uint8List.fromList(base64.decode(bajtoviSlike));
      }
    } catch (e) {
      print('Greška prilikom dekodiranja slike: $e');
    }
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
             CircleAvatar(
              radius: 50,
              backgroundImage: imageBytes != null && imageBytes.isNotEmpty
                  ? MemoryImage(imageBytes)
                  : null,
              child: imageBytes == null || imageBytes.isEmpty
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 10),
            Text(
              '$ime $prezime',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 41, 40, 41)
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Telefon: $telefon',
              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 41, 40, 41)),
            ),
            const SizedBox(height: 5),
            Text(
              'E-mail: $email',
              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 41, 40, 41)),
            ),
            const SizedBox(height: 5),
            Text(
              'Prodane nekretnine: $brojUspjesnoProdanihNekretnina',
              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 41, 40, 41)),
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
      NadjiKojojAgencijiPripadaKorisnik();
      NadjiKorisnikIds();
     
      print('korisnikIds after initForm: $korisnikIds');
      
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

  List<int?> NadjiKorisnikIds() {
    for (var entry in korisnikAgencijaResult!.result) {
      print(
          'entry.agencijaId: ${entry.agencijaId}, agencijaId: ${agencijaIdd()}');
      print('Before if condition');
      if (entry.agencijaId == pripadajucaAgencija) {
        print('Inside if condition');
        print('entry.korisnikId: ${entry.korisnikId}');
        korisnikIds.add(entry.korisnikId);
      }
    }
    print('korisnikIds: $korisnikIds');
    return korisnikIds;
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
  List<int?> korisnikIds = [];
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Lista agenata'),
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: korisnikIds.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildAddAgentCard();
              } else {
                int? korisnikId = korisnikIds[index - 1];
               return Container(
  
  margin: const EdgeInsets.all(8),
  
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(243, 238, 166, 0.749),
          Color.fromARGB(255, 96, 72, 16),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: buildAgentCard(korisnikId),
  
);

              }
            },
          ),
  );
}

 Widget buildAddAgentCard() {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DodajAgentaScreen();
        },
      );
    },
    child: Container(
      width: 120,
      height: 180,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24, // manji krug
            child: Icon(Icons.add, size: 24, color: Colors.blue),
            backgroundColor: Color(0xFFE0E0E0),
          ),
          SizedBox(height: 10),
          Text(
            'Dodaj agenta',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}


 
  Widget buildAgentCard(int? korisnikId) {
    String bajtovii;
  Korisnik? korisnik = korisniciResult!.result.firstWhere((k) => k.korisnikId == korisnikId);


  return AgentCard(
    ime: korisnik.ime ?? 'Nepoznato',
    prezime: korisnik.prezime ?? 'Nepoznato',
    telefon: korisnik.telefon ?? 'Nepoznato',
    email: korisnik.email ?? 'Nepoznato',
    brojUspjesnoProdanihNekretnina: korisnik.brojUspjesnoProdanihNekretnina ?? 0,
    bajtoviSlike: korisnik!.bajtoviSlike.toString(),
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



class _DodajAgentaScreenState extends State<DodajAgentaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  String? selectedImagePath;
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
      korisnikId();
      NadjiKojojAgencijiPripadaKorisnik();
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
FormBuilder _formBuild(){
return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dodaj agenta",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              
              // Ime sa ikonom
              FormBuilderTextField(
                name: 'ime',
                decoration: InputDecoration(
                  labelText: 'Ime *',
                  prefixIcon: const Icon(Icons.person),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite ime';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Prezime sa ikonom
              FormBuilderTextField(
                name: 'prezime',
                decoration: InputDecoration(
                  labelText: 'Prezime *',
                  prefixIcon: const Icon(Icons.person_outline),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite prezime';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Email sa ikonom
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(
                  labelText: 'Email *',
                  prefixIcon: const Icon(Icons.email),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Telefon sa ikonom
              FormBuilderTextField(
                name: 'telefon',
                decoration: InputDecoration(
                  labelText: 'Telefon *',
                  helperText: '061123456 ili 061-123-4567',
                  helperStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  prefixIcon: const Icon(Icons.phone),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite telefon';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Korisničko ime sa ikonom
              FormBuilderTextField(
                name: 'korisnickoIme',
                decoration: InputDecoration(
                  labelText: 'Korisničko ime *',
                  prefixIcon: const Icon(Icons.account_circle),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite korisnicko ime';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),

              // Slikovni input
              FormBuilderField(
                name: 'imageId',
                builder: (field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                     
                      errorText: field.errorText,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text(
                            "Odaberite sliku",
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: const Icon(Icons.file_upload),
                          onTap: () async {
                            selectedImagePath = await pickAndEncodeImage();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // Lozinka sa ikonom
              FormBuilderTextField(
                name: 'password',
                decoration: InputDecoration(
                  labelText: 'Lozinka *',
                  prefixIcon: const Icon(Icons.lock),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite lozinku';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // Potvrda lozinke sa ikonom
              FormBuilderTextField(
                name: 'passwordPotvrda',
                decoration: InputDecoration(
                  labelText: 'Potvrdite lozinku *',
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo potvrdite lozinku';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 25),

              // Potvrdi i Odustani dugme
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
  onPressed: () async {
    // Validate the form before proceeding
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // If form is valid, create a request object with form field values
      Map<String, dynamic> request = {
        'ime': _formKey.currentState?.fields['ime']?.value,
        'prezime': _formKey.currentState?.fields['prezime']?.value,
        'email': _formKey.currentState?.fields['email']?.value,
        'telefon': _formKey.currentState?.fields['telefon']?.value,
        'korisnickoIme': _formKey.currentState?.fields['korisnickoIme']?.value,
        'password': _formKey.currentState?.fields['password']?.value,
        'passwordPotvrda': _formKey.currentState?.fields['passwordPotvrda']?.value,
      };

      // Add image data if available
      if (selectedImagePath != null && selectedImagePath!.isNotEmpty) {
        request['bajtoviSlike'] = selectedImagePath;
      }

      // Check if the username already exists
      List<Korisnik> filteredKorisnici = korisniciResult
          ?.result
          .where((korisnik) =>
              korisnik.korisnickoIme == _formKey.currentState?.fields['korisnickoIme']?.value)
          .toList() ?? [];

      final RegExp phoneRegex = RegExp(r'^(\+387)?[- ]?(\d{2,3})[- ]?(\d{3})[- ]?(\d{3,4})$');
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');


      if (filteredKorisnici.isEmpty) {
        final String? phone = _formKey.currentState?.fields['telefon']?.value;
  final String? email = _formKey.currentState?.fields['email']?.value;

  // 1. Provjera telefona
  if (!phoneRegex.hasMatch(phone ?? '')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Upozorenje"),
          content: const Text("Neispravan format telefona. Dozvoljeno: 061123456 ili +387-61-123-456."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    return;
  }

  // 2. Provjera emaila
  if (!emailRegex.hasMatch(email ?? '')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Upozorenje"),
          content: const Text("Neispravan format email adrese."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    return;
  }


  Korisnik insertedKorisnik = await _korisniciProvider.insert(request);
  int? insertedKorisnikId = insertedKorisnik.korisnikId;
  _formKey.currentState?.reset();

  if (insertedKorisnikId != -1) {
    Map<String, dynamic> ulogeRequest = {
      'korisnikId': insertedKorisnikId,
      'ulogaId': 2,
    };

    _korisniciUlogeProvider.insert(ulogeRequest);
  }

  Map<String, dynamic> korisnikAgencijaRequest = {
    'korisnikId': insertedKorisnikId,
    'agencijaId': pripadajucaAgencija,
  };

  _korisnikAgencijaProvider.insert(korisnikAgencijaRequest);

  showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text("Uspjeh"),
      content: const Text("Korisnik je uspješno dodan."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Zatvori AlertDialog
            Navigator.of(context).pop(); // Zatvori trenutni ekran
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ListaAgenataScreen(),
              ),
            );
          },
          child: const Text("U redu"),
        ),
      ],
    );
  },
);
  
        
      } else {
        // Show username exists error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Upozorenje"),
              content: const Text("Korisničko ime već postoji. Molimo odaberite drugo."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } else {
      // If form is invalid, show a validation error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Upozorenje"),
            content: const Text("Molimo ispunite sva obavezna polja i provjerite da li se lozinke poklapaju"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  },
  child: const Text('Potvrdi'),
)
,
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
    );}
 

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
File? _image;
  String? _base64Image;
  Future<String> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Read the file as bytes
      Uint8List imageBytes = await pickedFile.readAsBytes();

      // Convert the bytes to base64
      String base64Image = base64Encode(imageBytes);
      setState(() {
        _image = File(pickedFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
            });
      return base64Image.toString();
    } else {
      print('No image selected.');
      return ''; // or handle accordingly
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
