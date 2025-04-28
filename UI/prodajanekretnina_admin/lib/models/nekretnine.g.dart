// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nekretnine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nekretnina _$NekretninaFromJson(Map<String, dynamic> json) => Nekretnina(
      json['nekretninaId'] as int?,
      json['isOdobrena'] as bool?,
      json['korisnikId'] as int?,
      json['tipNekretnineId'] as int?,
      json['kategorijaId'] as int?,
      json['lokacijaId'] as int?,
      json['datumDodavanja'] as String?,
      json['datumIzmjene'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      json['stateMachine'] as String?,
      json['kvadratura'] as int?,
      json['naziv'] as String?,
      json['brojSoba'] as int?,
      json['brojSpavacihSoba'] as int?,
      json['namjesten'] as bool?,
      json['novogradnja'] as bool?,
      json['sprat'] as int?,
      json['parkingMjesto'] as bool?,
      json['brojUgovora'] as int?,
      json['detaljanOpis'] as String?,
    );

Map<String, dynamic> _$NekretninaToJson(Nekretnina instance) =>
    <String, dynamic>{
      'nekretninaId': instance.nekretninaId,
      'isOdobrena': instance.isOdobrena,
      'korisnikId': instance.korisnikId,
      'tipNekretnineId': instance.tipNekretnineId,
      'kategorijaId': instance.kategorijaId,
      'lokacijaId': instance.lokacijaId,
      'datumDodavanja': instance.datumDodavanja,
      'datumIzmjene': instance.datumIzmjene,
      'cijena': instance.cijena,
      'stateMachine': instance.stateMachine,
      'kvadratura': instance.kvadratura,
      'naziv': instance.naziv,
      'brojSoba': instance.brojSoba,
      'brojSpavacihSoba': instance.brojSpavacihSoba,
      'namjesten': instance.namjesten,
      'novogradnja': instance.novogradnja,
      'sprat': instance.sprat,
      'parkingMjesto': instance.parkingMjesto,
      'brojUgovora': instance.brojUgovora,
      'detaljanOpis': instance.detaljanOpis,
    };
