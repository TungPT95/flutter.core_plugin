abstract class PaginationInterface<Model> {
  void nextPage();

  List<Model> get items;

  bool get ended;

  int get page;

  int get limit;
}
