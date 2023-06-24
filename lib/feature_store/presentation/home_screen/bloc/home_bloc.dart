import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';
import 'package:lumia_app/feature_store/presentation/home_screen/bloc/home_event.dart';
import 'package:lumia_app/feature_store/presentation/home_screen/bloc/home_state.dart';
import 'package:lumia_app/feature_store/presentation/home_screen/home_screen.dart';

import '../../../../core/commons/utils/app_constants.dart';
import '../../../../core/commons/utils/resource.dart';
import '../../../../core/presentation/app_global_widgets.dart';
import '../../../di/locator.dart';
import '../../../domain/use_cases/add_product_to_cart.dart';
import '../../../domain/use_cases/get_products_by_category.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  final _getAllCategories = locator.get<GetAllCategoriesUseCase>();
  final _getProductsByCategory = locator.get<GetProductsByCategoryUseCase>();
  final _addToCartUseCase = locator.get<AddToCartUseCase>();

  HomeBloc():super(HomeState()){
    on<GetCategoriesEvent>(_getCategories);
    on<SelectCategory>(_selectNewCategory);
    on<GetCategoryProducts>(_getCategoryProducts);
    on<InitHome>(_initializeHomeView);
    on<AddToCart>(_addToCart);
    on<ShowSnackbarEvent>(_showSnackbar);
    add(InitHome());
  }

  void _showSnackbar(ShowSnackbarEvent event, Emitter<HomeState> emit) async{
    ScaffoldMessenger.of(event.context).showSnackBar(
      buildCustomSnackBar(event.context, event.message),
    );
  }

  void _addToCart(AddToCart event, Emitter<HomeState> emit) async{
    await for (final resource in _addToCartUseCase.execute(product: event.product)) {
      print("New sneakers aired dude : " + resource.data.toString());
      switch (resource.type) {
        case ResourceType.success:
          // emit(state.copyWith(categoriesLoading: false, categories: resource.data));
          if(resource.data!){
            add(ShowSnackbarEvent("Added to cart successfully", event.context));
          }else{
            add(ShowSnackbarEvent("This product is already into your cart.", event.context));
          };
          break;
        case ResourceType.error:
          emit(state.copyWith(categoriesLoading: false, errorMessage: resource.message));
          print("Error happened");
          break;
        case ResourceType.loading:
          emit(state.copyWith(categoriesLoading: true));
          break;
      }
    }
  }


  void _initializeHomeView(InitHome event, Emitter<HomeState> emit) async {
    await for (final resource in _getAllCategories.execute()) {
      switch (resource.type) {
        case ResourceType.success:
          emit(state.copyWith(categoriesLoading: false, categories: resource.data));
          add(GetCategoryProducts(category: resource.data!.first, skip: 0, limit: AppConstants.DEFAULT_LIMIT));
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
    add(GetCategoryProducts(category: state.categories[event.index], skip: 0, limit: AppConstants.DEFAULT_LIMIT));
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
