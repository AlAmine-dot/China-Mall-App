import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_event.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState>{

    RootBloc():super(RootState()){
    on<ChangeRoute>(_changeRoute);
    }


    void _changeRoute(ChangeRoute event, Emitter<RootState> emit) async {
      emit(state.copyWith(routeIndex: event.index));
    }
}
