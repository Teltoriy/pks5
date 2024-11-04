// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      (json['ID'] as num).toInt(),
      json['Name'] as String,
      json['Description'] as String,
      json['FullDescription'] as String,
      (json['Price'] as num).toInt(),
      json['ImageURL'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'ID': instance.id,
      'Name': instance.Name,
      'Description': instance.Description,
      'FullDescription': instance.FullDescription,
      'Price': instance.Price,
      'ImageURL': instance.img,
    };
