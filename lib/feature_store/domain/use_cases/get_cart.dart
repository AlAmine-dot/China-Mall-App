import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../../core/commons/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';
import '../model/cart_item.dart';

class GetCartUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<List<CartItem>>> execute() async* {
    yield Resource.loading();

    try {

      final cart = await _storeRepository.getCart();

      yield Resource.success(cart);

    } catch (e) {
      yield Resource.error('An error occurred in GetCartUseCase');
    }
  }
}
