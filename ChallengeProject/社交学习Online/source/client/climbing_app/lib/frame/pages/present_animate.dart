import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class PresentingTransitionAnimate extends PageRouteBuilder
{

  final Widget widget;
  final bool showCloseButton;

  PresentingTransitionAnimate({
    this.widget,
    this.showCloseButton = true,
  }) : super(
      opaque: false,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation) {

        if (showCloseButton == false)
        {

          return Scaffold(
            body:  Container(
              decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      offset: Offset(0, -0.5),
                      color: Color(0x11000000),
                      spreadRadius: 5,
                      blurRadius: 5,

                    )
                  ]
              ),
              child: widget,
            ),
          );
        }


        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      offset: Offset(0, -0.5),
                      color: Color(0x11000000),
                      spreadRadius: 5,
                      blurRadius: 5,

                    )
                  ]
                ),
                child: widget,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CupertinoButton(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: (){
                    UIKit.popWidget(context: context);
                  },
                ),
              )
            ],
          ),
        );
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2,
          Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
              begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
              .animate(CurvedAnimation(
              parent: animation1, curve: Curves.decelerate)),
          child: child,
        );
      });


}