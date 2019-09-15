import 'dart:async';

import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/page/contact/widgets/home_call_page.dart';
import 'package:flutter/cupertino.dart';
import 'service_url.dart';
import 'dart:convert' as convert;
import 'dart:io';

class NetSocket
{

  static WebSocket _socket;
  static BuildContext _context;
  static Map _eventHandlers = Map();

  static initital(BuildContext context){

    KeyValueModel().where({"key":kPlatformUserInfo}).queryOne().then((rRsp){
      String val = rRsp["value"];
      Map userInfo = convert.jsonDecode(val);
      String uGuid = userInfo["rowguid"];

      _initialSocket(uGuid);
      _reconnect(uGuid);
      registerHandlers();
//      Future.delayed(Duration(seconds: 1), (){
//        UIKit.presentWidget(
//            target: HomeCallPage(
//              itemUserInfo: {},
//            ),
//            context: _context
//        );
//      });
    });






    _context = context;
  }

  static void _initialSocket(String uGuid) async {
    try{
      if (_socket != null)
      {
        return;
      }
      // ignore: non_constant_identifier_names
      String Url = '$socketUrl?userguid=$uGuid';
      // ignore: close_sinks
      _socket = await WebSocket.connect(Url);
      _socket.pingInterval = Duration(milliseconds: 1000);
      _socket.listen((message){
        if (message == "ping" || message == "pong")
        {
          // print(message);
        }
        else
        {
          print("receivemessage");
          print(message);
          Map data = convert.jsonDecode(message);
          print(data);
          String event = data["event"];
          Function(dynamic) fn = _eventHandlers[event];
          if (fn != null) fn(data["data"]);
        }
      });

      _socket.handleError((error){
        print("error....");
//      print(error);
      });

    }
    catch (e)
    {

    }
  }

  static void _reconnect(String uGuid){
    Future.delayed(Duration(milliseconds: 1000), (){

//      print("reconnection ....");

      if (_socket == null)
      {
        _initialSocket(uGuid);
      } else {
        if (_socket.readyState == WebSocket.closed)
        {
          _socket = null;
          _initialSocket(uGuid);
        }
        else if (_socket.readyState == WebSocket.open)
        {
//        print("reconnect success");
        }
      }
      Future.microtask((){
        _reconnect(uGuid);
      });
    });
  }

  static VoidCallback dismissCallerBack;

  static void registerHandlers(){


    _eventHandlers["call"] = (data) {
      print(data);

      UIKit.presentWidget(
        target: HomeCallPage(
          itemUserInfo: data,
          isLocalCaller: false,
        ),
        context: _context,
        showCloseButton: false
      );
    };


    _eventHandlers["remote-close"] = (data) {

      KOBServer.postKVO(kSocketRemoteClose, data);
    };

    _eventHandlers["remote-refuse"] = (data) {

      KOBServer.postKVO(kSocketRemoteRefuse, data);
    };

    _eventHandlers["remote-accept"] = (data) {
      KOBServer.postKVO(kSocketRemoteAccept, data);
    };

    _eventHandlers["lesson-message"] = (data) {
      print("lesson-message");
      print(data);
      KOBServer.postKVO(kSocketLessonMessage, data);
    };


  }

}

const String kSocketRemoteClose = "socket.remote.close";
const String kSocketRemoteRefuse = "socket.remote.refuse";
const String kSocketRemoteAccept = "socket.remote.accept";
const String kSocketLessonMessage = "socket.lessonmessage";