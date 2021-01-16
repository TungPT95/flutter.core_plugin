import 'dart:async';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/foundation.dart';

mixin PaginationMixin<Model> implements PaginationRefreshInterface<Model> {
  Completer _completer;
  bool _refreshing = false;

  @override
  bool get refreshing => _refreshing;

  @override
  bool get loading => _completer.isNotNull && !_completer.isCompleted;

  @override
  int get page => _page;

  set page(value) {
    _page = value;
  }

  int _page = 0;

  @override
  int get limit => _limit;

  set limit(value) {
    limit = value;
  }

  int _limit = 10;

  @override
  List<Model> get items => _tempItems;
  List<Model> _items;

  ///[_tempItems] dùng cho việc hiển thị
  ///trường hợp khi [_items] bị  clear, thì nó sẽ đc dùng để hiển thị item, tránh trường họp khi user scrolldown index bị out of range
  ///vì [_items] đã bị clear trong hàm [refresh]
  List<Model> _tempItems;

  ///phải override lại để call api
  @mustCallSuper
  void load() {
    _startLoading();
  }

  ///condition for loading more
  ///override (NẾU MUỐN): để biết đc khi nào có thể loadmore
  ///call super sau cùng các condition khác
  @mustCallSuper
  bool loadWhen() => !loading && !refreshing && !ended;

  ///no need to override
  ///phải call khi load xong và trc khi call [addMore]
  void completeLoading() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer?.complete();
      _completer = null;
      _refreshing = false;
    }
  }

  ///no need to override
  ///phải call sau khi call [completeLoading] để add thêm item vào [_items]
  void addMore({List<Model> nextItems}) {
    completeLoading();
    if (nextItems.isNull) {
      return;
    }
    (_items ??= []).addAll(nextItems);
    _tempItems = List.of(_items);
  }

  ///không cần override
  ///must call super before handle your extend logic
  @mustCallSuper
  Future<void> refresh() async {
    //reset page về 0
    _reset();
    //clear hết các item trong list
    _clear();
    _refreshing = true;
    //start call service
    try {
      load();
    } catch (_) {
      //nếu override lại load() mà throw exception
      //thì stop loading
      //và trạng thái của _refreshing trở về false
      //items trả về như cũ
      _revertItems(items: items);
    }
    await _refreshComplete;
  }

  void _revertItems({List<Model> items}) {
    addMore(nextItems: items);
  }

  ///không cần override
  ///action for calling api
  @mustCallSuper
  @override
  void nextPage() {
    if (loadWhen() ?? false) {
      _page += 1;
      load();
    }
  }

  Future get _refreshComplete => _completer.future;

  ///action for calling api
  ///clear list and reset page = 1
  ///no need to override
  void _reset() {
    _page = 0;
  }

  ///không cần override
  void _startLoading() {
    _completer = Completer();
  }

  ///không cần override
  ///clear [items], e.g: refresh the list need to clear list first
  void _clear() {
    _items?.clear();
  }

  ///no need to override
  @override
  bool get ended => items.isNull
      ? false
      : ((page == 0 && items.isEmpty) || items.length < (page + 1) * _limit);
}
