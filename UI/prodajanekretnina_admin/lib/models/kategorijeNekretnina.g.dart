// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorijeNekretnina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategorijaNekretnine _$KategorijaNekretnineFromJson(
        Map<String, dynamic> json) =>
    KategorijaNekretnine(
      json['kategorijaId'] as int?,
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$KategorijaNekretnineToJson(
        KategorijaNekretnine instance) =>
    <String, dynamic>{
      'kategorijaId': instance.kategorijaId,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
