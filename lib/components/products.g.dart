// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      (json['id'] as num).toInt(),
      json['Name'] as String,
      json['Description'] as String,
      json['FullDescription'] as String,
      (json['Price'] as num).toInt(),
      json['img'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'Name': instance.Name,
      'Description': instance.Description,
      'FullDescription': instance.FullDescription,
      'Price': instance.Price,
      'img': instance.img,
    };
