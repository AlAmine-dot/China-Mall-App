import 'package:lumia_app/feature_store/data/local/entities/product_entity.dart';

class CartItemEntity{

  int id;
  int productId;
  int quantity;

  CartItemEntity({
    required this.id,
    required this.productId,
    required this.quantity
  });

  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['id'] as int,
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
    );
  }

}