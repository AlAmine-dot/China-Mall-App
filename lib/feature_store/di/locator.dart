import 'package:get_it/get_it.dart';
import 'package:lumia_app/feature_store/data/remote/api/store_api_impl.dart';
import 'package:lumia_app/feature_store/data/repository/store_repository_impl.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';

final locator = GetIt.instance;

void setupStoreDependencies(){

  // LOCAL AND REMOTE :
  locator.registerLazySingleton<StoreApiImpl>(() => StoreApiImpl());
  locator.registerLazySingleton<StoreRepositoryImpl>(() => StoreRepositoryImpl());

  // USE CASES :
  locator.registerLazySingleton(() => GetAllCategoriesUseCase());
}