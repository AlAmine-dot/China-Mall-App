import 'package:lumia_app/core/data/local/china_mall_database.dart';
import 'package:lumia_app/feature_store/domain/model/category.dart';
import 'package:lumia_app/feature_store/domain/model/product.dart';

import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../di/locator.dart';
import '../../domain/repository/store_repository.dart';
import '../local/entities/category_entity.dart';
import '../remote/api/store_api.dart';
import '../remote/api/store_api_impl.dart';


class StoreRepositoryImpl extends StoreRepository{

  final StoreApi _storeApi = locator.get<StoreApiImpl>();
  final ChinamallDatabase _database = locator.get<ChinamallDatabase>();

  @override
  Future<ProductStore> getProductsByCategoryFromRemote({required String categoryName, required int limit,required int skip}) async {
    var dto = await _storeApi.getProductsByCategory(categoryName: categoryName, limit: limit, skip: skip);
    return ProductStore.toProductStoreModel(dto);
  }

  @override
  Future<ProductStore> getProductsFromRemote({required int limit, required int skip}) async {
    var dto = await _storeApi.getProducts(limit: limit, skip: skip);
    return ProductStore.toProductStoreModel(dto);
  }

  @override
  Future<Product> getSingleProductByIdFromRemote(int productId) async {
    var dto = await _storeApi.getSingleProductById(productId);
    return Product.toProductModel(dto);
  }

  @override
  Future<ProductStore> searchProductsByNameFromRemote({required String queryString, required int limit, required int skip}) async {
    var dto = await _storeApi.searchProductsByName(queryString: queryString, limit: limit, skip: skip);
    return ProductStore.toProductStoreModel(dto);
  }

  @override
  Future<List<Category>> getAllCategoriesFromRemote() async {
    var categories = await _storeApi.getAllCategories();
    var finalCategories = categories.map((dto) => Category.fromDtoToCategoryModel(dto)).toList();
    return finalCategories;
  }

  @override
  Future<void> addCategoriesToLocalSource(List<Category> categoryList) async {
    var categoryEntities = categoryList.map((categoryModel) => CategoryEntity.toCategoryEntity(categoryModel)).toList();
    _database.categoryDao.addCategories(categoryEntities);
  }

  @override
  Future<List<Category>> getAllCategoriesFromLocalSource() async {
    var categoryEntitiesList = await _database.categoryDao.getCategories();
    var categoryModelsList = categoryEntitiesList.map((entity) => Category.fromEntityToCategoryModel(entity)).toList();
    return categoryModelsList;
  }

}