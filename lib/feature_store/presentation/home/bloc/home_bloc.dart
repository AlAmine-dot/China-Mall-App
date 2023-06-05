import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/feature_store/data/repository/store_repository_impl.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_event.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_state.dart';

import '../../../../core/utils/resource.dart';
import '../../../../core/utils/resource.dart';
import '../../../../core/utils/resource.dart';
import '../../../../core/utils/resource.dart';
import '../../../../core/utils/resource.dart';
import '../../../di/locator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  final _getAllCategories = locator.get<GetAllCategoriesUseCase>();

  HomeBloc():super(HomeState()){
    on<GetCategoriesEvent>(_getCategories);
    on<SelectCategory>(_selectNewCategory);

    add(GetCategoriesEvent());
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
