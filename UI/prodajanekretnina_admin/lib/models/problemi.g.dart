// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problemi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Problem _$ProblemFromJson(Map<String, dynamic> json) => Problem(
      json['problemId'] as int?,
      json['opis'] as String?,
      json['datumPrijave'] as String?,
      json['isVecPrijavljen'] as bool?,
      json['datumNastankaProblema'] as String?,
      json['datumRjesenja'] as String?,
      json['opisRjesenja'] as String?,
      json['korisnikId'] as int?,
      json['nekretninaId'] as int?,
      json['statusId'] as int?,
    );

Map<String, dynamic> _$ProblemToJson(Problem instance) => <String, dynamic>{
      'problemId': instance.problemId,
      'opis': instance.opis,
      'datumPrijave': instance.datumPrijave,
      'isVecPrijavljen': instance.isVecPrijavljen,
      'datumNastankaProblema': instance.datumNastankaProblema,
      'datumRjesenja': instance.datumRjesenja,
      'opisRjesenja': instance.opisRjesenja,
      'korisnikId': instance.korisnikId,
      'nekretninaId': instance.nekretninaId,
      'statusId': instance.statusId,
    };
