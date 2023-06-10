import '../../../core/commons/utils/resource.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../di/locator.dart';
import '../model/category.dart';

class GetAllCategoriesUseCase {
  final _storeRepository = locator.get<StoreRepositoryImpl>();

  Stream<Resource<List<Category>>> execute() async* {
    yield Resource.loading();

    try {

      final categoriesFromLocalSource = await _storeRepository.getAllCategoriesFromLocalSource();
      print("Here is localSource : " + categoriesFromLocalSource.toString());

      if(categoriesFromLocalSource.isNotEmpty && categoriesFromLocalSource != null){

        yield Resource.success(categoriesFromLocalSource);
        final categoriesFromRemote = await _storeRepository.getAllCategoriesFromRemote();

        if(categoriesFromLocalSource != categoriesFromRemote){
          _storeRepository.addCategoriesToLocalSource(categoriesFromRemote);
        }

      }else{
        final categoriesFromRemote = await _storeRepository.getAllCategoriesFromRemote();
        _storeRepository.addCategoriesToLocalSource(categoriesFromRemote);

        final finalResponse = await _storeRepository.getAllCategoriesFromLocalSource();
        yield Resource.success(finalResponse);
      }

    } catch (e) {
      yield Resource.error('An error occurred');
    }

  }
}
