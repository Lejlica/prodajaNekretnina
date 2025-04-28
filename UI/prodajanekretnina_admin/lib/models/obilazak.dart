import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'obilazak.g.dart';

@JsonSerializable()
class Obilazak {
  int? obilazakId;
  DateTime? datumObilaska;
  DateTime? vrijemeObilaska;
  int? nekretninaId;
  int? korisnikId;
  bool? isOdobren;

  Obilazak(
    this.obilazakId,
    this.datumObilaska,
    this.vrijemeObilaska,
    this.nekretninaId,
    this.korisnikId,
    this.isOdobren,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Obilazak.fromJson(Map<String, dynamic> json) =>
      _$ObilazakFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ObilazakToJson(this);
}
