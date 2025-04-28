import 'package:json_annotation/json_annotation.dart';
import 'dart:ffi';
part 'kupci.g.dart';

@JsonSerializable()
class Kupci {
  int? kupacId;
  String? ime;
  String? prezime;
  String? datumRegistracije;
  String? email;
  String? korisnickoIme;
  bool? status;
  String? clientId;
  String? clientSecret;

  Kupci(
      this.kupacId,
      this.ime,
      this.prezime,
      this.datumRegistracije,
      this.email,
      this.korisnickoIme,
      this.status,
      this.clientId,
      this.clientSecret);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Kupci.fromJson(Map<String, dynamic> json) => _$KupciFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KupciToJson(this);
}
