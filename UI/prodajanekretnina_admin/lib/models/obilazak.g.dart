// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obilazak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obilazak _$ObilazakFromJson(Map<String, dynamic> json) => Obilazak(
      json['obilazakId'] as int?,
      json['datumObilaska'] == null
          ? null
          : DateTime.parse(json['datumObilaska'] as String),
      json['vrijemeObilaska'] == null
          ? null
          : DateTime.parse(json['vrijemeObilaska'] as String),
      json['nekretninaId'] as int?,
      json['korisnikId'] as int?,
      json['isOdobren'] as bool?,
    );

Map<String, dynamic> _$ObilazakToJson(Obilazak instance) => <String, dynamic>{
      'obilazakId': instance.obilazakId,
      'datumObilaska': instance.datumObilaska?.toIso8601String(),
      'vrijemeObilaska': instance.vrijemeObilaska?.toIso8601String(),
      'nekretninaId': instance.nekretninaId,
      'korisnikId': instance.korisnikId,
      'isOdobren': instance.isOdobren,
    };
