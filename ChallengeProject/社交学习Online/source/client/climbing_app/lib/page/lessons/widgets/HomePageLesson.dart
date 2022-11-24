import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/net/socket.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert' as Convert;

class HomePageLesson extends BaseStatefulWidget
{

  final String liverguid;
  final int uid;

  HomePageLesson({
    this.liverguid,
    this.uid,
  }):super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("join ----- ${uid}");
    return HomePageLessionState(
      liverguid: liverguid,
      liverid: uid
    );
  }
}

class HomePageLessionState extends State<HomePageLesson>
{

  final String liverguid;
  final int liverid;

  HomePageLessionState({
    this.liverguid,
    this.liverid,
  }):super();

  String _textString;
  ScrollController _controller = ScrollController();
  List<String> _data = new List();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    this.destroyCall();

    NetKit.post(
      path: "/rest/request_leaveopenlive",
      isShowLoading: false,
      isShowMsg: false,
      needToken: true,
      refreshToken: true,
    ).then((rRsp){});

    KOBServer.removeKVO(kSocketLessonMessage, this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.initAgoraEngine();
    this.joinChannel();

    KOBServer.registerKVO(this, kSocketLessonMessage, (data){
      String message = data["message"];
      setState(() {
        _data.add(message);
        Future.delayed(Duration(milliseconds: 400), (){
          _controller.jumpTo(_controller.position.maxScrollExtent);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      navigationBarBackgroundColor: Colors.transparent,
      navigationBarBackColor: Colors.white,
      child: Container(
        child: Column(
          children: <Widget>[

            // 课程直播界面
            Container(
              height:ClimbingDeviceUtil.statusBarHeight+44+250,
              width: ClimbingDeviceUtil.screenPixel.width,
              color: Colors.black,
              child: _remoteVideo,
            ),

            // 沟通聊天列表
            Expanded(
              flex: 1,
              child: Container(
                child: ListView.separated(
                    controller: _controller,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child:ClimbingCellText(
                                data: _data[index],
                                fontSize: 16,
                                color: Color(0xFF333333),
                              )
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return Container(height: 20,);
                    },
                    itemCount: _data.length
                ),
              ),
            ),
            // 聊天输入框
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: ScreenUtil().setHeight(1080),
                    height: ScreenUtil().setHeight(140),
                    color: Color(0xFFFFFFFF),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 130,
                            child: CupertinoTextField(
                              controller: TextEditingController(
                                text: _textString,
                              ),
                              suffix: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Icon(Icons.send, color: Color(ClimbingTheme.mineTopBackgroundColor),),
                                pressedOpacity: 0.9,
                                onPressed: (){
                                  this.editingComplete();
                                },
                              ),
                              placeholder: '输入评论',
                              decoration:null,
                              onChanged: (text){
                                _textString = text;
                              },
                              onEditingComplete: (){
                                this.editingComplete();
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void editingComplete(){
    if (_textString != null && _textString.length > 0)
    {

      NetKit.post(
          path: "/rest/lessonsendmessage",
          isShowMsg: true,
          isShowLoading: true,
          needToken: true,
          refreshToken: true,
          context: context,
          data: {
            "liverguid":liverguid,
            "message":_textString,
          }
      ).then((rRsp){
        Map status = rRsp["status"];
        if (status["code"] == 1)
        {
          setState(() {
            _data.add(_textString);
            _textString = "";
            Future.delayed(Duration(milliseconds: 400), (){
              _controller.jumpTo(_controller.position.maxScrollExtent);
            });
          });
        }
      });
    }
    // 收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
  }


  void initAgoraEngine() {
    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create(kAgoraAppId);
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    AgoraRtcEngine.setClientRole(ClientRole.Audience);

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
      print("AgoraRtcEngine -------");
      print(uid);
      print(this.liverid);
      if (this.liverid == uid)
      {
        _remoteVideo = AgoraRtcEngine.createNativeView((int viewId){
          AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Hidden, uid);
        },key: Key(liverguid) );

        setState(() {

        });
      }
    };

    AgoraRtcEngine.onUserOffline = (int uid, int elapsed) {};

    AgoraRtcEngine.onFirstRemoteVideoFrame =
        (int uid, int width, int height, int elapsed) {

        };
  }

  Widget _remoteVideo;

  void joinChannel(){

    KeyValueModel().where({"key":kPlatformUserInfo }).queryOne().then((rRsp){
      String value = rRsp["value"];
      Map userInfo = Convert.jsonDecode(value);
      int uid = userInfo["id"];

      setState(() {
        AgoraRtcEngine.joinChannel(null, liverguid, null, uid);
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
}