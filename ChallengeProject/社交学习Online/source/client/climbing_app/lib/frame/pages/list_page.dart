import 'package:flutter/material.dart';

typedef HeaderWidgetBuild = Widget Function(BuildContext context, int position);
typedef ItemWidgetBuild = Widget Function(BuildContext context, int position);
typedef ItemClickListener = Function(BuildContext context, int position);

class ListPage extends StatefulWidget {
  int headerCount;
  int itemCount;
  ItemWidgetBuild itemWidgetCreator;
  HeaderWidgetBuild headerCreator;
  ItemClickListener itemClickListener;

  ListPage(
      {Key key,
      this.itemCount,
      this.headerCount,
      this.itemWidgetCreator,
      this.headerCreator,
      this.itemClickListener})
      : super(key: key);

  @override
  ListPageState createState() {
    return new ListPageState();
  }
}

class ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemBuilder: (BuildContext context, int position) {
            return buildItemWidget(context, position);
          },
          itemCount: _getListCount()),
    );
  }

  int _getListCount() {
    int itemCount = widget.itemCount;
    return getHeaderCount() + itemCount;
  }

  int getHeaderCount() {
    int headerCount = widget.headerCount != null ? widget.headerCount : 0;
    return headerCount;
  }

  Widget _headerItemWidget(BuildContext context, int index) {
    if (widget.headerCreator != null) {
      return widget.headerCreator(context, index);
    } else {
      return new GestureDetector(
        child: new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Text("Header Row $index")),
        onTap: () {
          print('header click $index --------------------');
        },
      );
    }
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index < getHeaderCount()) {
      return _headerItemWidget(context, index);
    } else {
      int pos = index - getHeaderCount();
      return _itemBuildWidget(context, pos);
    }
  }

  Widget _itemBuildWidget(BuildContext context, int index) {
    if (widget.itemWidgetCreator != null) {
      var itemWidget = widget.itemWidgetCreator(context, index);
      return new GestureDetector(
        child: itemWidget,
        onTap: () {
          if (widget.itemClickListener != null) {
            widget.itemClickListener(context, index);
          }
        },
      );
    } else {
      return new GestureDetector(
        child: new Padding(
            padding: new EdgeInsets.all(10.0), child: new Text("Row $index")),
        onTap: () {
          print('click $index --------------------');
        },
      );
    }
  }
}
