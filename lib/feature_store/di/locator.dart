import 'package:get_it/get_it.dart';
import 'package:lumia_app/feature_store/data/remote/api/store_api_impl.dart';
import 'package:lumia_app/feature_store/data/repository/store_repository_impl.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_products_by_category.dart';
import 'package:lumia_app/feature_store/presentation/home_screen/bloc/home_event.dart';

import '../../core/data/local/china_mall_database.dart';

final locator = GetIt.instance;

// Cette injection de dépendances doit être break up, l'instance de la base de données devrait appartenir à un autre
// setup
void setupStoreDependencies(){

  // CHINAMALL DATABASE INSTANCE :
  locator.registerLazySingleton<ChinamallDatabase>(() => ChinamallDatabase());

  // LOCAL AND REMOTE :
  locator.registerLazySingleton<StoreApiImpl>(() => StoreApiImpl());
  locator.registerLazySingleton<StoreRepositoryImpl>(() => StoreRepositoryImpl());

  // USE CASES :
  locator.registerLazySingleton(() => GetAllCategoriesUseCase());
  locator.registerLazySingleton(() => GetProductsByCategoryUseCase());


}