// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reccomendResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReccomendResult _$ReccomendResultFromJson(Map<String, dynamic> json) =>
    ReccomendResult(
      json['nekretninaId'] as int?,
      json['prvaNekretninaId'] as int?,
      json['drugaNekretninaId'] as int?,
      json['trecaNekretninaId'] as int?,
      json['korisnikId'] as int?,
    );

Map<String, dynamic> _$ReccomendResultToJson(ReccomendResult instance) =>
    <String, dynamic>{
      'nekretninaId': instance.nekretninaId,
      'prvaNekretninaId': instance.prvaNekretninaId,
      'drugaNekretninaId': instance.drugaNekretninaId,
      'trecaNekretninaId': instance.trecaNekretninaId,
      'korisnikId': instance.korisnikId,
    };
