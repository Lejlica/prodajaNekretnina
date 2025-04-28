// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lokacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lokacija _$LokacijaFromJson(Map<String, dynamic> json) => Lokacija(
      json['lokacijaId'] as int?,
      json['postanskiBroj'] as String?,
      json['ulica'] as String?,
      json['gradId'] as int?,
      json['drzavaId'] as int?,
    );

Map<String, dynamic> _$LokacijaToJson(Lokacija instance) => <String, dynamic>{
      'lokacijaId': instance.lokacijaId,
      'postanskiBroj': instance.postanskiBroj,
      'ulica': instance.ulica,
      'gradId': instance.gradId,
      'drzavaId': instance.drzavaId,
    };
