import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/net/socket.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/home_message.dart';
import 'package:climbing_app/page/home_page.dart';
import 'package:climbing_app/page/home_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:climbing_app/page/home_mine.dart';



class ClimbingTabBar extends CupertinoTabScaffold {

  static bool _isInitialcaller = false;

  ClimbingTabBar({
    Key key
  }): super(
          key:key,
          backgroundColor:Color(ClimbingTheme.themeBackgroundColor),
          tabBar:((){

            // 初始化标签栏数据
            List<BottomNavigationBarItem> tabarItems = new List();
            for (var i = 0; i<items.length; i++)
            {
              Map itemInfo = items[i];
              tabarItems.add(
                  BottomNavigationBarItem(
                    icon: itemInfo["icon"],
                    activeIcon: itemInfo["activeIcon"],
                    title: Text(itemInfo["title"]),
                  )
              );
            }

            return CupertinoTabBar(
              iconSize: 24,
              items: tabarItems,
              border:null,
            );

          })(),
          tabBuilder:(context, index){
              return CupertinoTabView(
                builder: (context){
                  if (_isInitialcaller == false)
                  {
                    _isInitialcaller = true;
                    print("connect socket");
                    _connectSocket(context);
                    // 注册登陆成功监听
                    KOBServer.registerKVO(Object(), kLoginSuccessNotification, (Object obj){
                      // 登陆成功
                      NetSocket.initital(context);
                    });
                  }


                  // 返回配置好的page页面
                  Widget page = ClimbingTabBar.items[index]["page"];
                  return page;
                },
              );
          }
      );


  static void _connectSocket(BuildContext context){

    // 初始化socket
    KeyValueModel()
        .where({"key":kPlatformUserInfo})
        .queryOne()
        .then((rRsp){
      if (rRsp != null)
      {

        NetKit.post(
            path: "/oauth/checkuser",
            needToken: true,
            refreshToken: true,
            isShowLoading: false,
            isShowMsg: false
        ).then((cRsp){

          Map status = cRsp["status"];
          if (status["code"] == 1)
          {
            // 登陆成功
            NetSocket.initital(context);
          }
        });
      }
    });
  }

  static List<Map<String, Object>> _items = null;
  static List<Map<String, Object>> get items => ((){
    if (_items == null)
      {
        // 初始化信息,tabBar信息
        List<Map<String, Object>> list = new List();
        Map<String, Object> item = null;

        item = new Map();
        item["title"] = "首页";
        item["icon"] = Icon(CupertinoIcons.home);
        item["page"] = new HomePage();
        list.add(item);

        item = new Map();
        item["title"] = "课堂";
        item["icon"] = Icon(CupertinoIcons.search);
        item["page"] = new HomeSearch();
        list.add(item);

        item = new Map();
        item["title"] = "场圈";
        item["icon"] = Icon(CupertinoIcons.book);
        item["page"] = new HomeMessage();
        list.add(item);

        item = new Map();
        item["title"] = "我的";
        item["icon"] = Icon(CupertinoIcons.person);
        item["page"] = new HomeMine();
        list.add(item);

        _items = list;
      }
      return _items;
  })();


}