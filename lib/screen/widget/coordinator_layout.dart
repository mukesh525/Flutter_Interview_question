import 'package:flutter/material.dart';
import 'header.dart';

class CoordinatorLayout extends StatefulWidget {
  CoordinatorLayout({
    Key key,
    this.header,
    this.body,
    this.scrollController,
    this.snap = true,
    this.overlap = false,
  }) : super(key: key);
  final SliverCollapseHeader header;
  final Widget body;
  final ScrollController scrollController;
  final bool snap;
  final bool overlap;
  @override
  _CoordinatorLayoutState createState() => _CoordinatorLayoutState();
}

class _CoordinatorLayoutState extends State<CoordinatorLayout> {
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return buildNestedScrollView();
  }

  Widget buildNestedScrollView() {
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          return false;
        },
        child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              List<Widget> children = [
                widget.header,
              ];
              return children;
            },
            body: SingleChildScrollView(child: widget.body)));
  }
}
