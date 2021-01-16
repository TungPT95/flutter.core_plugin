abstract class PaginationInterface<Model> {
  void nextPage();

  List<Model> get items;
  ///[ended] = true nếu đã load tới cuối page
  bool get ended;

  int get page;

  int get limit;

  ///[refreshing] = true nếu đang refresh
  bool get refreshing;

  ///[loading] = true nếu đang loading
  bool get loading;
}
