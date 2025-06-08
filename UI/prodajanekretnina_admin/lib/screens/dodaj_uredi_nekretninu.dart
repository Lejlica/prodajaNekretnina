import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NekretninaFormScreen extends StatefulWidget {
  @override
  _NekretninaFormScreenState createState() => _NekretninaFormScreenState();
}

class _NekretninaFormScreenState extends State<NekretninaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nazivController = TextEditingController();
  final TextEditingController _kvadraturaController = TextEditingController();
  final TextEditingController _cijenaController = TextEditingController();
  final TextEditingController _detaljanOpisController = TextEditingController();
  final TextEditingController _datumDodavanjaController = TextEditingController();
  final TextEditingController _datumIzmjeneController = TextEditingController();
  final TextEditingController _brojUgovoraController = TextEditingController();
  final TextEditingController _brojSobaController = TextEditingController();
  final TextEditingController _brojSpavacihSobaController = TextEditingController();
  final TextEditingController _spratController = TextEditingController();

  String? _kategorija;
  String? _tipNekretnine;
  String? _tipAkcije;
  String? _vlasnik;
  String? _agent;

  bool _novogradnja = false;
  bool _parking = false;
  bool _namjesten = false;

  Uint8List? _selectedImage;

  final zlatna = Color(0xFFBFA06B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj nekretninu'),
        backgroundColor: zlatna,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 16,
                  children: [
                    _buildWideDropdown('Naziv',controller: _nazivController),
                    _buildWideDropdown('Vlasnik', controller: null, dropdownValue: _vlasnik, onChanged: (val) => setState(() => _vlasnik = val)),
                    _buildWideDropdown('Agent', controller: null, dropdownValue: _agent, onChanged: (val) => setState(() => _agent = val)),
                    _buildTextField(_kvadraturaController, 'Kvadratura', keyboardType: TextInputType.number),
                    _buildTextField(_cijenaController, 'Cijena', keyboardType: TextInputType.number),
                    _buildTextField(_brojUgovoraController, 'Broj ugovora', keyboardType: TextInputType.number),
                    _buildDatePickerField(_datumDodavanjaController, 'Datum dodavanja'),
                    _buildDatePickerField(_datumIzmjeneController, 'Datum izmjene'),
                    _buildTextField(_brojSobaController, 'Broj soba', keyboardType: TextInputType.number),
                    _buildTextField(_brojSpavacihSobaController, 'Broj spavaćih soba', keyboardType: TextInputType.number),
                    _buildTextField(_spratController, 'Sprat', keyboardType: TextInputType.number),
                    _buildDropdown('Kategorija', _kategorija, (val) => setState(() => _kategorija = val)),
                    _buildDropdown('Tip nekretnine', _tipNekretnine, (val) => setState(() => _tipNekretnine = val)),
                    _buildDropdown('Tip akcije', _tipAkcije, (val) => setState(() => _tipAkcije = val)),
                  ],
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCheckbox('Novogradnja', _novogradnja, (val) => setState(() => _novogradnja = val!)),
                    _buildCheckbox('Parking', _parking, (val) => setState(() => _parking = val!)),
                    _buildCheckbox('Namješten', _namjesten, (val) => setState(() => _namjesten = val!)),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _detaljanOpisController,
                      decoration: InputDecoration(
                        labelText: 'Detaljan opis',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 4,
                      validator: (value) => value!.isEmpty ? 'Unesite opis' : null,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Slika nekretnine',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: zlatna),
                    ),
                    SizedBox(height: 8),
                    _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              _selectedImage!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 83, 80, 80),
                            ),
                            child: Icon(Icons.image, size: 60, color: Colors.grey),
                          ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.upload_file),
                      label: Text("Odaberi sliku"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: zlatna,
                        foregroundColor: Colors.black87,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: Icon(Icons.save),
                        label: Text("Sačuvaj"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          backgroundColor: zlatna,
                          foregroundColor: Colors.black87,
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.edit),
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? 'Unesite $label' : null,
      ),
    );
  }

  Widget _buildDatePickerField(TextEditingController controller, String label) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = picked.toLocal().toIso8601String().split('T').first;
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.calendar_today),
        ),
        validator: (value) => value!.isEmpty ? 'Unesite $label' : null,
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, Function(String?) onChanged) {
    return SizedBox(
      width: 250,
      child: DropdownButtonFormField<String>(
        value: value,
        items: ['Opcija 1', 'Opcija 2'].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.list),
        ),
        validator: (value) => value == null ? 'Odaberite $label' : null,
      ),
    );
  }

  Widget _buildWideDropdown(String label, {TextEditingController? controller, String? dropdownValue, Function(String?)? onChanged}) {
    return SizedBox(
      width: 250,
      child: controller != null
          ? TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
              ),
              validator: (value) => value!.isEmpty ? 'Unesite $label' : null,
            )
          : DropdownButtonFormField<String>(
              value: dropdownValue,
              items: ['Opcija 1', 'Opcija 2'].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) => value == null ? 'Odaberite $label' : null,
            ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged, activeColor: zlatna),
        Text(label),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nekretnina uspješno dodana.')),
      );
    }
  }


  File? _image;
  String? _base64Image;
   Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      }
    });
  }
}
