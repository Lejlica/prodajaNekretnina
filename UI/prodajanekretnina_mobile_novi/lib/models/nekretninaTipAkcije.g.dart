// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nekretninaTipAkcije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NekretninaTipAkcije _$NekretninaTipAkcijeFromJson(Map<String, dynamic> json) =>
    NekretninaTipAkcije(
      (json['nekretninaTipAkcijeId'] as num?)?.toInt(),
      (json['nekretninaId'] as num?)?.toInt(),
      (json['tipAkcijeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NekretninaTipAkcijeToJson(
  NekretninaTipAkcije instance,
) => <String, dynamic>{
  'nekretninaTipAkcijeId': instance.nekretninaTipAkcijeId,
  'nekretninaId': instance.nekretninaId,
  'tipAkcijeId': instance.tipAkcijeId,
};
