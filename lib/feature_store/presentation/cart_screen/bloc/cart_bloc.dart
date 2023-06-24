import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/feature_store/domain/model/cart_item.dart';
import 'package:lumia_app/feature_store/domain/use_cases/get_all_categories.dart';
import '../../../../core/commons/utils/resource.dart';
import '../../../../core/presentation/app_global_widgets.dart';
import '../../../di/locator.dart';
import '../../../domain/use_cases/delete_from_cart.dart';
import '../../../domain/use_cases/get_cart.dart';
import '../../../domain/use_cases/get_products_by_category.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState>{

  final _getCartUseCase = locator.get<GetCartUseCase>();
  final _removeFromCartUseCase = locator.get<RemoveFromCartUseCase>();

  CartBloc():super(CartState()){
    on<GetCartEvent>(_getCart);
    on<RemoveFromCart>(_removeFromCart);
    on<InitCart>(_initializeCartView);
    on<ShowCartSnackbarEvent>(_showSnackbar);
    add(InitCart());
  }

  void _showSnackbar(ShowCartSnackbarEvent event, Emitter<CartState> emit) async{
    ScaffoldMessenger.of(event.context).showSnackBar(
      buildCustomSnackBar(event.context, event.message),
    );
  }

  void _getCart(GetCartEvent event, Emitter<CartState> emit) async{
    await for (final resource in _getCartUseCase.execute()) {
      switch (resource.type) {
        case ResourceType.success:
          emit(state.copyWith(isLoading: false, cart: resource.data));
          break;
        case ResourceType.error:
          emit(state.copyWith(isLoading: false, errorMessage: resource.message));
          break;
        case ResourceType.loading:
          emit(state.copyWith(isLoading: true));
          break;
      }
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) async{
    await for (final resource in _removeFromCartUseCase.execute(cartItem: event.cartItem)) {
      switch (resource.type) {
        case ResourceType.success:
          state.cart.remove(event.cartItem);
          add(ShowCartSnackbarEvent("Product removed from cart.", event.context));
          // emit(state.copyWith(isLoading: false, cart: newList));
          break;
        case ResourceType.error:
          emit(state.copyWith(isLoading: false, errorMessage: resource.message));
          break;
        case ResourceType.loading:
          emit(state.copyWith(isLoading: true));
          break;
      }
    }
  }


  void _initializeCartView(InitCart event, Emitter<CartState> emit) async {
    add(GetCartEvent());
  }

}
