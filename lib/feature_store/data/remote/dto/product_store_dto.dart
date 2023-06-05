// To parse this JSON data, do
//
//     final productStoreDto = productStoreDtoFromJson(jsonString);

import 'dart:convert';

import 'package:lumia_app/feature_store/data/remote/dto/product_dto.dart';

ProductStoreDto productStoreDtoFromJson(String str) => ProductStoreDto.fromJson(json.decode(str));

String productStoreDtoToJson(ProductStoreDto data) => json.encode(data.toJson());

class ProductStoreDto {
  List<ProductDto> products;
  int total;
  int skip;
  int limit;

  ProductStoreDto({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductStoreDto.fromJson(Map<String, dynamic> json) => ProductStoreDto(
    products: List<ProductDto>.from(json["products"].map((x) => ProductDto.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

