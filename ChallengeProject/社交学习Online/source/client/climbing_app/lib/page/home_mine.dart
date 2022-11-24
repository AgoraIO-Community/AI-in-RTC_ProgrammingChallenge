import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/lessons/widgets/HomePageLive.dart';
import 'package:climbing_app/page/login.dart';
import 'package:climbing_app/page/mine/pages/home_mine_about.dart';
import 'package:climbing_app/page/mine/pages/home_mine_baseinfo.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_box.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_header.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_personal_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ClimbingListView extends BaseStatelessWidget
{

  static BuildContext _context = null;

  @override
  Widget build(BuildContext context) {

    _context = context;

    // TODO: implement build
    return ListView.separated(
      padding: EdgeInsets.only(top: 0),
      itemCount:lists.length,
      itemBuilder:  (context, index ){
        Map item = lists[index];
        return ClimbingCellBox(
          title: item["title"],
          icon: Icon(
            item["icon"],
            size:20,
            color: Color(ClimbingTheme.mineCellThemeColor),
          ),
          arrowTitle: item["arrowTitle"],
          rightArrowColor: Color(ClimbingTheme.mineCellThemeColor),
          textColor: Color(ClimbingTheme.mineCellThemeColor),
          onPress: item["onPress"],
        );
      },
      separatorBuilder:(context, index){
        Map item = lists[index];
        bool isSeprator = item["isSperator"];
        if ((isSeprator != null) && (isSeprator == true))
        {
          return Container(
            height: 20,
          );
        }
        return Container();
      },
    );
  }

  final List<Map> lists = ((){
    List<Map> datalist = new List();

    // 第1模块
    datalist.add(factoryCellItem(
      title: "基础资料",
      icon: CupertinoIcons.info,
      onPress: (){
        UIKit.pushWidget(
          target: HomeMineBaseInfo(),
          context: _context
        );
      },
    ));
    datalist.add(factoryCellItem(
        title: "进入我de直播室",
        icon: Icons.live_tv,
        onPress: (){


          NetKit.post(
            path: "/rest/request_openlive",
            context: _context,
            isShowMsg: true,
            isShowLoading: true,
            needToken: true,
            refreshToken: true,
          ).then((rRsp){

            Map status = rRsp["status"];
            if (status["code"] == 1)
            {
              UIKit.pushWidget(
                  target: HomePageLive(),
                  context: _context
              );
            }
          });


        },
        isSperator: true
    ));
//    datalist.add(factoryCellItem(
//        title: "我的关注",
//        icon: CupertinoIcons.settings_solid,
//        isSperator: true
//    ));

    // 第2模块
//    datalist.add(factoryCellItem(
//      title: "基础资料",
//      icon: CupertinoIcons.info,
//    ));
//    datalist.add(factoryCellItem(
//      title: "安全设置",
//      icon: CupertinoIcons.settings_solid,
//    ));
//    datalist.add(factoryCellItem(
//        title: "我的关注",
//        icon: CupertinoIcons.bell_solid,
//        isSperator: true
//    ));

    // 第3模块
//    datalist.add(factoryCellItem(
//      title: "系统设置",
//      icon: CupertinoIcons.settings_solid,
//    ));
    datalist.add(factoryCellItem(
      title: "关于我们",
      icon: CupertinoIcons.news_solid,
      onPress: (){
        UIKit.pushWidget(
          target: HomeMineAbout(),
          context: _context
        );
      }
    ));

    return datalist;
  })();

  static Map factoryCellItem({
    String title, IconData icon, String arrowTitle, bool isSperator  ,
    VoidCallback onPress
  }){
    Map item = new Map();
    item["title"] = title;
    item["icon"] = icon;
    item["arrowTitle"] = arrowTitle;
    item["isSperator"] = isSperator;
    item["onPress"] = onPress;
    return item;
  }
}

class HomeMine extends BaseStatelessWidget {

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return  BasePageWidget(
      title: "我的",
      bgColor:Color(ClimbingTheme.mineTopBackgroundColor),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ClimbingCellHeader(
              child: ClimbingCellPersonalBox(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color:Color(ClimbingTheme.themeBackgroundColor),
              child: ClimbingListView(),
            ),
          )
        ],
      ),
      isShowNavigationBar: false,
    );
  }



}