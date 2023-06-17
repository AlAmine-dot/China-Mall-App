import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../../core/commons/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';

class SearchProductsByNameUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<ProductStore>> execute(
      {required String queryString, int? limit, int? skip}) async* {

    // Pour l'instant, je créee ce use-case sans prendre compte du limit et du offset, il va falloir que j'y réflechisse
    // à part, c'est très technique vu le fonctionnement de l'API.

    yield Resource.loading();

    try {

      final foundProductsFromLocalSource = await _storeRepository.searchProductsByNameFromLocalSource(queryString: queryString);

      if(foundProductsFromLocalSource.products.isNotEmpty && foundProductsFromLocalSource != null){

        yield Resource.success(foundProductsFromLocalSource);
        final foundProductsFromRemote = await _storeRepository.searchProductsByNameFromRemote(queryString: queryString);

        if(foundProductsFromLocalSource != foundProductsFromRemote){
          _storeRepository.addProductsToLocalSource(foundProductsFromRemote);

          final finalProductsFromRemote = await _storeRepository.searchProductsByNameFromRemote(queryString: queryString);
          yield Resource.success(finalProductsFromRemote);
        }

      }else{

        final foundProductsFromRemote = await _storeRepository.searchProductsByNameFromRemote(queryString: queryString);
        _storeRepository.addProductsToLocalSource(foundProductsFromRemote);

        final finalResponse = await _storeRepository.searchProductsByNameFromLocalSource(queryString: queryString);

        yield Resource.success(finalResponse);

      }

    } catch (e) {
      yield Resource.error('An error occurred');
    }
  }
}
