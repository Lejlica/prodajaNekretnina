// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reccomendResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReccomendResult _$ReccomendResultFromJson(Map<String, dynamic> json) =>
    ReccomendResult(
      (json['nekretninaId'] as num?)?.toInt(),
      (json['prvaNekretninaId'] as num?)?.toInt(),
      (json['drugaNekretninaId'] as num?)?.toInt(),
      (json['trecaNekretninaId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReccomendResultToJson(ReccomendResult instance) =>
    <String, dynamic>{
      'nekretninaId': instance.nekretninaId,
      'prvaNekretninaId': instance.prvaNekretninaId,
      'drugaNekretninaId': instance.drugaNekretninaId,
      'trecaNekretninaId': instance.trecaNekretninaId,
      'korisnikId': instance.korisnikId,
    };
