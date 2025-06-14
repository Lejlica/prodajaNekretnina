import 'package:json_annotation/json_annotation.dart';
part 'korisnici_uloge.g.dart';

@JsonSerializable()
class KorisniciUloge {
  int? korisnikUlogaId;
  int? korisnikId;
  int? ulogaId;
  String? datumIzmjene;

  KorisniciUloge(
    this.korisnikUlogaId,
    this.korisnikId,
    this.ulogaId,
    this.datumIzmjene,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory KorisniciUloge.fromJson(Map<String, dynamic> json) =>
      _$KorisniciUlogeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisniciUlogeToJson(this);
}
