// class ProductDto {
//   int id;
//   String title;
//   String description;
//   int price;
//   double discountPercentage;
//   double rating;
//   int stock;
//   String brand;
//   String category;
//   String thumbnail;
//   List<String> images;
//
//   ProductDto({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.discountPercentage,
//     required this.rating,
//     required this.stock,
//     required this.brand,
//     required this.category,
//     required this.thumbnail,
//     required this.images,
//   });
//
//   factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     price: json["price"],
//     discountPercentage: json["discountPercentage"]?.toDouble(),
//     rating: json["rating"]?.toDouble(),
//     stock: json["stock"],
//     brand: json["brand"],
//     category: json["category"],
//     thumbnail: json["thumbnail"],
//     images: List<String>.from(json["images"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "price": price,
//     "discountPercentage": discountPercentage,
//     "rating": rating,
//     "stock": stock,
//     "brand": brand,
//     "category": category,
//     "thumbnail": thumbnail,
//     "images": List<dynamic>.from(images.map((x) => x)),
//   };
// }


// To parse this JSON data, do
//
//     final productDto = productDtoFromJson(jsonString);

import 'dart:convert';

ProductDto productDtoFromJson(String str) => ProductDto.fromJson(json.decode(str));

String productDtoToJson(ProductDto data) => json.encode(data.toJson());

class ProductDto {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
