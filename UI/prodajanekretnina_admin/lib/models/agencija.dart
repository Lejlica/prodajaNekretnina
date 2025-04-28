import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';
part 'agencija.g.dart';

@JsonSerializable()
class Agencija {
  int? agencijaId;
  String? naziv;

  String? opis;
  String? logo;
  int? korisnikId;
  String? adresa;
  String? email;
  String? telefon;
  String? kontaktOsoba;
  String? datumDodavanja;
  String? datumAzuriranja;

  Agencija(
      this.agencijaId,
      this.naziv,
      this.opis,
      this.logo,
      this.korisnikId,
      this.adresa,
      this.email,
      this.telefon,
      this.kontaktOsoba,
      this.datumDodavanja,
      this.datumAzuriranja);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Agencija.fromJson(Map<String, dynamic> json) =>
      _$AgencijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AgencijaToJson(this);
}
