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

      final categoryProductsFromLocalSource = await _storeRepository.getProductsByCategoryFromLocalSource(categoryName: categoryName, limit: limit, skip: skip);

      if(categoryProductsFromLocalSource.products.isNotEmpty && categoryProductsFromLocalSource ! == null){
        yield Resource.success(categoryProductsFromLocalSource);
        final categoryProductsFromRemote = await _storeRepository.getProductsByCategoryFromRemote(categoryName: categoryName, limit: limit, skip: skip);

        if(categoryProductsFromLocalSource != categoryProductsFromRemote){
          _storeRepository.addProductsToLocalSource(categoryProductsFromRemote);
        }
      }else{

        final categoryProductsFromRemote = await _storeRepository.getProductsByCategoryFromRemote(categoryName: categoryName, limit: limit, skip: skip);
        _storeRepository.addProductsToLocalSource(categoryProductsFromRemote);

        final finalResponse = await _storeRepository.getProductsByCategoryFromLocalSource(categoryName: categoryName, limit: limit, skip: skip);

        yield Resource.success(finalResponse);

      }

    } catch (e) {
      yield Resource.error('An error occurred');
    }
  }
}
