import 'dart:async';
import 'dart:ui';

import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ClimbingMessageBox extends BaseStatelessWidget {

  final String imageUrl;
  final String title;
  final String message;

  ClimbingMessageBox({
    this.imageUrl,
    this.title,
    this.message
  }):super();


  @override
  Widget build(BuildContext context) {
    double lastheight = MediaQueryData.fromWindow(window).padding.top;


    List<Widget> messageInfoList = new List();
    if ((this.imageUrl != null) && (this.imageUrl.length > 0))
    {

      Image image;
      if ((imageUrl.split("http://").length > 1) || (imageUrl.split("https://").length > 1))
      {
        image = Image.network(this.imageUrl, width: 70);
      }
      else
      {
         image = Image.asset(this.imageUrl, width: 70,);
      }

        messageInfoList.add(Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: image,
          ),
        ));
    }

    messageInfoList.add(Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: <Widget>[
            // 标题
            Container(
              alignment: Alignment.centerLeft,
              child: ClimbingCellText(
                data: this.title,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // 正文内容
            Container(
//                      width:260,
              child: ClimbingCellText(
                data:this.message,
                fontSize: 11,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),



          ],
        ),
      ),
    ));

    messageInfoList.add(Expanded(
      flex: 1,
      child:  Container(
        height:double.infinity,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top:5, right: 15),
        child: ClimbingCellText(
          data:"12:00",
          fontSize: 11,
        ),
      ),
    ));


    // TODO: implement build
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.fromLTRB(5, lastheight, 5, 0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        alignment: Alignment.center,
        height: 75,
        child: Row(
          children: messageInfoList,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}

class MessageBoxAnimateRoute extends PageRouteBuilder {
  final Widget widget;
  static bool enteryPage;

  MessageBoxAnimateRoute({
    this.widget,
  }) : super(
            opaque: false,
            barrierDismissible:true,
            transitionDuration: Duration(milliseconds: 600),
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation) {
              Timer.periodic(Duration(milliseconds: 6000), (Timer timer){
                Navigator.of(context).pop();
                timer.cancel();
              });
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                    begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                    parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
