import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../../core/commons/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';
import '../model/cart_item.dart';

class RemoveFromCartUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<bool>> execute({required CartItem cartItem}) async* {

    try {

      final cart = await _storeRepository.removeFromCart(cartItem.product);

      // Il serait temps que tu commences à gérer les types de retours dans ton repository pour yield les exceptions.

      yield Resource.success(true);

    } catch (e) {
      yield Resource.error('An error occurred in GetCartUseCase');
    }
  }
}
