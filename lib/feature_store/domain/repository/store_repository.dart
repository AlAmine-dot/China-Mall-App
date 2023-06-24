import '../model/cart_item.dart';
import '../model/category.dart';
import '../model/product.dart';
import '../model/product_store.dart';

abstract class StoreRepository{

  // FROM REMOTE :

  Future<List<Category>> getAllCategoriesFromRemote();

  Future<ProductStore> getProductsFromRemote({required int limit, required int skip});

  Future<ProductStore> searchProductsByNameFromRemote({required String queryString, required int limit, required int skip});

  Future<ProductStore> getProductsByCategoryFromRemote({required String categoryName, required int limit, required int skip});

  Future<Product> getSingleProductByIdFromRemote(int productId);

  // FROM,TO LOCAL SOURCE :

  Future<void> addCategoriesToLocalSource(List<Category> categoryList);

  Future<List<Category>> getAllCategoriesFromLocalSource();

  Future<void> addProductsToLocalSource(ProductStore productStore);

  Future<ProductStore> getProductsByCategoryFromLocalSource({required String categoryName, required int limit, required int skip});

  Future<ProductStore> searchProductsByNameFromLocalSource({required String queryString, required int limit, required int skip});


  // CART :

  Future<void> addToCart(Product product);

  Future<void> removeFromCart(Product product);

  Future<void> updateQuantity(Product product,int newQuantity);

  Future<List<CartItem>> getCart();

  Future<bool> isProductIntoCart(int productId);

  Future<void> clearCart();
}