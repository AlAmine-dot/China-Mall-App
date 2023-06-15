import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_event.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_state.dart';

class SearchOverviewBloc extends Bloc<SearchOverviewEvent, SearchOverviewState>{

  SearchOverviewBloc():super(SearchOverviewState()){
    on<SearchPromptChange>(_updatePrompt);
    on<SearchFieldSubmitted>(_submitSearchField);
    on<SelectFilter>(_updateFilter);
  }

  void _updateFilter(SelectFilter event, Emitter<SearchOverviewState> emit) async{
    emit(state.copyWith(selectedFilterOption: event.newFilterValue));
    print("New searchOverviewState is: $state");

  }

  void _submitSearchField(SearchFieldSubmitted event, Emitter<SearchOverviewState> emit) async{
    // emit(state.copyWith(searchPrompt: event.newPrompt));
    print("New searchOverviewState is: $state");

  }

  void _updatePrompt(SearchPromptChange event, Emitter<SearchOverviewState> emit) async{
    emit(state.copyWith(searchPrompt: event.newPrompt,));
    print("New searchOverviewState is: $state");

  }

}