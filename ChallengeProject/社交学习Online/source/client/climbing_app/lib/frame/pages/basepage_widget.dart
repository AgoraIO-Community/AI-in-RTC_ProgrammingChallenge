import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePageWidget extends CupertinoPageScaffold
{

  // 导航栏标题
  final String title ;
  // 导航栏标题颜色
  final Color titleColor;
  // 是否显示顶部导航栏
  final bool isShowNavigationBar;
  // 页面背景色
  final Color bgColor;
  // 导航栏右侧按钮
  final Widget rightItem;
  // 导航栏左侧按钮
  final Widget leftItem;
  // 导航栏返回键按钮颜色
  final Color navigationBarBackColor;
  // 导航栏背景色
  final Color navigationBarBackgroundColor;


  const BasePageWidget({
    Key key,
    this.title,
    this.titleColor,
    this.isShowNavigationBar = true,
    this.bgColor ,
    this.rightItem,
    this.leftItem,
    @required Widget child,
    this.navigationBarBackgroundColor,
    this.navigationBarBackColor,
  }):super(
      key: key,
      child:child
  );

  @override
  // TODO: implement backgroundColor
  Color get backgroundColor => ((){
      if (bgColor == null)
      {
        return Color(ClimbingTheme.themeBackgroundColor);
      }
      return bgColor;
  })();

  @override
  // TODO: implement navigationBar
  ObstructingPreferredSizeWidget get navigationBar => ((){
    if (this.isShowNavigationBar)
    {
      const Border _kDefaultNavBarBorder = Border(
        bottom: BorderSide(
          color: Color(0x4C000000),
          width: 0.0, // One physical pixel.
          style: BorderStyle.solid,
        ),
      );


      return CupertinoNavigationBar(
        middle: new Text((this.title != null) ? this.title : "", style: TextStyle(
          color: (titleColor == null)?Color(0xFF333333):titleColor,
        ),),
        trailing:rightItem,
        leading: leftItem,
        actionsForegroundColor:navigationBarBackColor,
        backgroundColor: navigationBarBackgroundColor,
        border:(navigationBarBackgroundColor == Colors.transparent)?null:_kDefaultNavBarBorder,
      );
    }
    return null;
  })();
}