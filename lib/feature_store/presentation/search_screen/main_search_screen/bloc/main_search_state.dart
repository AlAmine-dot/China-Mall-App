class MainSearchState {
  final String searchPrompt;

  const MainSearchState({
    this.searchPrompt = ""
  });

  MainSearchState copyWith({
    String? searchPrompt
  }){
    return MainSearchState(
        searchPrompt: searchPrompt ?? this.searchPrompt
    );
  }

}