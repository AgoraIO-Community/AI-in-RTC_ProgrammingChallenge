import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page_tab1.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Scaffold之后初始化ScreenUtil
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          title: new TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (index) {},
            tabs: <Widget>[
              new Tab(
                icon: Text(
                  "首页",
                  style: TextStyle(color: Color(0xff000000), fontSize: 15),
                ),
              ),
              new Tab(
                icon: Text(
                  "发现",
                  style: TextStyle(color: Color(0xff000000), fontSize: 15),
                ),
              ),
              new Tab(
                icon: Text(
                  "快讯",
                  style: TextStyle(color: Color(0xff000000), fontSize: 15),
                ),
              ),
            ],
            controller: _tabController,
          ),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new HomePageTab1(),
          new Center(child: new Text('发现')),
          new Center(child: new Text('快讯')),
        ],
      ),
    );
  }
}
