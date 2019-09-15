import 'dart:io';
import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/net/auth_net.dart';
import 'package:climbing_app/frame/net/service_url.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

const DebugProxy = false;
const ProxyIP = "192.168.1.106";
const ProxyPort = 8888;

class NetKit {



  static String absolutePicURL(String path)
  {
    if ((path.split("http://").length > 1) ||
        (path.split("https://").length > 1))
    {
      return path;
    }

    String rootPath = servicePath['upload_rest_url'];

    return '$rootPath$path';
  }

  static Future uploadPost({
    String filePath,
    BuildContext context,
    bool isShowLoading = true,
    bool isShowMsg = true,
  }) {

    String name = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
    String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.from({
      "file": new UploadFileInfo(new File(filePath), "file",
          contentType: ContentType.parse("image/$suffix"))
    });

    return post(
      path: "/asset/rest/upload",
      data: formData,
      context: context,
      isShowLoading: isShowLoading,
      isShowMsg: isShowMsg,
      needToken: true,
      refreshToken: true
    );

  }

  static Future post({
    String path,
    Map data,
    BuildContext context,
    bool isShowLoading = true,
    bool isShowMsg = true,
    bool needToken = false,
    bool refreshToken = true,
  }) {
    return _request(
        path: path,
        data: data,
        context: context,
        isShowLoading: isShowLoading,
        isShowMsg: isShowMsg,
        needToken: needToken,
        refreshToken:refreshToken
    );
  }

  static Future _request({
    String path,
    String method = "post",
    Map data,
    BuildContext context,
    bool isShowLoading = true,
    bool isShowMsg = true,
    bool needToken = false,
    bool refreshToken = true,
  }) async {
    if (context == null) {
      isShowLoading = false;
      isShowMsg = false;
    }

    Response response;
    try {
      final String platformUrl = servicePath['platform_url'];
      String url = platformUrl;
      if (path.substring(0, 1) == "/") {
        url += path;
      } else {
        url += ("/" + path);
      }

      Dio dio = new Dio();

      // 数据抓包需要设置
      if (DebugProxy)
      {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          client.findProxy = (url) {
            return "PROXY $ProxyIP:$ProxyPort";
          };
        };
      }


      if (isShowLoading) {
        UIKit.showLoading(context: context);
      }
      Map<String, dynamic> headers = new Map();
      headers["User-Agent"] =  'Dart/2.4 (dart:io) Climbing/1.0 - (Platform:${ClimbingDeviceUtil.PlatformOS.toUpperCase()})';
      if (needToken == true)
      {
        Map map = await KeyValueModel().where({ "key" : kPlatformAccessToken }).queryOne();
        String result = map["value"];
        map = convert.jsonDecode(result);
        headers["authorization"] = 'Bearer ${map["token"]}';
      }
      response = await dio.request(
        url,
        options: Options(
            method: method,
            // 15 秒后超时
            connectTimeout: 15000,
            headers: headers
        ),
        data: data,
//      queryParameters: data
      );

      if (isShowLoading) {
        UIKit.hideLoading();
      }

      if (response.statusCode == 200) {
        Map result = (response.data as Map);
        Map status = result["status"];
        int code = status["code"];
        if (code == 1) {
          return result;
        }
        else if (code == 403)
        {

          // 刷新一次token，重新发送请求
          if (refreshToken)
          {
            return AuthNetKit.refreshToken(
                callback: (rRsp, rErr){
                    if (rErr != null)
                    {
                      if (isShowMsg)
                      {
                        UIKit.showMsg(
                          context: context,
                          msg: "身份认证出现异常，请重新登陆"
                        );
                      }
                      return Future.value(rRsp);
                    }

                    Map status = rRsp["status"];
                    if (status["code"] == 401)
                    {
                      if (isShowMsg)
                      {
                        UIKit.showMsg(
                            context: context,
                            msg: "请重新登陆"
                        );
                      }
                      return Future.value(rRsp);
                    }

                    // 重新刷新发送请求
                    return _request(
                      path:path,
                      method:method,
                      data:data,
                      context:context,
                      isShowLoading:isShowLoading,
                      isShowMsg:isShowMsg,
                      needToken:needToken,
                      refreshToken:refreshToken,
                    );
                }
            );
          } else {
            String msg = status["msg"];
            if (isShowMsg) {
              UIKit.showMsg(context: context, msg: msg);
            }
          }
        }
        else
        {
          String msg = status["msg"];
          if (isShowMsg)
          {
            UIKit.showMsg(context: context, msg: msg);
          }
        }
      }
    } catch (e) {
      if (isShowLoading) {
        UIKit.hideLoading();
      }

      if (isShowMsg) {
        UIKit.showMsg(context: context, msg: e.toString());
      }

      return {
        "status":{
          "code":0,
          "msg":"发生错误,请重新登陆"
        },
      };
    }

    if (isShowLoading) {
      UIKit.hideLoading();
    }
    return (response == null) ? {
      "status":{
        "code":0,
        "msg":"error net"
      },
    } : response.data;
  }
}
