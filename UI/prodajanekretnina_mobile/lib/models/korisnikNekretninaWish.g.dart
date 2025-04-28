// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnikNekretninaWish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikNekretninaWish _$KorisnikNekretninaWishFromJson(
        Map<String, dynamic> json) =>
    KorisnikNekretninaWish(
      json['korisnikNekretninaWishId'] as int?,
      json['korisnikId'] as int?,
      json['nekretninaId'] as int?,
    );

Map<String, dynamic> _$KorisnikNekretninaWishToJson(
        KorisnikNekretninaWish instance) =>
    <String, dynamic>{
      'korisnikNekretninaWishId': instance.korisnikNekretninaWishId,
      'korisnikId': instance.korisnikId,
      'nekretninaId': instance.nekretninaId,
    };
