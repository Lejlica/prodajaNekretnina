import 'package:json_annotation/json_annotation.dart';
part 'tipoviNekretnina.g.dart';

@JsonSerializable()
class TipNekretnine {
  int? tipNekretnineId;
  String? nazivTipa;
  String? opisTipa;

  TipNekretnine(this.tipNekretnineId, this.nazivTipa, this.opisTipa);
  @override
  String toString() {
    return nazivTipa ??
        ''; // Vratite odgovarajući naziv tipa ili prazan string ako je null.
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TipNekretnine.fromJson(Map<String, dynamic> json) =>
      _$TipNekretnineFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TipNekretnineToJson(this);
}
