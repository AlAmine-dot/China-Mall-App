import 'package:lumia_app/core/data/local/china_mall_database.dart';
import 'package:lumia_app/feature_store/data/local/entities/product_entity.dart';
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
    return Product.fromDtoToProductModel(dto);
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

  @override
  Future<void> addProductsToLocalSource(ProductStore productStore) async {
    var productEntityList = productStore.products.map((model) => ProductEntity.toProductEntity(model)).toList();
    _database.productDao.addProducts(productEntityList);
  }
  //
  // @override
  // Future<ProductStore> getProductsByCategoryFromLocalSource({required String categoryName, required int limit, required int skip}) async {
  //   var productEntitiesList = await _database.productDao.getProductsByCategory(categoryName: categoryName);
  //   var productsList = productEntitiesList.map((entity) => Product.fromEntityToProductModel(entity)).toList();
  //
  //   // var finalProductsList = productsList.
  //   // Ici la valeur que tu donnes avec totalProductsFound n'est pas valide, tu devrais plutôt retourner la quantité d'items disponible
  //   // On devra corriger ça bientôt
  //   var productStore = ProductStore(products: productsList, totalProductsFound: productsList.length);
  //   return productStore;
  // }

  @override
  Future<ProductStore> getProductsByCategoryFromLocalSource({required String categoryName, required int limit, required int skip}) async {
    var productEntitiesList = await _database.productDao.getProductsByCategory(categoryName: categoryName);
    var totalProductsFound = productEntitiesList.length;

    if (skip >= totalProductsFound) {
      // Si skip est supérieur ou égal à totalProductsFound,
      // la plage de produits est en dehors des limites, donc on retourne une liste vide
      return ProductStore(products: [], totalProductsFound: totalProductsFound);
    }

    var startIndex = skip;
    var endIndex = startIndex + limit;
    if (endIndex > totalProductsFound) {
      endIndex = totalProductsFound;
    }

    var productsList = productEntitiesList
        .sublist(startIndex, endIndex)
        .map((entity) => Product.fromEntityToProductModel(entity))
        .toList();

    var productStore = ProductStore(products: productsList, totalProductsFound: totalProductsFound);
    return productStore;
  }


}