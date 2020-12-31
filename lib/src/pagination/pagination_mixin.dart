import 'dart:async';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/pagination_interface.dart';
import 'package:core_plugin/src/pagination/refresh/refresh_interface.dart';
import 'package:flutter/foundation.dart';

mixin PaginationMixin<T> implements PaginationInterface, RefreshInterface {
  Completer _completer;

  int page = 0;
  int limit = 10;
  List<T> _items;

  List<T> get items => _items;

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
      page += limit;
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
  bool loadWhen() => !isEndOfList;

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
    page = 0;
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
  bool get isEndOfList => _items.isNull
      ? false
      : ((page == 0 && items.isEmpty) || _items.length < page + limit);
}
