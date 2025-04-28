// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradovi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grad _$GradFromJson(Map<String, dynamic> json) => Grad(
      json['gradId'] as int?,
      json['naziv'] as String?,
      json['drzavaId'] as int?,
    );

Map<String, dynamic> _$GradToJson(Grad instance) => <String, dynamic>{
      'gradId': instance.gradId,
      'naziv': instance.naziv,
      'drzavaId': instance.drzavaId,
    };
