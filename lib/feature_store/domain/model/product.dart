import 'package:lumia_app/feature_store/data/remote/dto/product_dto.dart';

import '../../data/local/entities/product_entity.dart';

class Product{

  int id;
  String title;
  String description;
  int price;
  int nondiscountPrice;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  Product({
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
    required this.nondiscountPrice
  });

  factory Product.fromDtoToProductModel(ProductDto dto) => Product(id: dto.id, title: dto.title, description: dto.description, price: dto.price, discountPercentage: dto.discountPercentage, rating: dto.rating, stock: dto.stock, brand: dto.brand, category: dto.category, thumbnail: dto.thumbnail, images: dto.images, nondiscountPrice: dto.price ~/ (1 - (dto.discountPercentage / 100) ));

  factory Product.fromEntityToProductModel(ProductEntity entity) => Product(id: entity.id, title: entity.title, description: entity.description, price: entity.price, discountPercentage: entity.discountPercentage, rating: entity.rating, stock: entity.stock, brand: entity.brand, category: entity.category, thumbnail: entity.thumbnail, images: entity.images, nondiscountPrice: entity.nondiscountPrice);

  @override
  String toString() {
    return 'Product{id: $id, title: $title, description: $description, price: $price, nondiscountPrice: $nondiscountPrice, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, brand: $brand, category: $category, thumbnail: $thumbnail, images: $images}';
  }
}