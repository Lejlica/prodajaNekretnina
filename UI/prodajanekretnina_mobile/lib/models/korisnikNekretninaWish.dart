import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';
part 'korisnikNekretninaWish.g.dart';

@JsonSerializable()
class KorisnikNekretninaWish {
  int? korisnikNekretninaWishId;
  int? korisnikId;
  int? nekretninaId;

  KorisnikNekretninaWish(
    this.korisnikNekretninaWishId,
    this.korisnikId,
    this.nekretninaId,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory KorisnikNekretninaWish.fromJson(Map<String, dynamic> json) =>
      _$KorisnikNekretninaWishFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikNekretninaWishToJson(this);
}
