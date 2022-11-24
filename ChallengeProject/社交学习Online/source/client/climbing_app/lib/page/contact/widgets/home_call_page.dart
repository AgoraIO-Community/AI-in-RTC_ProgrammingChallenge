import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/net/socket.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/contact/widgets/home_caller.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _defaultAvatarPng = "assets/images/default_avatar.png";

class HomeCallPage extends BaseStatelessWidget {

  final Map itemUserInfo;
  final bool isLocalCaller;

  HomeCallPage({
    this.itemUserInfo,
    this.isLocalCaller,
  }):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      title: "通话页面",
      navigationBarBackgroundColor: Colors.transparent,
      isShowNavigationBar: false,
      child:HomeCallPagestKit(
        itemUserInfo: itemUserInfo,
        isLocalCaller: isLocalCaller,
      ),
    );
  }
}

class HomeCallPagestKit extends BaseStatelessWidget
{
  final Map itemUserInfo;
  HomePageCaller _homePageCaller ;
  final bool isLocalCaller;

  HomeCallPagestKit({
    this.itemUserInfo,
    this.isLocalCaller,
  }):super();

  @override
  Widget build(BuildContext context) {

    KOBServer.registerKVO(this, kSocketRemoteClose, (data){
      UIKit.popWidget(context: context);
      KOBServer.removeKVO(kSocketRemoteClose, this);
    });

    KOBServer.registerKVO(this, kSocketRemoteRefuse, (data){
      UIKit.popWidget(context: context);
      UIKit.showMsg(
          context: context,
          msg: "对方已拒绝"
      );
      KOBServer.removeKVO(kSocketRemoteRefuse, this);
    });

    KOBServer.registerKVO(this, kSocketRemoteAccept, (data){
      _homePageCaller.initAgoraEngine();
      KOBServer.removeKVO(this, kSocketRemoteAccept);
    });

    _homePageCaller = HomePageCaller(
      remoteUserInfo: itemUserInfo,
      isLocalCaller: isLocalCaller,
    );

    // TODO: implement build
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: <Widget>[
                Container(
                  width: ClimbingDeviceUtil.screenPixel.width,
                  height:ClimbingDeviceUtil.screenPixel.height,
                  color: Color(0xFF666666),
                  child: _homePageCaller,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: HomeCallPageTip(
              isLocalCaller: isLocalCaller,
              itemUserInfo: itemUserInfo,
              onAcceptSucces: (){

                NetKit.post(
                    path: "/rest/request_accept_to",
                    isShowLoading: false,
                    isShowMsg: false,
                    needToken: true,
                    refreshToken: true,
                    context: context,
                    data:{
                      "from":itemUserInfo["rowguid"]
                    }
                ).then((rRsp){
                  print(rRsp);
                }).catchError((e){
                  print(e);
                });

                _homePageCaller.initAgoraEngine();
              },
              onCloseSuccess: (){

                NetKit.post(
                  path: "/rest/request_close_to",
                  isShowLoading: false,
                  isShowMsg: false,
                  needToken: true,
                  refreshToken: true,
                  data:{
                    "to":itemUserInfo["rowguid"]
                  }
                ).then((rRsp){});

              },

              onRefuseSuccess: (){
                NetKit.post(
                    path: "/rest/request_refuse_to",
                    isShowLoading: false,
                    isShowMsg: false,
                    needToken: true,
                    refreshToken: true,
                    data:{
                      "from":itemUserInfo["rowguid"]
                    }
                ).then((rRsp){

                });
              },

            ),
          )
        ],
      ),
    );
  }
}

// 整体通话提示界面
class HomeCallPageTip extends BaseStatefulWidget
{
  final Map itemUserInfo;
  final VoidCallback onAcceptSucces;
  final VoidCallback onCloseSuccess;
  final VoidCallback onRefuseSuccess;
  final bool isLocalCaller;

  HomeCallPageTip({
    this.itemUserInfo,
    this.onAcceptSucces,
    this.onCloseSuccess,
    this.onRefuseSuccess,
    this.isLocalCaller = true
  }):super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeCallPageTipState(
      itemUserInfo: itemUserInfo,
      isLocalCaller: isLocalCaller,
      onAcceptSucces: onAcceptSucces,
      onCloseSuccess:onCloseSuccess,
      onRefuseSuccess:onRefuseSuccess
    );
  }
}

class HomeCallPageTipState extends State<HomeCallPageTip> with TickerProviderStateMixin
{

  final Map itemUserInfo;
  final VoidCallback onAcceptSucces;
  final VoidCallback onCloseSuccess;
  final VoidCallback onRefuseSuccess;
  final bool isLocalCaller;

  HomeCallPageTipState({
    this.itemUserInfo,
    this.onAcceptSucces,
    this.isLocalCaller = true,
    this.onCloseSuccess,
    this.onRefuseSuccess,
  }):super();

  AnimationController _controller;
  Animation<double> _tween;

  HomeCallPageToolBar _homeCallPageToolBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    KOBServer.registerKVO(this, kSocketRemoteAccept, (data){
      _controller.forward();
      KOBServer.removeKVO(kSocketRemoteAccept, this);
    });



    _controller = AnimationController(
          duration: Duration(milliseconds: 200),
          vsync: this
    )..addListener(()=>setState((){}))
    ..addStatusListener((status){
      if (status == AnimationStatus.completed)
      {
        HomePageToolBarState state = _homeCallPageToolBar.baseState;
        state.stopAnimate();
        setState(() {
          visible = !visible;
          print(visible);
        });
      }
    });

    _tween = Tween( begin: 1.0, end: 0.0 )
              .animate(CurvedAnimation(
                curve: Curves.linear,
                parent: _controller
              ));

    _homeCallPageToolBar = initialToolbar();
  }

  HomeCallPageToolBar initialToolbar(){
    return HomeCallPageToolBar(
      onAcceptPress: (){
        _controller.forward();
        if (onAcceptSucces != null)
        {
          onAcceptSucces();
        }
      },
      isLocalCaller: isLocalCaller,
      onRefusePress: onRefuseSuccess,
      onClosePress: onCloseSuccess,
    );
  }

  bool visible = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Offstage(
      offstage: !visible,
      child: Opacity(
        opacity: _tween.value,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 64,left: 20,right: 20),
              width: ClimbingDeviceUtil.screenPixel.width,
              height:ClimbingDeviceUtil.screenPixel.height,
              color: Color(ClimbingTheme.mineTopBackgroundColor),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    top: ClimbingDeviceUtil.statusBarHeight + 44 + 20,
                    child: Column(
                      children: <Widget>[

                        // 用户信息
                        Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: Image.asset(_defaultAvatarPng),
                        ),

                        Container(
                          child: ClimbingCellText(
                            data: (itemUserInfo == null)?"":itemUserInfo["nickname"],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )

                      ],
                    ),
                  ),
                  Positioned(
                    width: 200,
                    bottom: 0,
                    child: _homeCallPageToolBar,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



// 通话按钮界面
class HomeCallPageToolBar extends BaseStatefulWidget
{

  final VoidCallback onAcceptPress;
  final VoidCallback onClosePress;
  final VoidCallback onRefusePress;
  final bool isLocalCaller;

  HomeCallPageToolBar({
    this.onAcceptPress,
    this.onClosePress,
    this.onRefusePress,
    this.isLocalCaller,
  }):super();



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    this.baseState = HomePageToolBarState(
        onAcceptPress: onAcceptPress,
        onClosePress: onClosePress,
        onRefusePress: onRefusePress,
        isLocalCaller: isLocalCaller
    );

    return this.baseState;
  }

}

class HomePageToolBarState extends State<HomeCallPageToolBar> with TickerProviderStateMixin
{

  Animation<EdgeInsets> _movement;
  Animation<EdgeInsets> _movementw;
  AnimationController _controller;
  final bool isLocalCaller;

  final VoidCallback onAcceptPress;
  final VoidCallback onClosePress;
  final VoidCallback onRefusePress;
  HomePageToolBarState({
      this.onAcceptPress ,
      this.onClosePress ,
      this.onRefusePress ,
      this.isLocalCaller = true,
  }):super();

  void stopAnimate(){
    _controller.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addListener((){
      setState(() {

      });
    })..addStatusListener((status){
      if (status == AnimationStatus.completed)
      {
        _controller.reverse();
      }
      else if (status == AnimationStatus.dismissed)
      {
        _controller.forward();
      }
    });

    _movement = EdgeInsetsTween(begin: EdgeInsets.only(top: 40), end: EdgeInsets.only(top: 10))
        .animate(CurvedAnimation(
      parent:_controller,
      curve: Curves.easeIn
    ));

    _movementw = EdgeInsetsTween(begin: EdgeInsets.only(top: 10), end: EdgeInsets.only(top: 40))
        .animate(CurvedAnimation(
        parent:_controller,
        curve: Curves.easeIn
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> children = new List();
    MainAxisAlignment crossAlig = MainAxisAlignment.center;

    children.add(Container(
      height: 60,
      width: 60,
      margin: _movement.value,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CupertinoButton(
        child: Icon(
          Icons.close,
          size: 30,
          color: Colors.white,
        ),
        pressedOpacity: 0.9,
        onPressed: (){
          if (isLocalCaller == false)
          {
             if (onRefusePress != null)
             {
               onRefusePress();
             }
          }
          else
          {
            if (onClosePress != null)
            {
              onClosePress();
            }
          }
          UIKit.popWidget(
              context: context
          );
        },
      ),
    ));
    if (isLocalCaller == false)
    {
      crossAlig = MainAxisAlignment.spaceBetween;
      children.add( Container(
        height: 60,
        width: 60,
        margin: _movementw.value,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30),
        ),
        child: CupertinoButton(
          pressedOpacity: 0.9,
          child: Icon(
            Icons.phone,
            size: 30,
            color: Colors.white,
          ),
          onPressed: onAcceptPress,
        ),
      ));
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,//子组件的在交叉轴的对齐方式为起点
      mainAxisAlignment:crossAlig ,//子组件的排列方式为主轴两端对齐
      children: children,
    );
  }
}
