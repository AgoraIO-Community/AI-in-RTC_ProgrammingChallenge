import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/page/lessons/widgets/HomePageLesson.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';

//

class HomeSearch extends BaseStatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeSearchState();
  }
}

class HomeSearchState extends State<HomeSearch> {

  List data = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      NetKit.post(
          path: "/rest/lessonlives",
          isShowMsg: false,
          isShowLoading: true,
          needToken: false,
          refreshToken: false,
          context: context
      ).then((rRsp){

        Map status = rRsp["status"];
        if (status["code"] == 1)
        {

          Map custom = rRsp["custom"];
          setState(() {
            data = custom["data"];
          });
        }

      });
    });
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new BasePageWidget(
      title: "在线课堂",
//      isShowNavigationBar: false,
      child: GridView.builder(
        padding: EdgeInsets.only(
            top: ClimbingDeviceUtil.statusBarHeight + 44 + 10,
            left: 10,
            right: 10,
            bottom: 60),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          maxCrossAxisExtent: (ClimbingDeviceUtil.screenPixel.width - 30) / 2,
        ),
        itemCount: 23,
        itemBuilder: (BuildContext context, int index) {
          Map item = null;
          if (index < data.length) {
            item = data[index];
          }

          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        child: Image.asset("assets/images/lessons/${index}.jpg",
                          fit: BoxFit.cover,
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.8,
                        child: GestureDetector(
                          onTap: () {
                            if (item != null)
                            {
                              Map item = data[index];

                              NetKit.post(
                                path: "/rest/request_joinopenlive",
                                isShowMsg: false,
                                isShowLoading: true,
                                needToken: true,
                                refreshToken: true,
                                context: context,
                                data: {
                                  "liverguid":item["rowguid"]
                                }
                              ).then((rRsp){
                                Map status = rRsp["status"];
                                if (status["code"] == 1)
                                {
                                  UIKit.pushWidget(
                                      target: HomePageLesson(
                                        liverguid: item["rowguid"],
                                        uid:item["id"],
                                      ),
                                      context: context
                                  );
                                } else {
                                  UIKit.showMsg(
                                    context: context,
                                    msg: "请先登陆"
                                  );
                                }
                              });
                            } else {
                              UIKit.showMsg(
                                msg: "主播不在家",
                                context: context
                              );
                            }
                          },
                          child: Container(
                            color: Color(0xFF666666),
                            height: 40,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(CupertinoIcons.person,
                                        color: Colors.white,),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: ClimbingCellText(
                                        data: "${index * 25 - 5 + 187}",
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[

                                    Container(
                                      width: 70,
                                      alignment: Alignment.center,
                                      child: ClimbingCellText(
                                        data: (item != null)?item["nickname"]:"进入课堂",
                                        color: Colors.white,
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      child: Icon(CupertinoIcons.forward,
                                        color: Colors.white,),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
