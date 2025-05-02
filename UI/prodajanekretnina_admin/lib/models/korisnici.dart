import 'package:json_annotation/json_annotation.dart';
part 'korisnici.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  String? password;
  String? passwordPotvrda;
  int? brojUspjesnoProdanihNekretnina;
  String? bajtoviSlike;

  Korisnik(
      this.korisnikId,
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.password,
      this.passwordPotvrda,
      this.brojUspjesnoProdanihNekretnina,
      this.bajtoviSlike);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
