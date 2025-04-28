// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slika _$SlikaFromJson(Map<String, dynamic> json) => Slika(
      json['slikaId'] as int?,
      json['bajtoviSlike'] as String?,
      json['nekretninaId'] as int?,
    );

Map<String, dynamic> _$SlikaToJson(Slika instance) => <String, dynamic>{
      'slikaId': instance.slikaId,
      'bajtoviSlike': instance.bajtoviSlike,
      'nekretninaId': instance.nekretninaId,
    };
