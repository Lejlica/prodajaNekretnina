// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnikAgencija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikAgencija _$KorisnikAgencijaFromJson(Map<String, dynamic> json) =>
    KorisnikAgencija(
      (json['korisnikAgencijaId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      (json['agencijaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KorisnikAgencijaToJson(KorisnikAgencija instance) =>
    <String, dynamic>{
      'korisnikAgencijaId': instance.korisnikAgencijaId,
      'korisnikId': instance.korisnikId,
      'agencijaId': instance.agencijaId,
    };
