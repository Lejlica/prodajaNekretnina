import 'package:json_annotation/json_annotation.dart';
part 'drzave.g.dart';

@JsonSerializable()
class Drzava {
  int? drzavaId;
  String? naziv;

  Drzava(
    this.drzavaId,
    this.naziv,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Drzava.fromJson(Map<String, dynamic> json) => _$DrzavaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DrzavaToJson(this);
}
