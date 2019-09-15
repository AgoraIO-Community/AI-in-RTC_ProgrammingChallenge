import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/contact/widgets/home_call_page.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:climbing_app/page/mine/widgets/climbing_label_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePersonalDetail extends BaseStatefulWidget {

  final String rowguid;
  HomePersonalDetail({
    this.rowguid
  }):super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePersonalDetailState(
      rowguid: rowguid
    );
  }
}

class HomePersonalDetailState extends State<HomePersonalDetail>
{
  final String defaultAvatarPng = "assets/images/default_avatar.png";
  final String rowguid;
  Map _userInfo = new Map();

  HomePersonalDetailState({
    this.rowguid
  }):super();

  @override
  void initState() {
    // TODO: implement initState


    Future.microtask((){

      NetKit.post(
        path:"/rest/userinfo_detail",
        data: {
          "rowguid":rowguid
        },
        context: context,
        isShowMsg: true,
        isShowLoading: true,
        needToken: false,
        refreshToken: false
      ).then((rRsp){

        Map status = rRsp["status"];
        if (status["code"] == 1)
        {
          Map custom = rRsp["custom"];
          _userInfo = custom;
          setState(() {

          });

        }

      }).catchError((err){
        UIKit.showMsg(
          context: context,
          msg: err.toString()
        );
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    List<Map> attribute = new List();

    List labels = _userInfo["labels"];
    List<Widget> childLabels = new List();
    if (labels != null)
    {
      for (Map l in labels)
      {
        childLabels.add(ClimbingLabelText(
          text: l["name"],
          themeColor: UIKit.labelLevelPaerser(l["level"]),
        ));
      }
    }

    attribute.add({
      "name": "称号",
      "value": Row(
        children: childLabels,
      )
    });
    attribute.add({"name": "昵称", "value": _userInfo["nickname"]});
    attribute.add({"name": "邮件", "value": _userInfo["mail"]});
    attribute.add({"name": "手机号", "value": _userInfo["mobile"]});

    // TODO: implement build
    return BasePageWidget(
      title: "用户详情信息",
      titleColor: Colors.white,
      navigationBarBackColor: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 64, bottom: 20),
            constraints: BoxConstraints(
              minHeight: (ClimbingDeviceUtil.statusBarHeight + 44) + 200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: Image.asset(defaultAvatarPng),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: ClimbingCellText(
                          data: "粉丝 ${_userInfo["totalFans"]}",
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ClimbingCellText(
                          data: "关注 ${_userInfo["totalRelates"]}",
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () {

                          NetKit.post(
                            path: "/rest/request_call_to",
                            needToken: true,
                            refreshToken: true,
                            isShowMsg: true,
                            isShowLoading: true,
                            context: context,
                            data:{
                              "to":_userInfo["rowguid"]
                            }
                          ).then((rRsp){
                            Map status = rRsp["status"];
                            if (status["code"] == 1)
                            {
                              UIKit.presentWidget(
                                  target: HomeCallPage(
                                  itemUserInfo: _userInfo,
                                ),
                                context: context,
                                showCloseButton: false
                              );
                            }
                          });

                        },
                        pressedOpacity: 0.8,
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0x9900FF00),
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Icon(
                            CupertinoIcons.phone_solid,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(ClimbingTheme.themeBackgroundColor),
              child: ListView.separated(
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (context, index) {
                    Map attr = attribute[index];
                    Object value = attr["value"];
                    Widget childValue;
                    if (value is Widget) {
                      childValue = value;
                    } else {
                      childValue = ClimbingCellText(
                        data: value as String,
                        fontSize: 15,
                      );
                    }

                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: double.infinity,
                      height: 50,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: ClimbingCellText(
                              data: '${attr["name"]}:',
                              fontSize: 15,
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: childValue,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                    );
                  },
                  itemCount: attribute.length),
            ),
          )
        ],
      ),
      bgColor: Color(ClimbingTheme.mineTopBackgroundColor),
      navigationBarBackgroundColor: Color(0x00000000),
    );
  }

}
