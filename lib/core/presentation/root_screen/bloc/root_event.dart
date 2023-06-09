
abstract class RootEvent{
  const RootEvent();
}

class ChangeRoute extends RootEvent{
  final int index;
  const ChangeRoute(this.index);
}