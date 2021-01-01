import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/refresh/refresh_interface.dart';
import 'package:flutter/material.dart';

class PullDownRefreshWidget extends StatelessWidget {
  final Widget child;
  ///nếu muốn handle extend login thì truyền vào
  final Future<void> Function() onRefresh;
  final RefreshInterface controller;

  PullDownRefreshWidget({this.child, this.onRefresh, @required this.controller})
      : assert(controller != null);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        if (onRefresh.isNotNull) {
          return await onRefresh?.call();
        }
        await controller.refresh();
      },
    );
  }
}
