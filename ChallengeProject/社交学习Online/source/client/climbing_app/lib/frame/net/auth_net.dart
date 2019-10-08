

import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'dart:convert' as convert;

import 'package:climbing_app/frame/net/service_url.dart';


class AuthNetKit
{

  static Future FutureSyncGetUserInfo()
  async {
    var a = await NetKit.post(
      path:"/rest/getuserinfo",
      isShowLoading: false,
      isShowMsg: false,
      needToken: true,
    );
    // 获取用户信息
    return a;
  }

  static void getUserInfo({
    Function(dynamic, Error) callback
  })
  {
    // 获取用户信息
    NetKit.post(
      path:"/rest/getuserinfo",
      isShowLoading: false,
      isShowMsg: false,
      needToken: true,
    ).then((r){

      Map status = r["status"];
      if (status["code"] == 1)
      {
        // 通知刷新UI
        KOBServer.postKVO(kGetUserInfoNotification, r["custom"]);

        // 插入数据库
        KeyValueModel().replaceOrInsertModel({ "key":kPlatformUserInfo, "value":convert.jsonEncode(r["custom"])}).then((_)=>null);
      }

      if (callback != null)
      {
          return callback(r, null);
      }

    }).catchError((e){

        if (callback != null)
        {
          return callback(null, e);
        }

    });
  }


  static void getToken({
    String loginid = "",
    String password = "",
    Function(dynamic, Error) callback
  })
  {

    NetKit.post(
        path: "/oauth/token",
        data: {"loginid": loginid, "password": password},
        isShowMsg: false,
        isShowLoading: false,
        refreshToken: false
    )
        .then((r) async {

        Map status = r["status"];
        if (status["code"] == 1)
        {
          // 将token存储之本地
          await KeyValueModel().replaceOrInsertModel({
            "key": kPlatformAccessToken,
            "value": convert.jsonEncode(r["custom"])
          });
        }

        if (callback != null)
        {
          callback(r, null);
        }

    }).catchError((e){

      if (callback != null)
      {
        callback(null, e);
      }

    });

  }

  static Future refreshToken({
    Future Function(dynamic, Error) callback
  })
  async {

    Map localToken =  await KeyValueModel().where({"key":kPlatformAccessToken}).queryOne();

    String tS = localToken["value"];
    Map t = convert.jsonDecode(tS);
    String refreshToken = t["refreshToken"];

    Map r = await NetKit.post(
        path: "/oauth/refreshtoken",
        isShowMsg: false,
        isShowLoading: false,
        refreshToken: false,
        needToken: false,
        data: {
          "refreshToken":refreshToken
        }
    );

    Map status = r["status"];
    if (status["code"] == 1)
    {
      // 将token存储之本地
      await KeyValueModel().replaceOrInsertModel({
        "key": kPlatformAccessToken,
        "value": convert.jsonEncode(r["custom"])
      });
    }

    if (callback != null)
    {
      return callback(r, null);
    }
  }

}