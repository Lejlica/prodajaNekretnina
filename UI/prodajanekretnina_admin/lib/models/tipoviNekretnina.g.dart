// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipoviNekretnina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipNekretnine _$TipNekretnineFromJson(Map<String, dynamic> json) =>
    TipNekretnine(
      json['tipNekretnineId'] as int?,
      json['nazivTipa'] as String?,
      json['opisTipa'] as String?,
    );

Map<String, dynamic> _$TipNekretnineToJson(TipNekretnine instance) =>
    <String, dynamic>{
      'tipNekretnineId': instance.tipNekretnineId,
      'nazivTipa': instance.nazivTipa,
      'opisTipa': instance.opisTipa,
    };
