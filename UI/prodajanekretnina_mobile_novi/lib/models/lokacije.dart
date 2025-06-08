import 'package:json_annotation/json_annotation.dart';
part 'lokacije.g.dart';

@JsonSerializable()
class Lokacija {
  int? lokacijaId;
  String? postanskiBroj;
  String? ulica;
  int? gradId;
  int? drzavaId;

  Lokacija(this.lokacijaId, this.postanskiBroj, this.ulica, this.gradId,
      this.drzavaId);
  String toString() {
    return 'Lokacija: lokacijaId=$lokacijaId, postanskiBroj=$postanskiBroj, gradId=$gradId,drzavaId=$drzavaId';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Lokacija.fromJson(Map<String, dynamic> json) =>
      _$LokacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LokacijaToJson(this);
}
