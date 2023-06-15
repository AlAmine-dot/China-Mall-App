import '../../../../domain/model/product_store.dart';

class SearchOverviewState{
  final String searchPrompt;
  final ProductStore? searchResult;
  final String selectedFilterOption;
  final bool isLoading;

  const SearchOverviewState({
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
  }) {
    return SearchOverviewState(
      searchPrompt: searchPrompt ?? this.searchPrompt,
      searchResult: searchResult ?? this.searchResult,
      selectedFilterOption: selectedFilterOption ?? this.selectedFilterOption,
      isLoading: isLoading ?? this.isLoading,
    );
  }


}