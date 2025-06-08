// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nekretninaAgenti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NekretninaAgenti _$NekretninaAgentiFromJson(Map<String, dynamic> json) =>
    NekretninaAgenti(
      (json['nekretninaAgentiID'] as num?)?.toInt(),
      (json['nekretninaId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NekretninaAgentiToJson(NekretninaAgenti instance) =>
    <String, dynamic>{
      'nekretninaAgentiID': instance.nekretninaAgentiID,
      'nekretninaId': instance.nekretninaId,
      'korisnikId': instance.korisnikId,
    };
