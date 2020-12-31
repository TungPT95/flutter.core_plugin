abstract class PaginationInterface<T> {
  void nextPage();

  List<T> get items;

  bool get ended;
}
