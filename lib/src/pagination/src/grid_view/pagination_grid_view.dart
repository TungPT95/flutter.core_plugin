import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:core_plugin/src/pagination/src/pagination_view_mixin.dart';
import 'package:flutter/material.dart';

///only used for vertical GridView
class PaginationGridView<T extends Object> extends StatefulWidget {
  ///your BLOC must be used this mixin [ListViewHelper]
  final PaginationInterface<T> controller;
  final EdgeInsets padding;

  ///pass into if you want to control another things exclude pagination
  final ScrollController scrollController;

  ///build your main item
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder loadingIndicatorBuilder;

  /// if you wanna show loading effect item
  /// default is false
  /// and you need to pass [loadingEffectItemBuilder]
  final bool showInitialLoadingEffectItem;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  PaginationGridView(
      {@required this.controller,
      @required this.itemBuilder,
      @required this.gridDelegate,
      this.scrollController,
      this.loadingIndicatorBuilder,
      this.padding = EdgeInsets.zero,
      this.showInitialLoadingEffectItem = false,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 10})
      : assert(
            !showInitialLoadingEffectItem || loadingEffectItemBuilder != null,
            '\nyou have to pass `loadingEffectItemBuilder` if you set `showInitialLoadingEffectItem` = true ');

  @override
  _PaginationGridViewState createState() => _PaginationGridViewState();
}

class _PaginationGridViewState extends State<PaginationGridView>
    with PaginationViewMixin {
  double get _itemRatio => widget.gridDelegate.childAspectRatio;

  double get _itemWidth {
    final paddingLeftOfGrid = widget.padding?.left ?? 0;
    final paddingRightOfGrid = widget.padding.right ?? 0;
    final paddingBetweenItem = widget.gridDelegate.crossAxisSpacing *
        (widget.gridDelegate.crossAxisCount - 1);
    return (context.screenSize.width -
            (paddingLeftOfGrid + paddingRightOfGrid + paddingBetweenItem)) /
        widget.gridDelegate.crossAxisCount;
  }

  double get _itemHeight => _itemWidth / _itemRatio;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: internalScrollController,
        padding: widget.padding,
        itemBuilder: (context, index) {
          if (widget.showInitialLoadingEffectItem) {
            return Container(
              height: _itemHeight,
              child: Row(
                children: List.generate(
                  widget.gridDelegate.crossAxisCount,
                  (index) {
                    return Expanded(
                      child: Padding(
                        padding: index == widget.gridDelegate.crossAxisCount - 1
                            ? EdgeInsets.zero
                            : EdgeInsets.only(
                                right: widget.gridDelegate.crossAxisSpacing),
                        child: widget.loadingEffectItemBuilder
                            ?.call(context, index),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          if (index == _itemCount - 1) {
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
          }
          return Container(
            height: _itemHeight,
            child: Row(
              children: List.generate(widget.gridDelegate.crossAxisCount, (i) {
                final itemIndex =
                    widget.gridDelegate.crossAxisCount * index + i;
                //item cuôi cùng của 1 hàng
                final isLastItemInRow =
                    i == widget.gridDelegate.crossAxisCount - 1;
                //[itemIndex] vẫn thuộc items;
                final isValidIndex = itemIndex < widget.controller.items.length;
                return Expanded(
                    child: isValidIndex
                        ? Padding(
                            padding: isLastItemInRow
                                ? EdgeInsets.zero
                                : EdgeInsets.only(
                                    right:
                                        widget.gridDelegate.crossAxisSpacing),
                            child: widget.itemBuilder?.call(context, itemIndex,
                                widget.controller.items.elementAt(itemIndex)))
                        : SizedBox());
              }),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            SizedBox(height: widget.gridDelegate.mainAxisSpacing),
        itemCount: _itemCount);
  }

  ///tính itemCount trong 2 trường hợp
  ///khi loading [showInitialLoadingEffectItem] =true: show shimmer khi loading lần đầu tiên
  ///khi chưa phải là page cuối cùng, thì cuối list cần phải show loading indicator
  int get _itemCount {
    if (widget.showInitialLoadingEffectItem) {
      return widget.loadingEffectItemCount;
    } else if (widget.controller.items.isNullOrEmpty) {
      return 0;
    }
    return ((widget.controller.items.length /
                widget.gridDelegate.crossAxisCount)
            .ceil() +
        (!widget.controller.ended ? 1 : 0));
  }

  @override
  void onNextPage() => widget.controller?.nextPage();

  @override
  ScrollController get scrollController => widget.scrollController;
}