import 'package:json_annotation/json_annotation.dart';



/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnikUloge.g.dart';

@JsonSerializable()
class KorisnikUloge {
  int? korisnikUlogaId;
  bool? korisnikId;
  int? ulogaId;
  String? datumIzmjene;

  KorisnikUloge(
    this.korisnikUlogaId,
    this.korisnikId,
    this.ulogaId,
    this.datumIzmjene,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory KorisnikUloge.fromJson(Map<String, dynamic> json) =>
      _$KorisnikUlogeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikUlogeToJson(this);
}
