// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kupci.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kupci _$KupciFromJson(Map<String, dynamic> json) => Kupci(
      json['kupacId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['datumRegistracije'] as String?,
      json['email'] as String?,
      json['korisnickoIme'] as String?,
      json['status'] as bool?,
      json['clientId'] as String?,
      json['clientSecret'] as String?,
    );

Map<String, dynamic> _$KupciToJson(Kupci instance) => <String, dynamic>{
      'kupacId': instance.kupacId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRegistracije': instance.datumRegistracije,
      'email': instance.email,
      'korisnickoIme': instance.korisnickoIme,
      'status': instance.status,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };
