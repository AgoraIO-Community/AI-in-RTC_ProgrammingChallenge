import 'dart:async';
import 'dart:convert';

import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/auth_net.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWidget extends BaseStatelessWidget {
  static String _loginid = "";
  static String _pasword = "";

  final CupertinoTextField loginidField = CupertinoTextField(
    onChanged: (text) {
      _loginid = text;
    },
    prefix: Icon(
      CupertinoIcons.person_solid,
      color: Color(0xFFFFFFFF),
      size: 22,
    ),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
    maxLines: 1,
    cursorColor: Color(0xFFFFFFFF),
    placeholder: "账号名",
    placeholderStyle: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFFFFFFF)))),
  );

  final CupertinoTextField passwordField = CupertinoTextField(
    onChanged: (text) {
      _pasword = text;
    },
    prefix: Icon(
      CupertinoIcons.padlock,
      color: Color(0xFFFFFFFF),
      size: 22,
    ),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
    maxLines: 1,
    cursorColor: Color(0xFFFFFFFF),
    placeholder: "密码",
    obscureText: true,
    placeholderStyle: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFFFFFFF)))),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new BasePageWidget(
      title: "登陆",
      child: new Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 头像
            Container(
              child: Image.asset(
                "assets/images/default_avatar.png",
                width: 150,
              ),
            ),

            // 输入框
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: loginidField,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: passwordField,
            ),

            // 登陆按钮
            Container(
              height: 45,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              child: LoginButtonWidget(
                onLoginAction: () {
                  loginAction(context);
                },
              ),
            )
          ],
        ),
      ),
      isShowNavigationBar: false,
      bgColor: Color(ClimbingTheme.loginBgColor),
    );
  }

  Future loginAction(BuildContext context) async {

    UIKit.showLoading(context: context);

    AuthNetKit.getToken(
      loginid: _loginid,
      password: _pasword,
      callback: (tokenResult, tokenError){

        if (tokenError != null)
        {
          UIKit.hideLoading();
          UIKit.showMsg(
            context: context,
            msg: tokenError.toString()
          );
          return ;
        }

        Map status = tokenResult["status"];
        if (status["code"] == 1)
        {
          // 获取用户信息
          AuthNetKit.getUserInfo(callback: (result, e) {
            UIKit.hideLoading();

            if (e != null) {
              UIKit.showMsg(context: context, msg: e.toString());
              return;
            }

            Map status = result["status"];
            if (status["code"] == 1) {
              // 退出当前界面
              UIKit.popWidget(context: context);

              KOBServer.postKVO(kLoginSuccessNotification, {});
            }
            else
            {
              String msg = status["msg"];
              UIKit.showMsg(
                  context: context,
                  msg:msg
              );
            }
          });
        }
        else
        {
          UIKit.hideLoading();
          UIKit.showMsg(
            context: context,
            msg:status["msg"]
          );
        }
      }
    );

  }
}

class LoginButtonWidget extends BaseStatefulWidget {
  VoidCallback onLoginAction;

  LoginButtonWidget({this.onLoginAction}) : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginButtonState(onLoginAction: onLoginAction);
  }
}

class LoginButtonState extends State<LoginButtonWidget> {
  VoidCallback onLoginAction;

  LoginButtonState({this.onLoginAction}) : super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoButton(
      pressedOpacity: 0.6,
      color: Color(0xFFFFFFFF),
      child: Text(
        "登 陆",
        style:
            TextStyle(color: Color(ClimbingTheme.loginBgColor), fontSize: 15),
      ),
      onPressed: () {
        if (onLoginAction != null) this.onLoginAction();
      },
    );
  }
}
