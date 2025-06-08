import 'package:json_annotation/json_annotation.dart';
part 'korisnikAgencija.g.dart';

@JsonSerializable()
class KorisnikAgencija {
  int? korisnikAgencijaId;
  int? korisnikId;
  int? agencijaId;

  KorisnikAgencija(
    this.korisnikAgencijaId,
    this.korisnikId,
    this.agencijaId,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory KorisnikAgencija.fromJson(Map<String, dynamic> json) =>
      _$KorisnikAgencijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikAgencijaToJson(this);
}
