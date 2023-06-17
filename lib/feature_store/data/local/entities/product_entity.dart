import '../../../domain/model/product.dart';

class ProductEntity{

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

  ProductEntity({
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

  factory ProductEntity.toProductEntity(Product model) => ProductEntity(id: model.id, title: model.title, description: model.description, price: model.price, discountPercentage: model.discountPercentage, rating: model.rating, stock: model.stock, brand: model.brand, category: model.category, thumbnail: model.thumbnail, images: model.images, nondiscountPrice: model.price ~/ (1 - (model.discountPercentage / 100) ));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'nondiscountPrice': nondiscountPrice,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images.join(','),
    };
  }

  @override
  String toString() {
    return 'ProductEntity{brand: $brand}';
  }
}