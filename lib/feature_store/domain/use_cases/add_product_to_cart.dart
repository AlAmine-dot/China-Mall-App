import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../../core/commons/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';
import '../model/product.dart';

class AddToCartUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<bool>> execute({required Product product}) async* {

    try {
      final isProductIntoCart = await _storeRepository.isProductIntoCart(product.id);
      print("Is it into cart ?" + isProductIntoCart.toString());
      if(!isProductIntoCart){
        _storeRepository.addToCart(product);
        yield Resource.success(true);
      }else{
        yield Resource.success(false);
      }

    } catch (e) {
      yield Resource.error('An error occurred in Add to cart use case');
    }
  }
}
