import 'package:core_plugin/src/pagination/refresh/refresh_interface.dart';
import 'package:flutter/material.dart';

class PullDownRefreshWidget extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final RefreshInterface controller;

  PullDownRefreshWidget({this.child, this.onRefresh, this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await controller.refresh();
      },
    );
  }
}
