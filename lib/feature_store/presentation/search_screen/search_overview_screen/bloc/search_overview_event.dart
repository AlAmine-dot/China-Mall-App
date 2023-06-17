abstract class SearchOverviewEvent{
  const SearchOverviewEvent();
}

class SearchPromptChange extends SearchOverviewEvent{
  final String newPrompt;

  const SearchPromptChange({required this.newPrompt});

}

class SearchFieldSubmitted extends SearchOverviewEvent{}

class SelectFilter extends SearchOverviewEvent{
  final String newFilterValue;

  const SelectFilter({required this.newFilterValue});
}


