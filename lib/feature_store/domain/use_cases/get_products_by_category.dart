import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../../core/commons/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';

class GetProductsByCategoryUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<ProductStore>> execute(
      {required String categoryName, required int limit, required int skip}) async* {
    yield Resource.loading();

    try {
      final categoryProducts = await _storeRepository.getProductsByCategoryFromRemote(categoryName: categoryName, limit: limit, skip: skip);
      yield Resource.success(categoryProducts);
    } catch (e) {
      yield Resource.error('An error occurred');
    }
  }
}
