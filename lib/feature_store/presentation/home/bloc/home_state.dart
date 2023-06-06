import 'package:lumia_app/feature_store/domain/model/product_store.dart';

import '../../../domain/model/category.dart';

class HomeState {
  final List<Category> categories;
  final bool categoriesLoading;
  final ProductStore? categoryProducts;
  final bool categoryProductsLoading;
  final String errorMessage;
  final int selectedCategoryTab;

  const HomeState({
    this.categories = const [],
    this.categoryProducts,
    this.categoriesLoading = true,
    this.categoryProductsLoading = true,
    this.errorMessage = '',
    this.selectedCategoryTab = 0,
  });

  HomeState copyWith({
    List<Category>? categories,
    bool? categoriesLoading,
    ProductStore? categoryProducts,
    bool? categoryProductsLoading,
    String? errorMessage,
    int? selectedCategoryTab,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      categoriesLoading: categoriesLoading ?? this.categoriesLoading,
      categoryProducts: categoryProducts ?? this.categoryProducts,
      categoryProductsLoading: categoryProductsLoading ?? this.categoryProductsLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategoryTab: selectedCategoryTab ?? this.selectedCategoryTab,
    );
  }


  // HomeState copyWith({List<Category>? categories, bool? categoriesLoading, String? errorMessage, int? selectedCategoryTab}) {
  //   return HomeState(
  //     categories: categories ?? this.categories,
  //     categoriesLoading: categoriesLoading ?? this.categoriesLoading,
  //     errorMessage: errorMessage ?? this.errorMessage,
  //     selectedCategoryTab: selectedCategoryTab ?? this.selectedCategoryTab
  //   );
  // }

  @override
  String toString() {
    return 'HomeState{categories: $categories, isLoading: $categoriesLoading, errorMessage: $errorMessage, selectedCategoryTab: $selectedCategoryTab}';
  }
}
