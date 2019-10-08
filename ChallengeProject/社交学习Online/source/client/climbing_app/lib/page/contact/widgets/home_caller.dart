import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as prefix0;
import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class HomePageCaller extends BaseStatefulWidget {
  final bool isLocalCaller;
  final Map remoteUserInfo;

  HomePageCaller({
    this.isLocalCaller = true,
    this.remoteUserInfo,
  }) : super();

  HomePageCallerState _state;

  void initAgoraEngine() {
    _state.initAgoraEngine();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _state = HomePageCallerState(
      isLocalCaller: isLocalCaller,
      remoteUserInfo: remoteUserInfo
    );
    return _state;
  }
}

class HomePageCallerState extends State<HomePageCaller> {

  final bool isLocalCaller;
  Map _localUser = Map();
  final Map remoteUserInfo;

  HomePageCallerState({
    this.isLocalCaller = true,
    this.remoteUserInfo
  }) : super();

  VideoSession _localVideoSession;
  VideoSession _remoteVideoSession;
  void initAgoraEngine() {
    _initAgoraRtcEngine();
    _addAgoraEventHandlers();

    KeyValueModel().where({ "key":kPlatformUserInfo }).queryOne().then((rRsp){
      String value = rRsp["value"];
      Map localUser = convert.jsonDecode(value);
      _localUser = localUser;

      int uid = localUser["id"];
      String rowguid = localUser["rowguid"];

      // 设置本地视频
      _localVideoSession = _addRenderView(uid, rowguid, (viewId) {
        AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Hidden);
      });

      setState(() {
        // 加入频道
        joinChannel();
      });

    });

  }

  void joinChannel(){
    AgoraRtcEngine.startPreview();
    String rowguid = "";
    if (isLocalCaller == false)
    {
      rowguid = remoteUserInfo["rowguid"];
    }
    else
    {
      rowguid = _localUser["rowguid"];
    }

    AgoraRtcEngine.joinChannel(null, rowguid, null, _localUser["id"]);
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create(kAgoraAppId);
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.Communication);
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (int code){
      print("error");
      print(code);
    };

    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      print("local joined");
      print(channel);
      print(uid);
        };

    AgoraRtcEngine.onLeaveChannel = () {};

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {

      // 设置远程视频
      setState(() {
//        int remoteUid = remoteUserInfo["id"];
        String remoteRowguid = remoteUserInfo["rowguid"];
        _remoteVideoSession = _addRenderView(uid, remoteRowguid, (viewId){
          AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Hidden, uid);
        });
      });

    };

    AgoraRtcEngine.onUserOffline = (int uid, int elapsed) {};

    AgoraRtcEngine.onFirstRemoteVideoFrame =
        (int uid, int width, int height, int elapsed) {};
  }

  VideoSession _addRenderView(int uid, String key, Function(int viewId) finished) {
    Widget view = AgoraRtcEngine.createNativeView((int viewId){
      if (finished != null) {
        finished(viewId);
      }
    },key: Key(key) );

    return VideoSession(uid, view);
  }

  void destroyCall(){
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.stopPreview();
    AgoraRtcEngine.destroy();
    AgoraRtcEngine.onError = null;
    AgoraRtcEngine.onJoinChannelSuccess = null;
    AgoraRtcEngine.onUserOffline = null;
    AgoraRtcEngine.onLeaveChannel = null;
    AgoraRtcEngine.onUserJoined = null;
    AgoraRtcEngine.onFirstRemoteVideoFrame = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    destroyCall();
  }

  void _removeRenderView(int uid) {
    AgoraRtcEngine.removeNativeView(uid);
  }

  bool isMuted = false;
  bool isCloseVideo = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          width: ClimbingDeviceUtil.screenPixel.width,
          height: ClimbingDeviceUtil.screenPixel.height,
          child: Container(
            color: Colors.transparent,
            child: _remoteVideoSession != null?_remoteVideoSession.view:Container(),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: ClimbingDeviceUtil.screenPixel.width,
          height: 200,
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: (() {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      HomeCallerButton(
                        size: 60,
                        icon: Icons.video_call,
                        iconColor: isCloseVideo == true ?Colors.red:null,
                        onPress: (){
                          setState(() {
                            isCloseVideo = !isCloseVideo;
                            AgoraRtcEngine.muteLocalVideoStream(isCloseVideo);
                          });
                        },
                      ),
                      HomeCallerButton(
                        size: 60,
                        icon: Icons.close,
                        backgroundColor: Colors.red,
                        onPress: (){
                          destroyCall();
                          UIKit.popWidget(
                            context: context
                          );
                        },
                      ),
                      HomeCallerButton(
                        size: 60,
                        icon: Icons.volume_off,
                        iconColor: isMuted == true ?Colors.red:null,
                        onPress: (){
                          setState(() {
                            isMuted = !isMuted;
                            AgoraRtcEngine.muteLocalAudioStream(isMuted);
                          });
                        },
                      ),
                    ],
                  );
                })(),
              ),
            ],
          )),
        ),
        Positioned(
          right: 10,
          top: ClimbingDeviceUtil.statusBarHeight + 5,
          width: 120,
          height: 160,
          child: Container(
            color: Colors.black,
            child: _localVideoSession != null?_localVideoSession.view:Container(),
          ),
        ),
      ],
    );
  }
}



class VideoSession {
  int uid;
  Widget view;
  int viewId;

  VideoSession(int uid, Widget view) {
    this.uid = uid;
    this.view = view;
  }
}

class HomeCallerButton extends BaseStatelessWidget {
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPress;

  HomeCallerButton({
    this.icon,
    this.size,
    this.backgroundColor,
    this.onPress,
    this.iconColor
  }) : super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: size,
        width: size,
        margin: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              (backgroundColor != null) ? backgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: CupertinoButton(
          child: Icon(
            icon,
            size: 30,
            color: this.iconColor == null ? Colors.white : this.iconColor,
          ),
          pressedOpacity: 0.9,
          onPressed: this.onPress,
        ));
  }
}
