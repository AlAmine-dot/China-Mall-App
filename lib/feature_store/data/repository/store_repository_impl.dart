import 'package:lumia_app/feature_store/domain/model/category.dart';
import 'package:lumia_app/feature_store/domain/model/product.dart';

import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../di/locator.dart';
import '../../domain/repository/store_repository.dart';
import '../remote/api/store_api.dart';
import '../remote/api/store_api_impl.dart';


class StoreRepositoryImpl extends StoreRepository{

  final StoreApi _storeApi = locator.get<StoreApiImpl>();


  @override
  Future<ProductStore> getProductsByCategoryFromRemote(String categoryName, int limit, int skip) async {
    var dto = await _storeApi.getProductsByCategory(categoryName, limit, skip);
    return ProductStore.toProductStoreModel(dto);
  }

  @override
  Future<ProductStore> getProductsFromRemote(int limit, int skip) async {
    var dto = await _storeApi.getProducts(limit, skip);
    return ProductStore.toProductStoreModel(dto);
  }

  @override
  Future<Product> getSingleProductByIdFromRemote(int productId) async {
    var dto = await _storeApi.getSingleProductById(productId);
    return Product.toProductModel(dto);
  }

  @override
  Future<ProductStore> searchProductsByNameFromRemote(String queryString, int limit, int skip) async {
    var dto = await _storeApi.searchProductsByName(queryString, limit, skip);
    return ProductStore.toProductStoreModel(dto);
  }

  @override
  Future<List<Category>> getAllCategoriesFromRemote() async {
    var categories = await _storeApi.getAllCategories();
    var finalCategories = categories.map((dto) => Category.toCategoryModel(dto)).toList();
    return finalCategories;
  }

}