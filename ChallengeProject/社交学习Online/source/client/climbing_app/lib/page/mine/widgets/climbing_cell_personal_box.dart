import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/db/sqlite.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/auth_net.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/page/login.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:climbing_app/page/mine/widgets/climbing_label_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

class ClimbingCellPersonalBox extends BaseStatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClimbingCellPersonalBoxState();
  }
}

class ClimbingCellPersonalBoxState extends State<ClimbingCellPersonalBox>
{
  @override
  void initState() {
    // TODO: implement initState

    // 注册用户信息获取通知
    KOBServer.registerKVO(this, kGetUserInfoNotification, (Object obj){
      setState(() {
        userInfo = obj;
      });
    });

    
    Future.microtask((){

      // 异步执行
      UIKit.showLoading(
          context: context
      );
      AuthNetKit.getUserInfo(callback: (result, e) {
        UIKit.hideLoading();

        if (e != null) {
          UIKit.showMsg(context: context, msg: e.toString());
          return;
        }

        Map status = result["status"];
        if ((status["code"] != 1) && (status["code"] != 403)) {
          String msg = status["msg"];
          UIKit.showMsg(
              context: context,
              msg:msg
          );
        }
      });

    });

  }

  final String defaultAvatarPng = "assets/images/default_avatar.png";
  Map userInfo;


  @override
  Widget build(BuildContext context) {
    // 获取用户信息
    if (userInfo == null)
    {
      // 未登陆状态
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: ClimbingDeviceUtil.statusBarHeight+10),
        child: Column(
          children: <Widget>[
            // 用户信息
            Container(
                width:100,height:100,
                child:CupertinoButton(
                  padding: EdgeInsets.zero,
                  disabledColor:Colors.transparent,
                  pressedOpacity:0.9,
                  child: Image.asset(defaultAvatarPng),
                  onPressed: () async {

                    UIKit.presentWidget(
                        target: LoginWidget(),
                        context: context
                    );

                  },
                )
            ),

            Container(
//          color:Color(0xFFFF0000),
              child: ClimbingCellText(
                data: "点击头像登陆",
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
              margin: EdgeInsets.only(right: 10),
            )
          ],
        ),
      );
    }

    List<Widget> lists = new List();
    for (Map info in userInfo["labels"])
    {
      // 0xF8CE60
      // 0x4A9D64
      // 0xbf5648
      lists.add(ClimbingLabelText(
        text:info["name"],
        themeColor: UIKit.labelLevelPaerser(info["level"]),
        margin: EdgeInsets.only(right: 5),
      ));
    }

    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: ClimbingDeviceUtil.statusBarHeight+10),
      child: Column(
        children: <Widget>[
          // 用户信息
          Row(
            children: <Widget>[
              Container(
                  width:100,height:100,
                  child:CupertinoButton(
                    padding: EdgeInsets.zero,
                    disabledColor:Colors.transparent,
                    pressedOpacity:0.9,
                    child: Image.asset(defaultAvatarPng),
                    onPressed: () async {

                    },
                  )
              ),
              Container(
                height: 100,
                alignment: Alignment.bottomLeft,
                child:  Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      child: ClimbingCellText(
                        data: userInfo["nickname"],
                        fontSize: 18,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: lists,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          // 关注粉丝
          Container(
//          color:Color(0xFFFF0000),
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  child: ClimbingCellText(
                    data: '关注 ${userInfo["totalFans"]}',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF),
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
                ClimbingCellText(
                  data: '粉丝 ${userInfo["totalRelates"]}',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ],
            ),
          )
        ],
      ),
    );

  }


//  ClimbingLabelText setLabel({
//    String text ,
//    int themeColor,
//  }) {
//    int fontColor = 0xFF000000 + themeColor;
//    int backgroundColor = 0x33000000 + themeColor;
//    int borderColor = 0xFF000000 + themeColor;
//
//
//    return ClimbingLabelText(
//      text: text,
//      fontColor: fontColor,
//      backgroundColor: backgroundColor,
//      borderColor: borderColor,
//      margin: EdgeInsets.only(right: 5),
//    );
//  }

}