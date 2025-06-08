import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'kupovina.g.dart';

@JsonSerializable()
class Kupovina {
  int kupovinaId;
  int? nekretninaId;
  int? korisnikId;
  double price;
  bool isPaid;
  bool isConfirmed;
  String? payPalPaymentId;

  Kupovina({
    required this.kupovinaId,
    this.nekretninaId,
    this.korisnikId,
    required this.price,
    required this.isPaid,
    required this.isConfirmed,
    this.payPalPaymentId,
  });
  @override
  String toString() {
    return 'Kupovina(kupovinaId: $kupovinaId, nekretninaId: $nekretninaId, korisnikId: $korisnikId';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Kupovina.fromJson(Map<String, dynamic> json) =>
      _$KupovinaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KupovinaToJson(this);
}
