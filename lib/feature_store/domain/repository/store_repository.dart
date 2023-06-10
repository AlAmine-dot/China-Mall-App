import 'package:lumia_app/feature_store/data/remote/api/store_api_impl.dart';

import '../../data/remote/api/store_api.dart';
import '../../di/locator.dart';
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


}