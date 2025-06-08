// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnikNekretninaWish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikNekretninaWish _$KorisnikNekretninaWishFromJson(
  Map<String, dynamic> json,
) => KorisnikNekretninaWish(
  (json['korisnikNekretninaWishId'] as num?)?.toInt(),
  (json['korisnikId'] as num?)?.toInt(),
  (json['nekretninaId'] as num?)?.toInt(),
);

Map<String, dynamic> _$KorisnikNekretninaWishToJson(
  KorisnikNekretninaWish instance,
) => <String, dynamic>{
  'korisnikNekretninaWishId': instance.korisnikNekretninaWishId,
  'korisnikId': instance.korisnikId,
  'nekretninaId': instance.nekretninaId,
};
