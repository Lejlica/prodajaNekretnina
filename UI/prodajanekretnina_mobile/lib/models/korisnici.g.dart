// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      json['korisnikId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['korisnickoIme'] as String?,
      json['password'] as String?,
      json['passwordPotvrda'] as String?,
      json['brojUspjesnoProdanihNekretnina'] as int?,
      json['rejtingKupaca'] as num?,
      json['bajtoviSlike'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'password': instance.password,
      'passwordPotvrda': instance.passwordPotvrda,
      'brojUspjesnoProdanihNekretnina': instance.brojUspjesnoProdanihNekretnina,
      'rejtingKupaca': instance.rejtingKupaca,
      'bajtoviSlike': instance.bajtoviSlike,
    };
