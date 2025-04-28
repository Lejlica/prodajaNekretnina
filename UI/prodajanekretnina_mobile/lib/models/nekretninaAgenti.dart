import 'package:json_annotation/json_annotation.dart';
part 'nekretninaAgenti.g.dart';

@JsonSerializable()
class NekretninaAgenti {
  int? nekretninaAgentiID;
  final int? nekretninaId;
  final int? korisnikId;

  NekretninaAgenti(this.nekretninaAgentiID, this.nekretninaId, this.korisnikId);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory NekretninaAgenti.fromJson(Map<String, dynamic> json) =>
      _$NekretninaAgentiFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NekretninaAgentiToJson(this);
}
