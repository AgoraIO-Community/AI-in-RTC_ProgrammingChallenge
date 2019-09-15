import 'dart:async';
import 'dart:ui';

import 'package:climbing_app/frame/pages/loading.dart';
import 'package:climbing_app/frame/pages/messagebox.dart';
import 'package:climbing_app/frame/pages/present_animate.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UIKit {

  static VoidCallback _hideLoadingBlock;

  // 信息提示框
  static Future showAlertDialog({
    String title,
    String message,
    BuildContext context,
    VoidCallback onConfirm,
    VoidCallback onCancel,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              new CupertinoButton(
                  onPressed: () {
                    if (onConfirm != null) onConfirm();
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
              new CupertinoButton(
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Navigator.of(context).pop();
                  },
                  child: Text('确认')),
            ],
          );
        });
  }

  // push 风格进入一张新的页面
  static void pushWidget({Widget target, BuildContext context}) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).push(new CupertinoPageRoute(builder: (_) {
      return target;
    }));
  }

  // present 风格打开页面
  static void presentWidget({Widget target, BuildContext context, bool showCloseButton}) {


    Navigator.of(
      context,
      rootNavigator: true
    ).push(PresentingTransitionAnimate(
      widget: target,
      showCloseButton: showCloseButton
    ));
  }

  // 退出一张界面
  static void popWidget({BuildContext context}) {
    Navigator.of(context).pop();
  }

  // 显示Loading提示框
  static void showLoading({BuildContext context}) {



    OverlayState overlayState = Overlay.of(context);

    var controllerShowAnim = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var opacityAnim1 = new Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);

    OverlayEntry entry = OverlayEntry(
        builder: (BuildContext context){
          return AnimatedBuilder(
            animation: opacityAnim1,
            child: Container(
              color:Colors.transparent,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x99000000),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(11),
                  child: ClimbingLoading(),
                ),
              ),
            ),
            builder: (context, child_to_build){
              return Opacity(
                opacity: opacityAnim1.value,
                child: child_to_build,
              );
            },
          );
        }
    );

    overlayState.insert(entry);

    // 启动动画
    controllerShowAnim.forward();


    _hideLoadingBlock = (){
      // 移除层可以通过调用OverlayEntry的remove方法。
      controllerShowAnim.addStatusListener((status){
        if (status == AnimationStatus.dismissed)
        {
          controllerShowAnim.dispose();
          entry.remove();
        }
      });
      controllerShowAnim.reverse();
    };

  }

  // 关闭Loadding提示框
  static void hideLoading(){
    if (_hideLoadingBlock != null)
    {
        _hideLoadingBlock();
        _hideLoadingBlock = null;
    }
  }

  // 中间tips提示信息
  static void showMsg({
    BuildContext context,
    String msg,
  }) {

    if (msg == null || (msg.length <= 0))
    {
      return ;
    }


    OverlayState overlayState = Overlay.of(context);

    var controllerShowAnim = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var opacityAnim1 = new Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);

    OverlayEntry entry = OverlayEntry(
      builder: (BuildContext context){
        return AnimatedBuilder(
          animation: opacityAnim1,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 180,
              ),
              decoration: BoxDecoration(
                color: Color(0x99000000),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.all(10),
              child: ClimbingCellText(
                data:(msg == null)?"":msg,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          builder: (context, child_to_build){
            return Opacity(
                opacity: opacityAnim1.value,
                child: child_to_build,
            );
          },
        );
      }
    );

    overlayState.insert(entry);

    controllerShowAnim.forward();


    Future.delayed(Duration(seconds: 2)).then((value) {
      // 移除层可以通过调用OverlayEntry的remove方法。
      controllerShowAnim.addStatusListener((status){
        if (status == AnimationStatus.dismissed)
        {
          controllerShowAnim.dispose();
          entry.remove();
        }
      });
      controllerShowAnim.reverse();
    });

  }

  // 顶部tips提示信息
  static void messagebox({
    BuildContext context,
    String title,
    String message,
    String imageUrl,
  }) {
    if (message == null || (message.length <= 0))
    {
      return ;
    }

//    print(imageUrl.split("http://").length > 1);
    
    Navigator.of(
        context,
        rootNavigator: true,
    )
        .push(MessageBoxAnimateRoute(widget: Container(
      width:100,
      height:100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ClimbingMessageBox(
        title: title,
        message: message,
        imageUrl: imageUrl,
      ),
    )));
  }



  // 解析标签等级
  static int labelLevelPaerser(int level)
  {

    if (level == 0)
    {
      // 灰色
      return 0x878787;
    }
    else if (level == 1)
    {
      // 主蓝色
      return 0x5cccd7;
    }
    else if (level == 2)
    {
      // 绿色
      return 0x4A9D64;
    }
    else if (level == 3)
    {
      // 红色
      return 0xbf5648;
    }
    else if (level == 4)
    {
      // 金色
      return 0xF8CE60;
    }

  }


  // 时间转换工具
  static String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {

      if (diff.inSeconds < 60)
      {
        time = '${diff.inSeconds}秒前';
      }
      else if (diff.inMinutes < 60)
      {
        time = '${diff.inMinutes}分钟前';
      }
      else if (diff.inHours < 24)
      {
        time = '${diff.inHours}小时前';
      }
      else
      {
        time = format.format(date);
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + '天前';
      } else {
        time = diff.inDays.toString() + '天前';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + '周前';
      }
      else if ((diff.inDays / 7).floor() > 3)
      {
        time = (diff.inDays / 7).floor().toString() + '周前';
      }
      else
      {
        var format = new DateFormat('yyyy-MM-d HH:mm');
        time = format.format(date);
      }
    }
    return time;
  }

}

