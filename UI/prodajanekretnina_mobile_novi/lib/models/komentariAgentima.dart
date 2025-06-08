import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';
part 'komentariAgentima.g.dart';

@JsonSerializable()
class KomentariAgentima {
  int? komentariAgentimaId;
  String? sadrzaj;
  String? datum;
  int? korisnikId;
  int? kupacId;

  KomentariAgentima(
    this.komentariAgentimaId,
    this.sadrzaj,
    this.datum,
    this.korisnikId,
    this.kupacId,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory KomentariAgentima.fromJson(Map<String, dynamic> json) =>
      _$KomentariAgentimaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KomentariAgentimaToJson(this);
}
