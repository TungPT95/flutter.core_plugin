import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

mixin PaginationViewMixin<T extends StatefulWidget> on State<T> {
  ScrollController _scrollController;

  ///override lại để lấy [ScrollController] truyền từ bên ngoài vào
  ///nếu ko thì [_scrollController] sẽ tự initialized ở [initState]
  ScrollController get scrollController;

  void onNextPage();

  @override
  void initState() {
    super.initState();
    _scrollController = scrollController ?? ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        onNextPage();
      }
    });
  }

  @override
  void dispose() {
    //call disposing nếu controller ko đc truyền từ bên ngoài
    if (scrollController.isNull || _scrollController.isNotNull) {
      _scrollController?.dispose();
    }
    super.dispose();
  }
}
