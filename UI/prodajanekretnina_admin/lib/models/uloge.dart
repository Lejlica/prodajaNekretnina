import 'package:json_annotation/json_annotation.dart';
part 'uloge.g.dart';

@JsonSerializable()
class Uloge {
  int? ulogaId;
  String? naziv;
  String? opis;

  Uloge(this.ulogaId, this.naziv, this.opis);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Uloge.fromJson(Map<String, dynamic> json) => _$UlogeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UlogeToJson(this);
}
