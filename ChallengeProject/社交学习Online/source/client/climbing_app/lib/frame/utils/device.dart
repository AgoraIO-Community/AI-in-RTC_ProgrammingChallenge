import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ClimbingDeviceUtil {

  // 获取当前操作系统环境
  static String get PlatformOS => Platform.operatingSystem;

  // 获取设备宽高度
  static Size get deviceSize => window.physicalSize;

  // 状态栏高度
  static double get statusBarHeight => MediaQueryData.fromWindow(window).padding.top;

  // 获取设备唯一标识码
//  static String get deviceUUID => FlutterGetuuid.platformUid;

  // 获取屏幕像素
  static Size  get screenPixel => (() {
    double pixel = window.devicePixelRatio;
    double width = deviceSize.width/pixel;
    double height = deviceSize.height/pixel;
    return new Size(width, height);
  })();

  static double platformWithDouble({ double android, double ios }){
    if (ClimbingDeviceUtil.PlatformOS == "ios")
    {
      return ios;
    }
    else
    {
      return android;
    }
  }

}