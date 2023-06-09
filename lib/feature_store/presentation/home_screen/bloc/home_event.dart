import 'package:flutter/cupertino.dart';

import '../../../domain/model/category.dart';
import '../../../domain/model/product.dart';

abstract class HomeEvent{
  const HomeEvent();
}

class InitHome extends HomeEvent{}

class GetCategoriesEvent extends HomeEvent{}

class GetCategoryProducts extends HomeEvent{
  final int limit;
  final int skip;
  final Category category;

  const GetCategoryProducts({required this.category, required this.skip, required this.limit});
}

class SelectCategory extends HomeEvent{
  final int index;
  const SelectCategory(this.index);
}

class AddToCart extends HomeEvent{
  final Product product;
  final BuildContext context;

  const AddToCart(this.product, this.context);
}

class ShowSnackbarEvent extends HomeEvent {
  final String message;
  final BuildContext context;

  ShowSnackbarEvent(this.message, this.context);
}
