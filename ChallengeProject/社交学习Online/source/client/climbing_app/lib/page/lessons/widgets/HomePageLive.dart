import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/net/socket.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as Convert;

class HomePageLive extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageLiveState();
  }
}

class HomePageLiveState extends State<HomePageLive> {

  ScrollController _controller = new ScrollController();
  List<String> _data = new List();

  void scrollToBottom() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  void addText(String message) {
    setState(() {
      _data.add(message);
      Future.delayed(Duration(milliseconds: 400), () {
        this.scrollToBottom();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      navigationBarBackgroundColor: Colors.transparent,
      navigationBarBackColor: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: _localVideo,
          ),
          Positioned(
            left: 5,
            bottom: 10,
            height: 200,
            width: 200,
            child: Container(
              child: ListView.separated(
                  controller: _controller,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: ClimbingCellText(
                        data: _data[index],
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemCount: _data.length),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAgoraEngine();
    joinChannel();

    KOBServer.registerKVO(this, kSocketLessonMessage, (data){
      String message = data["message"];
      setState(() {
        addText(message);
      });
    });
  }


  void initAgoraEngine() {
    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create(kAgoraAppId);
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    AgoraRtcEngine.setClientRole(ClientRole.Broadcaster);
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (int code){
      print("----- error ----");
      print(code);
    };

    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {

    };

    AgoraRtcEngine.onLeaveChannel = () {};

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {

    };

    AgoraRtcEngine.onUserOffline = (int uid, int elapsed) {};

    AgoraRtcEngine.onFirstRemoteVideoFrame =
        (int uid, int width, int height, int elapsed) {};
  }

  Widget _localVideo;

  void joinChannel(){

    KeyValueModel().where({"key":kPlatformUserInfo }).queryOne().then((rRsp){
      String value = rRsp["value"];
      Map userInfo = Convert.jsonDecode(value);
      String rowguid = userInfo["rowguid"];

      int uid = userInfo["id"];

      _localVideo = AgoraRtcEngine.createNativeView((int viewId){
        AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Hidden);
      },key: Key(rowguid) );


      setState(() {
        AgoraRtcEngine.startPreview();
        AgoraRtcEngine.joinChannel(null, rowguid, null, uid);
      });


    });

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

    _controller.dispose();
    destroyCall();

    // 离开主播室
    NetKit.post(
      path: "/rest/leave_openlive",
      isShowLoading: false,
      isShowMsg: false,
      needToken: true,
      refreshToken: true
    ).then((rRsp){});

    KOBServer.removeKVO(kSocketLessonMessage, this);
  }
}
