import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/message_net.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/loading.dart';
import 'package:climbing_app/frame/pages/swipe_refresh_layout.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/home_personal_detail.dart';
import 'package:climbing_app/page/message/pages/home_message_detail.dart';
import 'package:climbing_app/page/message/pages/home_message_distribute.dart';
import 'package:climbing_app/page/message/widgets/climbing_cell_message.dart';
import 'package:climbing_app/page/message/widgets/climbing_cell_rankinglist.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:climbing_app/page/navigator_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * 多列消息，排行榜信息
 * */

class HomeMessage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeMessageState();
  }
}

class HomeMessageState extends State<HomeMessage> {
  List _datalist = new List();
  ScrollController _scrollController = new ScrollController();
  ClimbingLoading _footerLoading = ClimbingLoading(
    isAutoStart: false,
  );
  int _page = 1;
  int _lastEndedData = 0;
  int _firstLoaded = 0;

  void loadFirstData(){
    // 首次加载
    Future.microtask(() {
      UIKit.showLoading(context: context);
      MessageNetKit.getGmessages().then((rRsp) {
        UIKit.hideLoading();
        Map status = rRsp["status"];
        if (status["code"] == 1) {
          Map custom = rRsp["custom"];
          List list = custom["list"];
          _datalist = list;
          _firstLoaded = 1;
          setState(() {});
        } else {
          UIKit.showMsg(context: context, msg: status["msg"]);
        }
      }).catchError((e) {
        UIKit.hideLoading();
        UIKit.showMsg(context: context, msg: e.toString());
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 首次加载
    loadFirstData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          (_scrollController.position.maxScrollExtent)) {
        if (_datalist.length < 10) {
          return;
        }

        _footerLoading.start();
        _page++;
        MessageNetKit.getGmessages(page: _page).then((rRsp) {
          _footerLoading.stop();
          Map status = rRsp["status"];
          if (status["code"] == 1) {
            Map custom = rRsp["custom"];
            List list = custom["list"];
            if (list.length > 0) {
              _datalist.addAll(list);
              setState(() {});
            } else {
              _page--;
              _lastEndedData = 1;
              UIKit.showMsg(context: context, msg: "没有更多数据了");

              setState(() {});
            }
          }
        }).catchError((e) {
          _footerLoading.stop();
        });
      }
    });



    KOBServer.registerKVO(this, kMessageNeedRefreshNotification,  (item){
      // 刷新数据
      this.pullToRefresh().then((rRsp){});
    });
  }

  Future<void> pullToRefresh() async {
    _page = 1;
    _lastEndedData = 0;
    Map rRsp = await MessageNetKit.getGmessages();
    Map status = rRsp["status"];
    if (status["code"] == 1) {
      Map custom = rRsp["custom"];
      List list = custom["list"];
      _datalist = [];
      setState(() {
        Future.delayed(Duration(milliseconds: 10), () {
          _datalist = list;
          setState(() {});
        });
      });
    }
    return _datalist;
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new BasePageWidget(
      title: "场圈",
      rightItem: ClimbingNavigatorBtn(
        text: "发布",
        onPressed: () =>
            UIKit.pushWidget(context: context, target: HomeMessageDistribute()),
      ),
      child:RefreshIndicator(
        displacement: 88,
        onRefresh: () async {
          return await this.pullToRefresh();
        },
        child: ListView.separated(
          cacheExtent: 70,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return ClimbingCellRankingList();
            } else if (index == (_datalist.length + 1)) {
              if (_datalist.length < 10) {
                return Container();
              }

              if (_lastEndedData == 0) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(15),
                      child: _footerLoading,
                    ),
                    ClimbingCellText(
                      data: "上拉加载更多...",
                    )
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      child: ClimbingCellText(
                        data: "没有数据啦...",
                      ),
                    )
                  ],
                );
              }
            } else {
              Map item = _datalist[index - 1];

              return ClimbingMessageCell(
                itemInfo: item,
                onAvatarPressed: (row){
                  String rowguid = row["climbing_account.rowguid"];
                  UIKit.pushWidget(
                    target: HomePersonalDetail(
                      rowguid: rowguid,
                    ),
                    context: context
                  );
                },
                onItemClick: (row){
                  UIKit.pushWidget(
                    target: HomeMessageDetail(
                      rowguid: row["rowguid"],
                    ),
                    context: context
                  );
                },
              );
            }
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 15,
            );
          },
          itemCount:  _datalist.length + 1 + 1,
          controller: _scrollController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    // TODO: implement dispose
    super.dispose();
  }
}
