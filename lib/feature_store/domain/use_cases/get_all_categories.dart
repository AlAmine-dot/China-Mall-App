import '../../../core/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';
import '../model/category.dart';

class GetAllCategoriesUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<List<Category>>> execute() async* {
    yield Resource.loading();

    try {
      final categories = await _storeRepository.getAllCategoriesFromRemote();
      yield Resource.success(categories);
    } catch (e) {
      yield Resource.error('An error occurred');
    }
  }
}
