import 'package:flutter/cupertino.dart';

import '../../../domain/model/cart_item.dart';
import '../../../domain/model/category.dart';
import '../../../domain/model/product.dart';

abstract class CartEvent{
  const CartEvent();
}

class InitCart extends CartEvent{}

class GetCartEvent extends CartEvent{}

class UpdateCartItem extends CartEvent{
  final CartItem cartItem;
  final int newQuantity;
  const UpdateCartItem({required this.cartItem, required this.newQuantity});
}

class SelectCategory extends CartEvent{
  final int index;
  const SelectCategory(this.index);
}

class RemoveFromCart extends CartEvent{
  final CartItem cartItem;
  final BuildContext context;

  const RemoveFromCart(this.cartItem, this.context);
}

class ShowCartSnackbarEvent extends CartEvent {
  final String message;
  final BuildContext context;

  ShowCartSnackbarEvent(this.message, this.context);
}
