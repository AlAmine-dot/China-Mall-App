import 'package:get_it/get_it.dart';
import 'package:lumia_app/feature_store/data/remote/api/store_api_impl.dart';
import 'package:lumia_app/feature_store/data/repository/store_repository_impl.dart';
import 'package:lumia_app/feature_store/domain/use_cases/add_product_to_cart.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_products_by_category.dart';
import 'package:lumia_app/feature_store/domain/use_cases/search_products_by_name.dart';
import '../../core/data/local/china_mall_database.dart';
import '../domain/use_cases/delete_from_cart.dart';
import '../domain/use_cases/get_cart.dart';

final locator = GetIt.instance;

// Cette injection de dépendances doit être break up, l'instance de la base de données devrait appartenir à un autre
// setup

void setupDatabaseDependencies(){
  // CHINAMALL DATABASE INSTANCE :
  locator.registerLazySingleton<ChinamallDatabase>(() => ChinamallDatabase());
}

void setupStoreDependencies(){

  // LOCAL AND REMOTE :
  locator.registerLazySingleton<StoreApiImpl>(() => StoreApiImpl());
  locator.registerLazySingleton<StoreRepositoryImpl>(() => StoreRepositoryImpl());

  // USE CASES :
  locator.registerLazySingleton(() => GetAllCategoriesUseCase());
  locator.registerLazySingleton(() => GetProductsByCategoryUseCase());
  locator.registerLazySingleton(() => SearchProductsByNameUseCase());
  locator.registerLazySingleton(() => AddToCartUseCase());
  locator.registerLazySingleton(() => GetCartUseCase());
  locator.registerLazySingleton(() => RemoveFromCartUseCase());

}