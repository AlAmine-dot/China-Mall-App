import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_event.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_state.dart';

import '../../../../../core/commons/utils/resource.dart';
import '../../../../di/locator.dart';
import '../../../../domain/use_cases/search_products_by_name.dart';

class SearchOverviewBloc extends Bloc<SearchOverviewEvent, SearchOverviewState>{

  final _searchProducts = locator.get<SearchProductsByNameUseCase>();

  SearchOverviewBloc():super(SearchOverviewState()){
    on<SearchPromptChange>(_updatePrompt);
    on<SearchFieldSubmitted>(_submitSearchField);
    on<SelectFilter>(_updateFilter);

    // add(SearchFieldSubmitted());
  }

  void _updateFilter(SelectFilter event, Emitter<SearchOverviewState> emit) async{
    emit(state.copyWith(selectedFilterOption: event.newFilterValue));
    print("New searchOverviewState is: $state");

  }

  void _submitSearchField(SearchFieldSubmitted event, Emitter<SearchOverviewState> emit) async{
    // J'ai récupéré le queryString depuis le state et non pas l'event, on verra si ça pose problème
    await for (final resource in _searchProducts.execute(queryString: state.searchPrompt)) {
      switch (resource.type) {
        case ResourceType.success:
          // Pour le moment je remplace directement la liste, on verra si ça pose problème
              emit(state.copyWith(isLoading: false, searchResult: resource.data));
          print("New state is: $state");
          break;
        case ResourceType.error:
          emit(state.copyWith(isLoading: false, errorMessage: resource.message));
          print("New state is: $state");
          break;
        case ResourceType.loading:
          emit(state.copyWith(isLoading: true));
          print("New state is: $state");
          break;
      }
    }

  }

  void _updatePrompt(SearchPromptChange event, Emitter<SearchOverviewState> emit) async{
    emit(state.copyWith(searchPrompt: event.newPrompt,));
    print("New searchOverviewState is: $state");

  }

}