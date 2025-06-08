// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentariAgentima.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomentariAgentima _$KomentariAgentimaFromJson(Map<String, dynamic> json) =>
    KomentariAgentima(
      (json['komentariAgentimaId'] as num?)?.toInt(),
      json['sadrzaj'] as String?,
      json['datum'] as String?,
      (json['korisnikId'] as num?)?.toInt(),
      (json['kupacId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KomentariAgentimaToJson(KomentariAgentima instance) =>
    <String, dynamic>{
      'komentariAgentimaId': instance.komentariAgentimaId,
      'sadrzaj': instance.sadrzaj,
      'datum': instance.datum,
      'korisnikId': instance.korisnikId,
      'kupacId': instance.kupacId,
    };
