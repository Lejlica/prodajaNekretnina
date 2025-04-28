import 'package:json_annotation/json_annotation.dart';

import 'package:prodajanekretnina_mobile/models/nekretnine.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'nekretnine.g.dart';

@JsonSerializable()
class Nekretnina {
  int? nekretninaId;
  bool? isOdobrena;
  int? korisnikId;
  int? tipNekretnineId;
  int? kategorijaId;
  int? lokacijaId;
  String? datumDodavanja;
  String? datumIzmjene;
  double? cijena;
  String? stateMachine;
  int? kvadratura;
  String? naziv;
  int? brojSoba;
  int? brojSpavacihSoba;
  bool? namjesten;
  bool? novogradnja;
  int? sprat;
  bool? parkingMjesto;
  int? brojUgovora;
  String? detaljanOpis;

  Nekretnina(
    this.nekretninaId,
    this.isOdobrena,
    this.korisnikId,
    this.tipNekretnineId,
    this.kategorijaId,
    this.lokacijaId,
    this.datumDodavanja,
    this.datumIzmjene,
    this.cijena,
    this.stateMachine,
    this.kvadratura,
    this.naziv,
    this.brojSoba,
    this.brojSpavacihSoba,
    this.namjesten,
    this.novogradnja,
    this.sprat,
    this.parkingMjesto,
    this.brojUgovora,
    this.detaljanOpis,
  );
  @override
  String toString() {
    return 'Nekretnina(nekretninaId: $nekretninaId, kategorijaId: $kategorijaId, tipNekretnineId: $tipNekretnineId, lokacijaId: $lokacijaId, cijena: $cijena)';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Nekretnina.fromJson(Map<String, dynamic> json) =>
      _$NekretninaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NekretninaToJson(this);
}
