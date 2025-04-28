import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'problemi.g.dart';

@JsonSerializable()
class Problem {
  int? problemId;
  String? opis;
  String? datumPrijave;
  bool? isVecPrijavljen;
  String? datumNastankaProblema;
  String? datumRjesenja;
  String? opisRjesenja;
  int? korisnikId;
  int? nekretninaId;
  int? statusId;

  Problem(
    this.problemId,
    this.opis,
    this.datumPrijave,
    this.isVecPrijavljen,
    this.datumNastankaProblema,
    this.datumRjesenja,
    this.opisRjesenja,
    this.korisnikId,
    this.nekretninaId,
    this.statusId,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ProblemToJson(this);
}
