import 'package:common_listview/src/widgets/placeholders.dart';
import 'package:flutter/material.dart';

import 'widgets/loading_indicator.dart';

class VPaginatedList extends StatelessWidget {
  final bool loading;
  final int page;
  final String? errorMsg;
  final int length;
  final Widget? emptyPlaceHolder;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext c, int i) itemBuilder;
  final double? height;
  final EdgeInsets? padding;
  final Function onNext;
  final Color? dividerColor;
  final Axis scrollDirection;
  final Widget? separator;
  final Widget? loadingPlaceholder;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final TextStyle? placeholderTextStyle;

  const VPaginatedList({
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
    this.dividerColor,
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
              separatorBuilder: (c, i) =>
                  separator ??
                  Divider(
                    height: height,
                    color: dividerColor,
                  ),
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
