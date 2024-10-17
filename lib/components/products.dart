import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
class Product {
  Product(this.id, this.Name, this.Description, this.FullDescription, this.Price, this.img);
  int id;
  String Name;
  String Description;
  String FullDescription;
  int Price;
  String img;
  bool isImageUrl=true;
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
