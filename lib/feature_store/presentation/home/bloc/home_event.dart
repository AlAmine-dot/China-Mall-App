import '../../../domain/model/category.dart';

abstract class HomeEvent{
  const HomeEvent();
}

class InitHome extends HomeEvent{}

class GetCategoriesEvent extends HomeEvent{}

class GetCategoryProducts extends HomeEvent{
  final int limit;
  final int skip;
  final Category category;

  const GetCategoryProducts(this.category, this.skip, this.limit);
}

class SelectCategory extends HomeEvent{
  final int index;
  const SelectCategory(this.index);
}