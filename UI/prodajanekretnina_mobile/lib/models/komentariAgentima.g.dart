// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentariAgentima.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomentariAgentima _$KomentariAgentimaFromJson(Map<String, dynamic> json) =>
    KomentariAgentima(
      json['komentariAgentimaId'] as int?,
      json['sadrzaj'] as String?,
      json['datum'] as String?,
      json['korisnikId'] as int?,
      json['kupacId'] as int?,
    );

Map<String, dynamic> _$KomentariAgentimaToJson(KomentariAgentima instance) =>
    <String, dynamic>{
      'komentariAgentimaId': instance.komentariAgentimaId,
      'sadrzaj': instance.sadrzaj,
      'datum': instance.datum,
      'korisnikId': instance.korisnikId,
      'kupacId': instance.kupacId,
    };
