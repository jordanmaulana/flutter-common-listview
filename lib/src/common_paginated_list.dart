import 'package:common_listview/src/widgets/placeholders.dart';
import 'package:flutter/material.dart';
import 'widgets/loading_indicator.dart';

/// [loading] when true, shows a circular loading indicator.
/// [page] current page.
/// [onNext] function is called when the user scrolls to the bottom of the list.
/// [length] number of items in the list.
/// [onRefresh] function is called when the user pulls to refresh the list.
/// [itemBuilder] function that builds the list item.
///
/// [errorMsg] error message to show when the list fails to load.
/// Commonly used when the list is empty.
///
/// [height] height of the divider
/// [padding] padding of the list
///
/// [separator] divider Widget between list items. Default is a [Divider].
/// If you want to change the default [Divider] to be your own, use this parameter.
/// [loadingPlaceholder] widget to show when the list is loading.
/// [scrollController] controller for the list view.
/// [physics] physics for the list view.
///
/// [placeholderTextStyle] style for the error message and no data message.
/// [emptyPlaceHolder] widget to show when the list is empty.

class CommonPaginatedList extends StatelessWidget {
  final bool loading;
  final int page;
  final Function onNext;
  final Axis scrollDirection;
  final int length;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext c, int i) itemBuilder;
  final String? errorMsg;
  final double? height;
  final EdgeInsets? padding;
  final Widget? separator;
  final Widget? loadingPlaceholder;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final TextStyle? placeholderTextStyle;
  final Widget? emptyPlaceHolder;

  const CommonPaginatedList({
    super.key,
    required this.loading,
    required this.page,
    required this.length,
    required this.itemBuilder,
    required this.onNext,
    required this.onRefresh,
    this.height,
    this.padding,
    required this.errorMsg,
    this.emptyPlaceHolder,
    this.scrollDirection = Axis.vertical,
    this.separator,
    this.loadingPlaceholder,
    this.scrollController,
    this.physics,
    this.placeholderTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (loading && page == 1) {
      return loadingPlaceholder ?? const LoadingIndicator();
    }
    if (errorMsg != null && page == 1) {
      return ErrorMessage(
        errorMsg,
        style: placeholderTextStyle,
      );
    }
    if (length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: emptyPlaceHolder ??
              NoData(
                style: placeholderTextStyle,
              ),
        ),
      );
    }
    return Stack(
      children: [
        NotificationListener(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: physics,
              controller: scrollController,
              scrollDirection: scrollDirection,
              padding: padding ?? const EdgeInsets.all(16.0),
              itemCount: length,
              separatorBuilder: (c, i) => separator ?? Divider(height: height),
              itemBuilder: itemBuilder,
            ),
          ),
          onNotification: (ScrollUpdateNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              onNext();
            }
            return true;
          },
        ),
        if (loading && page > 1) const NextPageLoading(),
      ],
    );
  }
}
