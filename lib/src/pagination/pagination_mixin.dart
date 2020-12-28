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

  void load() {
    _startLoading();
  }

  Future get _refreshComplete => _completer.future;

  ///must call super before handle your logic
  ///override to handle your additional logic, e.g: calling api from page 1
  @mustCallSuper
  Future<void> refresh() async {
    _completer = Completer();
    load();
    await _refreshComplete;
    reset();
  }

  ///action for calling api
  ///must call super before handle your logic
  ///override to handle your additional logic, e.g: load the next page
  @mustCallSuper
  @override
  void nextPage() {
    if (_loadWhen() ?? false) {
      page += limit;
    }
  }

  ///condition for loading more
  ///override to handle your additional logic
  bool _loadWhen() => !isEndOfList;

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
  ///call when calling your api completely
  void _completeLoading() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer?.complete();
    }
  }

  ///no need to override
  void addMore({List<T> nextItems}) {
    if (nextItems.isNull) {
      return;
    }
    (_items ??= []).addAll(nextItems);
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
