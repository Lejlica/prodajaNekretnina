import 'package:json_annotation/json_annotation.dart';
part 'kategorijeNekretnina.g.dart';

@JsonSerializable()
class KategorijaNekretnine {
  int? kategorijaId;
  String? naziv;
  String? opis;

  KategorijaNekretnine(
    this.kategorijaId,
    this.naziv,
    this.opis,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory KategorijaNekretnine.fromJson(Map<String, dynamic> json) =>
      _$KategorijaNekretnineFromJson(json);
  /*factory KategorijaNekretnine.fromJson(Map<String, dynamic> json) {
    return KategorijaNekretnine(
      kategorijaId: json['kategorijaId'] as int,
      naziv: json['naziv'] as String,
      opis: json['opis'] as String,
    );
  }
*/
  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KategorijaNekretnineToJson(this);
}
