
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/navigator_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMineInfoEdit extends BaseStatelessWidget
{

  final String title;
  final String placeholder;
  final String classKeyName;
  final Map userInfo;
  final Function(Map) editSuccessCallback;

  String _editText;

  HomeMineInfoEdit({
    this.title,
    this.placeholder,
    this.classKeyName,
    this.userInfo,
    this.editSuccessCallback
  }){
    _editText = this.userInfo[classKeyName];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      title: title,
      rightItem: ClimbingNavigatorBtn(
        text:"保存",
        onPressed: (){
          NetKit.post(
            path: "/rest/edituserinfo",
            data: {
              "key":classKeyName,
              "value":_editText,
              "rowguid":userInfo["rowguid"]
            },
            context: context,
            needToken: true,
          ).then((rRsp){
            Map status = rRsp["status"];
            if (status["code"] == 1)
            {

              if (editSuccessCallback != null)
              {
                userInfo[classKeyName] = _editText;
                editSuccessCallback(userInfo);
              }

              // 成功了
              UIKit.popWidget(context: context);
            }
          }).catchError((e){
          });
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          color:Color(0xFFFFFFFF),
            border: Border(
                top:  BorderSide(width: 1, color: Color(0xFFf1f1f1)),
                bottom: BorderSide(width: 1, color: Color(0xFFf1f1f1)),
            )
        ),
          margin: EdgeInsets.only(top: ClimbingDeviceUtil.statusBarHeight+44+10),
          child:CupertinoTextField(
            controller: TextEditingController(
              text: userInfo[classKeyName],

            ),
            onChanged: (text){
              _editText = text;
            },
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            maxLines: 1,
            cursorColor: Color(0xFFa7a7a7),
            placeholder: placeholder,
            placeholderStyle: TextStyle(color: Color(0xFFa7a7a7), fontSize: 13.5),
            style: TextStyle(color: Color(0xFFa7a7a7), fontSize: 15),
          ),
      ),
    );
  }
}