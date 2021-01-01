import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:core_plugin/src/pagination/src/pagination_view_mixin.dart';
import 'package:flutter/material.dart';

///only used for vertical ListView
class PaginationListView<Model extends Object> extends StatefulWidget {
  final PaginationInterface<Model> controller;
  final EdgeInsets padding;

  ///pass into if you want to control another things exclude pagination
  final ScrollController scrollController;

  ///build your main item
  final Widget Function(BuildContext context, int index, Model item)
      itemBuilder;

  final IndexedWidgetBuilder separatorBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder loadingIndicatorBuilder;

  /// if you wanna show loading effect item
  /// default is false
  /// and you need to pass [loadingEffectItemBuilder]
  final bool showInitialLoadingEffectItem;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder loadingEffectItemBuilder;

  PaginationListView({
    @required this.controller,
    @required this.itemBuilder,
    this.separatorBuilder,
    this.scrollController,
    this.loadingIndicatorBuilder,
    this.padding = EdgeInsets.zero,
    this.showInitialLoadingEffectItem = false,
    this.loadingEffectItemBuilder,
  })  : assert(controller != null),
        assert(itemBuilder != null),
        assert(
            !showInitialLoadingEffectItem || loadingEffectItemBuilder != null,
            '\nyou have to pass `loadingEffectItemBuilder` if you set `showInitialLoadingEffectItem` = true ');

  @override
  _PaginationListViewState<Model> createState() =>
      _PaginationListViewState<Model>();
}

class _PaginationListViewState<Model extends Object>
    extends State<PaginationListView>
    with PaginationViewMixin<Model, PaginationListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: internalScrollController,
        padding: widget.padding,
        itemBuilder: (context, index) {
          if (showInitialLoadingEffectItem) {
            return widget.loadingEffectItemBuilder?.call(context, index) ??
                SizedBox();
          }
          if (index < controller.items.length) {
            return widget.itemBuilder
                ?.call(context, index, controller.items.elementAt(index));
          }
          return widget.loadingIndicatorBuilder?.call(context) ??
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
              );
        },
        separatorBuilder: (context, index) =>
            widget.separatorBuilder?.call(context, index) ?? SizedBox(),
        itemCount: itemCount);
  }

  @override
  int get itemCount {
    if (super.itemCount.isNull)
      return (controller.items.length + (!controller.ended ? 1 : 0));
    return super.itemCount;
  }

  @override
  bool get showInitialLoadingEffectItem => widget.showInitialLoadingEffectItem;

  @override
  ScrollController get externalScrollController => widget.scrollController;

  @override
  PaginationInterface<Model> get controller => widget.controller;
}
