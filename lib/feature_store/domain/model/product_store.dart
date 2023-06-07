import 'package:lumia_app/feature_store/data/remote/dto/product_store_dto.dart';
import 'package:lumia_app/feature_store/domain/model/product.dart';

class ProductStore{
  final List<Product> products;
  final int totalProductsFound;

  ProductStore({required this.products, required this.totalProductsFound});

  factory ProductStore.toProductStoreModel(ProductStoreDto dto){
    final products = dto.products.map((e) => Product.toProductModel(e)).toList();
    return ProductStore(products: products, totalProductsFound: dto.total);
  }

  @override
  String toString() {
    return 'ProductStore{products: $products, totalProductsFound: $totalProductsFound}';
  }
}