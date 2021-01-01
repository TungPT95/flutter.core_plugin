import 'dart:async';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/foundation.dart';

mixin PaginationMixin<T> implements PaginationRefreshInterface<T> {
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
  List<T> get items => _items;
  List<T> _items;

  ///must call super before handle your extend logic
  @mustCallSuper
  void load() {
    _startLoading();
  }

  ///must call super before handle your extend logic
  @mustCallSuper
  Future<void> refresh() async {
    load();
    await _refreshComplete;
    reset();
  }

  ///action for calling api
  ///must call super before handle your extend logic
  @mustCallSuper
  @override
  void nextPage() {
    if (loadWhen() ?? false) {
      _page += _limit;
      load();
    }
  }

  ///no need to override
  ///call when calling your api completely
  void completeLoading() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer?.complete();
    }
  }

  Future get _refreshComplete => _completer.future;

  ///condition for loading more
  ///override to handle your additional logic
  bool loadWhen() => !ended;

  ///no need to override
  void addMore({List<T> nextItems}) {
    if (nextItems.isNull) {
      return;
    }
    (_items ??= []).addAll(nextItems);
  }

  ///clear list and reset page = 1
  ///no need to override
  void reset() {
    _page = 0;
    clear();
  }

  ///call when starting calling your api
  ///no need to override
  void _startLoading() {
    _completer = Completer();
  }

  ///no need to override
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
