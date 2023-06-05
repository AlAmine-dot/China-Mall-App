abstract class HomeEvent{
  const HomeEvent();
}

class GetCategoriesEvent extends HomeEvent{}

class SelectCategory extends HomeEvent{
  final int index;
  const SelectCategory(this.index);
}