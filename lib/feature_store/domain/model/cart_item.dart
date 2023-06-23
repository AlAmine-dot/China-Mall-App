import 'package:lumia_app/feature_store/domain/model/product.dart';

class CartItem{

  Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity
  });


}