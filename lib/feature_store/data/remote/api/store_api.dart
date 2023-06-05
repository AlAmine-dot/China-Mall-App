import '../dto/product_dto.dart';
import '../dto/product_store_dto.dart';


abstract class StoreApi{

    static const API_BASE_URL = "https://dummyjson.com/products";

    Future<List<String>> getAllCategories();

    Future<ProductStoreDto> getProducts(int limit, int skip);

    Future<ProductStoreDto> searchProductsByName(String queryString, int limit, int skip);

    Future<ProductStoreDto> getProductsByCategory(String categoryName, int limit, int skip);

    Future<ProductDto> getSingleProductById(int productId);

    // ... others
}