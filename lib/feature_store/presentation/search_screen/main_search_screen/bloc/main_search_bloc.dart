import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_search_event.dart';
import 'main_search_state.dart';

class MainSearchBloc extends Bloc<MainSearchEvent, MainSearchState>{

  MainSearchBloc():super(MainSearchState()){
    on<SearchPromptChange>(_updatePrompt);
    on<SearchFieldSubmitted>(_submitSearchField);
  }


  void _submitSearchField(SearchFieldSubmitted event, Emitter<MainSearchState> emit) async{
    // emit(state.copyWith(searchPrompt: event.newPrompt));

    print("New MainSearchState is: $state");

  }

  void _updatePrompt(SearchPromptChange event, Emitter<MainSearchState> emit) async{
    emit(state.copyWith(searchPrompt: event.newPrompt));
    print("New MainSearchState is: $state");

  }

}
