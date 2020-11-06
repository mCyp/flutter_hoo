import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/style/res/gaps.dart';
import 'package:flutter_hoo/style/theme/strings.dart';
import 'package:flutter_hoo/widget/state_layout.dart';

class RefreshListView extends StatefulWidget {
  RefreshListView(
      {@required this.onRefresh,
      @required this.itemBuilder,
      @required this.itemCount,
      this.onLoadMore,
      this.hasMore,
      this.stateType,
      this.pageSize,
      this.padding,
      this.itemExtent});

  final RefreshCallback onRefresh;
  final LoadMoreCallback onLoadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;
  final int pageSize;
  final EdgeInsetsGeometry padding;
  final double itemExtent;

  @override
  _RefreshListViewState createState() => _RefreshListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _RefreshListViewState extends State<RefreshListView> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    Widget child = RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: widget.itemCount == 0
          ? StateLayout(
              type: widget.stateType,
              url: "assets/images/empty_bg.jpg",
              hintText: "暂时没有鞋子哦",
            )
          : GridView.builder(
              itemCount: widget.onLoadMore == null
                  ? widget.itemCount
                  : widget.itemCount + 1,
              padding: widget.padding,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              itemBuilder: (BuildContext context, int index) {
                if (widget.onLoadMore == null)
                  return widget.itemBuilder(context, index);
                else {
                  return index < widget.itemCount
                      ? widget.itemBuilder(context, index)
                      : MoreWidget(
                          widget.itemCount, widget.pageSize, widget.hasMore);
                }
              }
         /* gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemBuilder: (BuildContext context, int index) {
            if (widget.onLoadMore == null)
              return widget.itemBuilder(context, index);
            else {
              return index < widget.itemCount
                  ? widget.itemBuilder(context, index)
                  : MoreWidget(
                  widget.itemCount, widget.pageSize, widget.hasMore);
            }
          }*/),
    );
    return SafeArea(
      child: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent &&
              note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: child,
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.onLoadMore == null) return;
    if (_loading) return;
    if (!widget.hasMore) return;

    _loading = true;
    await widget.onLoadMore();
    _loading = false;
  }
}

class MoreWidget extends StatelessWidget {
  final int itemCount;
  final int pageSize;
  final bool hasMore;

  MoreWidget(this.itemCount, this.pageSize, this.hasMore);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasMore) const CupertinoActivityIndicator(),
          if (hasMore) Gaps.hGap4,
          Text(
            hasMore ? Strings.state_loading : Strings.state_empty,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
