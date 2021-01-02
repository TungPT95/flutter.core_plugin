import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:flutter/material.dart';

mixin PaginationViewMixin<T extends StatefulWidget> on State<T> {
  ///override để lấy [widget.controller] đc truyền từ ngoài vào
  PaginationInterface get controller;

  ///override để tính chiều dài của list
  @mustCallSuper
  int get itemCount {
    if (showInitialLoadingEffectItem) {
      return controller?.limit;
    } else if (controller.items.isNullOrEmpty) {
      return 0;
    }
    return null;
  }

  ///override để lấy [widget.showInitialLoadingEffectItem] đc truyền từ ngoài vào
  bool get showInitialLoadingEffectItem;

  ///override lại để lấy [ScrollController] truyền từ bên ngoài vào
  ///nếu ko thì [_internalScrollController] sẽ tự initialized ở [internalScrollController]
  ScrollController get externalScrollController;

  /// NHỮNG FUNCTION KO CẦN PHẢI OVERRIDE (BEGIN)

  ///không cần phải override
  ScrollController internalScrollController;

  /// NHỮNG FUNCTION KO CẦN PHẢI OVERRIDE (END)

  @override
  void initState() {
    super.initState();
    // print('[TUNG] ===> initState');
    (internalScrollController = externalScrollController ?? ScrollController())
        .addListener(() {
      // print('[TUNG] ===> ');
      if (internalScrollController.position.pixels >=
              internalScrollController.position.maxScrollExtent &&
          !internalScrollController.position.outOfRange) {
        // print('[TUNG] ===> nextPage');
        controller.nextPage();
      }
    });
  }

  @override
  void dispose() {
    //call disposing nếu controller ko đc truyền từ bên ngoài
    if (externalScrollController.isNull || internalScrollController.isNotNull) {
      internalScrollController?.dispose();
    }
    super.dispose();
  }
}
