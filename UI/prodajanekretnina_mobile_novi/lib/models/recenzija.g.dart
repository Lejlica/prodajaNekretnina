// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzija _$RecenzijaFromJson(Map<String, dynamic> json) => Recenzija(
  (json['recenzijaId'] as num?)?.toInt(),
  json['vrijednostZvjezdica'] as num?,
  (json['kupacId'] as num?)?.toInt(),
  (json['korisnikId'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecenzijaToJson(Recenzija instance) => <String, dynamic>{
  'recenzijaId': instance.recenzijaId,
  'vrijednostZvjezdica': instance.vrijednostZvjezdica,
  'kupacId': instance.kupacId,
  'korisnikId': instance.korisnikId,
};
