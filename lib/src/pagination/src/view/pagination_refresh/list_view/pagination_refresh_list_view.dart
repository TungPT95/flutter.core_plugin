import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/material.dart';

class PaginationRefreshListView<Model> extends StatefulWidget {
  final PaginationRefreshInterface<Model> controller;
  final Future<void> Function() onRefresh;

  final EdgeInsets padding;

  final ScrollController scrollController;

  final Widget Function(BuildContext context, int index, Model item)
      itemBuilder;

  final IndexedWidgetBuilder separatorBuilder;

  final WidgetBuilder loadingIndicatorBuilder;

  final bool showInitialLoadingEffectItem;

  final IndexedWidgetBuilder loadingEffectItemBuilder;

  PaginationRefreshListView({
    @required this.controller,
    @required this.itemBuilder,
    this.padding,
    this.scrollController,
    this.separatorBuilder,
    this.loadingIndicatorBuilder,
    this.showInitialLoadingEffectItem,
    this.loadingEffectItemBuilder,
    this.onRefresh,
  });

  @override
  _PaginationRefreshListViewState createState() =>
      _PaginationRefreshListViewState();
}

class _PaginationRefreshListViewState extends State<PaginationRefreshListView> {
  @override
  Widget build(BuildContext context) {
    return PullDownRefreshWidget(
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      child: PaginationListView(
        controller: widget.controller,
        itemBuilder: widget.itemBuilder,
        loadingEffectItemBuilder: widget.loadingEffectItemBuilder,
        loadingIndicatorBuilder: widget.loadingIndicatorBuilder,
        padding: widget.padding,
        scrollController: widget.scrollController,
        separatorBuilder: widget.separatorBuilder,
        showInitialLoadingEffectItem: widget.showInitialLoadingEffectItem,
      ),
    );
  }
}
