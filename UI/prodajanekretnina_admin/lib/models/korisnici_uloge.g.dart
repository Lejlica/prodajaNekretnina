// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici_uloge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisniciUloge _$KorisniciUlogeFromJson(Map<String, dynamic> json) =>
    KorisniciUloge(
      json['korisnikUlogaId'] as int?,
      json['korisnikId'] as int?,
      json['ulogaId'] as int?,
      json['datumIzmjene'] as String?,
    );

Map<String, dynamic> _$KorisniciUlogeToJson(KorisniciUloge instance) =>
    <String, dynamic>{
      'korisnikUlogaId': instance.korisnikUlogaId,
      'korisnikId': instance.korisnikId,
      'ulogaId': instance.ulogaId,
      'datumIzmjene': instance.datumIzmjene,
    };
