abstract class PaginationInterface<Model> {
  void nextPage();

  List<Model> get items;

  bool get ended;

  int get page;

  int get limit;

  ///[refreshing] = true nếu đang refresh
  bool get refreshing;

  ///[loading] = true nếu đang loading
  bool get loading;
}
