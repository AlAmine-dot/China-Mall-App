import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/feature_store/data/repository/store_repository_impl.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_event.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_state.dart';

import '../../../../core/utils/resource.dart';
import '../../../di/locator.dart';
import '../../../domain/model/category.dart';
import '../../../domain/use_cases/get_products_by_category.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  final _getAllCategories = locator.get<GetAllCategoriesUseCase>();
  final _getProductsByCategory = locator.get<GetProductsByCategoryUseCase>();

  HomeBloc():super(HomeState()){
    on<GetCategoriesEvent>(_getCategories);
    on<SelectCategory>(_selectNewCategory);
    on<GetCategoryProducts>(_getCategoryProducts);
    on<InitHome>(_initializeHomeView);

    add(InitHome());
  }


  void _initializeHomeView(InitHome event, Emitter<HomeState> emit) async {
    await for (final resource in _getAllCategories.execute()) {
      switch (resource.type) {
        case ResourceType.success:
          emit(state.copyWith(categoriesLoading: false, categories: resource.data));
          add(GetCategoryProducts(resource.data!.first, 0, 16));
          print("New state is: $state");
          break;
        case ResourceType.error:
          emit(state.copyWith(categoriesLoading: false, errorMessage: resource.message));
          print("New state is: $state");
          break;
        case ResourceType.loading:
          emit(state.copyWith(categoriesLoading: true));
          print("New state is: $state");
          break;
      }
    }
  }


  Future<void> _getCategoryProducts(GetCategoryProducts event, Emitter<HomeState> emit) async {
    await for (final resource in _getProductsByCategory.execute(categoryName: event.category.categoryName, limit: event.limit, skip: event.skip)) {
      switch (resource.type) {
        case ResourceType.success:
          emit(state.copyWith(categoryProductsLoading: false, categoryProducts: resource.data));
          print("New state is: $state");
          break;
        case ResourceType.error:
          emit(state.copyWith(categoryProductsLoading: false, errorMessage: resource.message));
          print("New state is: $state");
          break;
        case ResourceType.loading:
          emit(state.copyWith(categoryProductsLoading: true));
          print("New state is: $state");
          break;
      }
    }
  }

  void _selectNewCategory(SelectCategory event, Emitter<HomeState> emit){
    emit(state.copyWith(selectedCategoryTab: event.index));
  }

  Future<void> _getCategories(GetCategoriesEvent event, Emitter<HomeState> emit) async {

    await for (final resource in _getAllCategories.execute()) {
      switch (resource.type) {
        case ResourceType.success:
          emit(state.copyWith(categoriesLoading: false, categories: resource.data));
          print("New state is: $state");
          break;
        case ResourceType.error:
          emit(state.copyWith(categoriesLoading: false, errorMessage: resource.message));
          print("New state is: $state");
          break;
        case ResourceType.loading:
          emit(state.copyWith(categoriesLoading: true));
          print("New state is: $state");
          break;
      }
    }
  }

}
