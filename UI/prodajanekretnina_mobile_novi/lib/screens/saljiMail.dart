import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrijaviSmetnju extends StatefulWidget {
  final int korisnikId;
  const PrijaviSmetnju({required this.korisnikId});

  @override
  _PrijaviSmetnjuState createState() => _PrijaviSmetnjuState();
}

class _PrijaviSmetnjuState extends State<PrijaviSmetnju> {
  final _emailController = TextEditingController();
  final _opisController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();
  final _opisFormKey = GlobalKey<FormState>();
  final List<String> _emailAdrese = [];

  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

          
              Text(
                    "Posaljte obavijest o problemu agentu nekretnine",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
             

              SizedBox(height: 20),

             
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _emailFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dodaj email adresu agenta", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'primjer@email.com',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Unesite email';
                                  if (!emailRegex.hasMatch(value)) return 'Neispravna email adresa';
                                  return null;
                                },
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFD700),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: _dodajEmail,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

          
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _opisFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Opis problema", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _opisController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Opišite problem s nekretninom...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Unesite opis' : null,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Prikaz unesenih emailova
              if (_emailAdrese.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _emailAdrese.map((email) => Chip(
                    label: Text(email, style: TextStyle(fontSize: 13)),
                    backgroundColor: Color(0xFFFFE57F),
                    deleteIcon: Icon(Icons.close, size: 16),
                    onDeleted: () => _ukloniEmail(email),
                  )).toList(),
                ),

              SizedBox(height: 30),

             
              Center(
                child: ElevatedButton.icon(
                  onPressed: _posalji,
                  icon: Icon(Icons.send, color: Colors.white),
                  label: Text("Pošalji", style: TextStyle(color: Colors.white, fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB8860B),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dodajEmail() {
    if (_emailFormKey.currentState!.validate()) {
      setState(() {
        _emailAdrese.add(_emailController.text.trim());
        _emailController.clear();
      });
    }
  }

  void _ukloniEmail(String email) {
    setState(() {
      _emailAdrese.remove(email);
    });
  }

  void _posalji() {
    if (_opisFormKey.currentState!.validate()) {
      String text = _opisController.text;
      posaljiEmail(context, text, _emailAdrese);
    }
  }

  Future<String> posaljiEmail(BuildContext context, String text, List<String> adrese) async {
    String link = "http://10.0.2.2:7188/SendEmail/MailPublisher?poruka=${Uri.encodeComponent(text)}";
    for (var adr in adrese) {
      link += "&sendTo=${Uri.encodeComponent(adr)}";
    }

    var uri = Uri.parse(link);
    var response = await http.get(uri);

    if (_isValidResponse(response)) {
      _opisController.clear();
      setState(() => _emailAdrese.clear());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uspješno poslano"), backgroundColor: Colors.green));
      return response.body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Greška pri slanju"), backgroundColor: Colors.red));
      return "";
    }
  }

  bool _isValidResponse(http.Response response) {
    print('STATUS KOD: ${response.statusCode}');
    print('ODGOVOR: ${response.body}');
    if (response.statusCode < 299) return true;
    if (response.statusCode == 500) throw Exception("Neuspjelo slanje");
    throw Exception("Serverska greška.");
  }
}
