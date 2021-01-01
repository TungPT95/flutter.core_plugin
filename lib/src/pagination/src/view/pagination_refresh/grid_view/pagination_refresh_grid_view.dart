import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/material.dart';

class PaginationRefreshGridView<Model> extends StatefulWidget {
  final PaginationRefreshInterface<Model> controller;
  final Future<void> Function() onRefresh;
  final EdgeInsets padding;

  final ScrollController scrollController;

  final Widget Function(BuildContext context, int index, Model item)
      itemBuilder;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  final WidgetBuilder loadingIndicatorBuilder;

  final bool showInitialLoadingEffectItem;
  final IndexedWidgetBuilder loadingEffectItemBuilder;

  PaginationRefreshGridView(
      {this.controller,
      this.onRefresh,
      this.padding,
      this.scrollController,
      this.itemBuilder,
      this.gridDelegate,
      this.loadingIndicatorBuilder,
      this.showInitialLoadingEffectItem,
      this.loadingEffectItemBuilder});

  @override
  _PaginationRefreshGridViewState createState() =>
      _PaginationRefreshGridViewState();
}

class _PaginationRefreshGridViewState extends State<PaginationRefreshGridView> {
  @override
  Widget build(BuildContext context) {
    return PullDownRefreshWidget(
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      child: PaginationGridView(
        controller: widget.controller,
        itemBuilder: widget.itemBuilder,
        gridDelegate: widget.gridDelegate,
        showInitialLoadingEffectItem: widget.showInitialLoadingEffectItem,
        scrollController: widget.scrollController,
        padding: widget.padding,
        loadingIndicatorBuilder: widget.loadingIndicatorBuilder,
        loadingEffectItemBuilder: widget.loadingEffectItemBuilder,
      ),
    );
  }
}
