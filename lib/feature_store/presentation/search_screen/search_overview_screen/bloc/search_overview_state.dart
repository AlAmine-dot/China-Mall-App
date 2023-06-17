import '../../../../domain/model/product_store.dart';

class SearchOverviewState{
  final String searchPrompt;
  final ProductStore? searchResult;
  final String selectedFilterOption;
  final bool isLoading;
  final String errorMessage;

  const SearchOverviewState({
    this.errorMessage = "",
    this.searchResult,
    this.isLoading = true,
    this.searchPrompt = "",
    this.selectedFilterOption = "Ratings"
  });

  SearchOverviewState copyWith({
    String? searchPrompt,
    ProductStore? searchResult,
    String? selectedFilterOption,
    bool? isLoading,
    String? errorMessage
  }) {
    return SearchOverviewState(
      searchPrompt: searchPrompt ?? this.searchPrompt,
      errorMessage: errorMessage ?? this.errorMessage,
      searchResult: searchResult ?? this.searchResult,
      selectedFilterOption: selectedFilterOption ?? this.selectedFilterOption,
      isLoading: isLoading ?? this.isLoading,
    );
  }


}