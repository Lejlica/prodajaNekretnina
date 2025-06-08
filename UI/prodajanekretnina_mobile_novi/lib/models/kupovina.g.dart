// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kupovina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kupovina _$KupovinaFromJson(Map<String, dynamic> json) => Kupovina(
  kupovinaId: (json['kupovinaId'] as num).toInt(),
  nekretninaId: (json['nekretninaId'] as num?)?.toInt(),
  korisnikId: (json['korisnikId'] as num?)?.toInt(),
  price: (json['price'] as num).toDouble(),
  isPaid: json['isPaid'] as bool,
  isConfirmed: json['isConfirmed'] as bool,
  payPalPaymentId: json['payPalPaymentId'] as String?,
);

Map<String, dynamic> _$KupovinaToJson(Kupovina instance) => <String, dynamic>{
  'kupovinaId': instance.kupovinaId,
  'nekretninaId': instance.nekretninaId,
  'korisnikId': instance.korisnikId,
  'price': instance.price,
  'isPaid': instance.isPaid,
  'isConfirmed': instance.isConfirmed,
  'payPalPaymentId': instance.payPalPaymentId,
};
