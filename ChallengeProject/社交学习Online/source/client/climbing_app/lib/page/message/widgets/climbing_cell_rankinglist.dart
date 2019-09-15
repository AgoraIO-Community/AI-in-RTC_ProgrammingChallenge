import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/page/home_personal_detail.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';

class ClimbingCellRankingList extends BaseStatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClimbingRankingListState();
  }

}


class ClimbingRankingListState extends State<ClimbingCellRankingList>
{

  List _rankList = new List();


  void loadRankListData(){
    // /rest/ranklist
    Future.microtask((){
      NetKit.post(
          path: "/rest/ranklist",
          needToken: false,
          refreshToken: false,
          isShowLoading: false,
          isShowMsg: false
      ).then((rRsp){
        Map status = rRsp["status"];
        if (status["code"] == 1)
        {
          Map custom = rRsp["custom"];
          dynamic list = custom["data"];
          if (list != null)
          {
            setState(() {
              _rankList = list;
            });
          }
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadRankListData();
  }

  @override
  Widget build(BuildContext context) {

    BorderSide borderSize = BorderSide(
      color: Color(0xFFF0E255),
      width: 2
    );


    // TODO: implement build
    return Container(
      color:Color(0xFFFFFFFF),
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15,bottom: 10),
            alignment: Alignment.topLeft,
            child: ClimbingCellText(
              data:"排行榜（点击头像可以和对方通话）",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height:90,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){

                  Map _user = _rankList[index];

                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    pressedOpacity: 0.7,
                    onPressed: (){
                      UIKit.pushWidget(
                          target: HomePersonalDetail(
                            rowguid: _user["rowguid"],
                          ),
                          context: context
                      );
                    },
                    child: Container(
                      width:80,
                      child: Column(
                        children: <Widget>[

                          // 头像信息
                          Container(
                            child: Image.asset("assets/images/default_avatar.png", width:60, fit: BoxFit.fill,),
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(30),
//                            border: Border(
//                              top:borderSize,
//                              left:borderSize,
//                              right:borderSize,
//                              bottom:borderSize,
//                            )
//                          ),
                          ),

                          // 名字
                          Container(
                            child: ClimbingCellText(
                              data:_user["nickname"],
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index){
                  return Container(
                    width: 0,
                    height:0,
                  );
                },
                itemCount: _rankList.length
            ),
          )
        ],
      ),
    );
  }

}