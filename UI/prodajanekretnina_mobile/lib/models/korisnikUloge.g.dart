// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnikUloge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikUloge _$KorisnikUlogeFromJson(Map<String, dynamic> json) =>
    KorisnikUloge(
      json['korisnikUlogaId'] as int?,
      json['korisnikId'] as bool?,
      json['ulogaId'] as int?,
      json['datumIzmjene'] as String?,
    );

Map<String, dynamic> _$KorisnikUlogeToJson(KorisnikUloge instance) =>
    <String, dynamic>{
      'korisnikUlogaId': instance.korisnikUlogaId,
      'korisnikId': instance.korisnikId,
      'ulogaId': instance.ulogaId,
      'datumIzmjene': instance.datumIzmjene,
    };
