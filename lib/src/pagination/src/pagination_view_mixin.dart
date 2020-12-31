import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

mixin PaginationViewMixin<T extends StatefulWidget> on State<T> {
  ScrollController _scrollController;

  ScrollController get internalScrollController =>
      _scrollController = scrollController ?? ScrollController();

  ///override lại để lấy [ScrollController] truyền từ bên ngoài vào
  ///nếu ko thì [_scrollController] sẽ tự initialized ở [internalScrollController]
  ScrollController get scrollController;

  void onNextPage();

  @override
  void initState() {
    super.initState();
    internalScrollController.addListener(() {
      if (internalScrollController.position.pixels >=
              internalScrollController.position.maxScrollExtent &&
          !internalScrollController.position.outOfRange) {
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
