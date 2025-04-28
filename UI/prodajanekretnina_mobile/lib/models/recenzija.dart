import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'recenzija.g.dart';

@JsonSerializable()
class Recenzija {
  int? recenzijaId;
  num? vrijednostZvjezdica;
  int? kupacId;
  int? korisnikId;

  Recenzija(
    this.recenzijaId,
    this.vrijednostZvjezdica,
    this.kupacId,
    this.korisnikId,
  );
  @override
  String toString() {
    return 'Obilazak(nekretninaId: $recenzijaId, datumObilaska: $vrijednostZvjezdica, vrijemeObilaska: $kupacId';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Recenzija.fromJson(Map<String, dynamic> json) =>
      _$RecenzijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RecenzijaToJson(this);
}
