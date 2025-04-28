// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agencija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agencija _$AgencijaFromJson(Map<String, dynamic> json) => Agencija(
      json['agencijaId'] as int?,
      json['naziv'] as String?,
      json['opis'] as String?,
      json['logo'] as String?,
      json['korisnikId'] as int?,
      json['adresa'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['kontaktOsoba'] as String?,
      json['datumDodavanja'] as String?,
      json['datumAzuriranja'] as String?,
    );

Map<String, dynamic> _$AgencijaToJson(Agencija instance) => <String, dynamic>{
      'agencijaId': instance.agencijaId,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'logo': instance.logo,
      'korisnikId': instance.korisnikId,
      'adresa': instance.adresa,
      'email': instance.email,
      'telefon': instance.telefon,
      'kontaktOsoba': instance.kontaktOsoba,
      'datumDodavanja': instance.datumDodavanja,
      'datumAzuriranja': instance.datumAzuriranja,
    };
