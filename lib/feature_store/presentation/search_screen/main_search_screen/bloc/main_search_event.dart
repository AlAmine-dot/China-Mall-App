
abstract class MainSearchEvent{
  const MainSearchEvent();
}

class SearchPromptChange extends MainSearchEvent{
  final String newPrompt;

  const SearchPromptChange({required this.newPrompt});

}

class SearchFieldSubmitted extends MainSearchEvent{}
