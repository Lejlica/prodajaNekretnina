import 'package:json_annotation/json_annotation.dart';
part 'slike.g.dart';

@JsonSerializable()
class Slika {
  int? slikaId;
  String? bajtoviSlike;
  int? nekretninaId;

  Slika(
    this.slikaId,
    this.bajtoviSlike,
    this.nekretninaId,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Slika.fromJson(Map<String, dynamic> json) => _$SlikaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SlikaToJson(this);
}
