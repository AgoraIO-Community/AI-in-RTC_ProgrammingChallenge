import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/db/sqlite.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/net/socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/page/tabbar_page.dart';
import 'frame/pages/basepage_widget.dart';


// ignore: must_be_immutable
class ClimbingApp extends BaseStatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ClimbingAppState();
  }
}

class _ClimbingAppState extends State<BaseStatefulWidget> {

  @override
  void initState() {
    // 初始化数据库
    ClimbingSqliteHelper.createTables();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 启动页面 -> 主页面
    return MaterialApp(
        title: "kkpt",
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: new BasePageWidget(
            child: new ClimbingTabBar(),
            isShowNavigationBar: false,
          ),
        ));
  }
}

void main() => runApp(ClimbingApp());
