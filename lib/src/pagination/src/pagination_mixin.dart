import 'dart:async';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/foundation.dart';

mixin PaginationMixin<Model> implements PaginationRefreshInterface<Model> {
  Completer _completer;

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
  List<Model> get items => _items;
  List<Model> _items;

  ///phải override lại để call api
  @mustCallSuper
  void load() {
    _startLoading();
  }

  ///condition for loading more
  ///phải override để biết đc khi nào có thể loadmore hay refresh lại page
  ///call super sau cùng các condition khác
  @mustCallSuper
  bool loadWhen() => !ended;

  ///no need to override
  ///phải call khi load xong và trc khi call [addMore]
  void completeLoading() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer?.complete();
    }
  }

  ///no need to override
  ///phải call sau khi call [completeLoading] để add thêm item vào [_items]
  void addMore({List<Model> nextItems}) {
    if (nextItems.isNull) {
      return;
    }
    (_items ??= []).addAll(nextItems);
  }

  ///không cần override
  ///must call super before handle your extend logic
  @mustCallSuper
  Future<void> refresh() async {
    load();
    await _refreshComplete;
    reset();
  }

  ///không cần override
  ///action for calling api
  @mustCallSuper
  @override
  void nextPage() {
    if (loadWhen() ?? false) {
      _page += _limit;
      load();
    }
  }

  Future get _refreshComplete => _completer.future;

  ///action for calling api
  ///clear list and reset page = 1
  ///no need to override
  void reset() {
    _page = 0;
    clear();
  }

  ///không cần override
  void _startLoading() {
    _completer = Completer();
  }

  ///không cần override
  ///clear [items], e.g: refresh the list need to clear list first
  void clear() {
    _items?.clear();
  }

  ///no need to override
  @override
  bool get ended => items.isNull
      ? false
      : ((_page == 0 && items.isEmpty) || items.length < _page + _limit);
}
