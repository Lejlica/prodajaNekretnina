// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lokacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lokacija _$LokacijaFromJson(Map<String, dynamic> json) => Lokacija(
  (json['lokacijaId'] as num?)?.toInt(),
  json['postanskiBroj'] as String?,
  json['ulica'] as String?,
  (json['gradId'] as num?)?.toInt(),
  (json['drzavaId'] as num?)?.toInt(),
);

Map<String, dynamic> _$LokacijaToJson(Lokacija instance) => <String, dynamic>{
  'lokacijaId': instance.lokacijaId,
  'postanskiBroj': instance.postanskiBroj,
  'ulica': instance.ulica,
  'gradId': instance.gradId,
  'drzavaId': instance.drzavaId,
};
