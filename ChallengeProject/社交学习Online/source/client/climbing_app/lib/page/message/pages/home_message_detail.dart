import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/home_personal_detail.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:climbing_app/page/mine/widgets/climbing_label_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMessageDetail extends BaseStatefulWidget {
  final String rowguid;

  HomeMessageDetail({
    this.rowguid,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeMessageDetailState(rowguid: rowguid);
  }
}

class HomeMessageDetailState extends State<HomeMessageDetail> {
  final String rowguid;

  HomeMessageDetailState({
    this.rowguid,
  }) : super();

  Map _data = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      NetKit.post(
        path: "/rest/message/gmessages_detail_get",
        isShowMsg: true,
        isShowLoading: true,
        needToken: false,
        refreshToken: false,
        context: context,
        data: {"rowguid": rowguid},
      ).then((rRsp) {
        Map status = rRsp["status"];
        if (status["code"] == 1) {
          setState(() {
            _data = rRsp["custom"];
          });
        }
      });
    });
  }

  final String defaultAvatarPng = "assets/images/default_avatar.png";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      title: "信息详情",
      child: Container(
        margin: EdgeInsets.only(top: ClimbingDeviceUtil.statusBarHeight + 44),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  CupertinoButton(
                    padding:EdgeInsets.all(0),
                    child: Image.asset(
                      defaultAvatarPng,
                      width: 120,
                      height: 120,
                    ),
                    pressedOpacity: 0.9,
                    onPressed: (){

                      String rowguid = _data["climbing_account.rowguid"];
                      UIKit.pushWidget(
                          target: HomePersonalDetail(
                            rowguid: rowguid,
                          ),
                          context: context
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top:30,bottom: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: ClimbingCellText(
                            data:_data["climbing_account.nickname"],
                            fontSize: 16,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: ((){
                              List<Widget> list = new List();
                              List<dynamic> labels = _data["climbing_account.labels"];
                              if (labels == null) labels = [];
                              for (Map<dynamic, dynamic> item in labels)
                              {
                                list.add(ClimbingLabelText(
                                  text: item["name"],
                                  themeColor: UIKit.labelLevelPaerser(item["level"]),
                                ));
                              }
                              return list;
                            })(),
                          ),
                        ),

                        Container(
                          child: Row(
                            children: <Widget>[

                              Container(
                                child: ClimbingCellText(
                                  data: "粉丝 ${_data["climbing_account.fans"]}",
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: ClimbingCellText(
                                  data: "关注 ${_data["climbing_account.relates"]}",
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                ),
                              )

                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Colors.white,
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: ClimbingCellText(
                data: _data["content"],
              ),
            ),
            ((){


              List subs = _data["gmessagesubs"];
              if (subs  == null) subs = [];
              if (subs.length <=  0) return Container();

              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child:   Container(
                  child: Column(
                    children:((){
                      // 计算图片，并且填充图片
                      List<Widget> pics = new List();
                      int max = subs.length;
                      if (max == 0)
                      {
                        return pics;
                      }
                      int last = ((max/3).floor() + 1)*3;
                      for (int i = 0; i<last; i++)
                      {
                        int index = (i/3).floor();
                        if (pics.length < (index+1))
                        {
                          Container container = Container(
                            child: Row(
                              children: <Widget>[],
                            ),
                          );
                          pics.add(container);
                        }

                        Container container = pics[index];
                        Row row = container.child;

                        if (i >= max)
                        {
                          row.children.add(Expanded(
                            flex:1,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: 100,
                            ),
                          ));
                        } else {
                          Map item = subs[i];
                          row.children.add(Expanded(
                            flex:1,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              color:Color(ClimbingTheme.messageCellPicBgColor),
                              width: 100,
                              height:100,
                              child: Image.network(item["value"], fit: BoxFit.cover,),
                            ),
                          ));
                        }
                      }

                      return pics;
                    })(),
                  ),
                ),
              );
            })(),
          ],
        ),
      ),
    );
  }
}
