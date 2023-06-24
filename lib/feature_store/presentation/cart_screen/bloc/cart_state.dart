import 'package:lumia_app/feature_store/domain/model/cart_item.dart';

class CartState {
  final List<CartItem> cart;
  final bool isLoading;

  final String errorMessage;

  const CartState({
    this.cart = const [],
    this.isLoading = true,
    this.errorMessage = '',
  });

  CartState copyWith({
    List<CartItem>? cart,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'CartState{cart: $cart, isLoading: $isLoading, errorMessage: $errorMessage}';
  }
}
