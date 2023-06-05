import '../../../domain/model/category.dart';

class HomeState {
  final List<Category> categories;
  final bool categoriesLoading;
  final String errorMessage;
  final int selectedCategoryTab;

  const HomeState({
    this.categories = const [],
    this.categoriesLoading = false,
    this.errorMessage = '',
    this.selectedCategoryTab = 0,
  });

  HomeState copyWith({List<Category>? categories, bool? categoriesLoading, String? errorMessage, int? selectedCategoryTab}) {
    return HomeState(
      categories: categories ?? this.categories,
      categoriesLoading: categoriesLoading ?? this.categoriesLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategoryTab: selectedCategoryTab ?? this.selectedCategoryTab
    );
  }

  @override
  String toString() {
    return 'HomeState{categories: $categories, isLoading: $categoriesLoading, errorMessage: $errorMessage, selectedCategoryTab: $selectedCategoryTab}';
  }
}
