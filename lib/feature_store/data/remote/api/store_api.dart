import '../dto/product_dto.dart';
import '../dto/product_store_dto.dart';


abstract class StoreApi{

    static const API_BASE_URL = "https://dummyjson.com/products";

    Future<List<String>> getAllCategories();

    Future<ProductStoreDto> getProducts({required int limit, required int skip});

    Future<ProductStoreDto> searchProductsByName({required String queryString, required int limit, required int skip});

    Future<ProductStoreDto> getProductsByCategory({required String categoryName, required int limit, required int skip});

    Future<ProductDto> getSingleProductById(int productId);

    // ... others
}