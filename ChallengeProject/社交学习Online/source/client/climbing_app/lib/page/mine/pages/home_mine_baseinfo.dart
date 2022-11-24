import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/auth_net.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/loading.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/mine/pages/home_mine_infoedit.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_box.dart';
import 'package:climbing_app/page/mine/widgets/climbing_label_text.dart';
import 'package:flutter/cupertino.dart';

class HomeMineBaseInfo extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeMineBaseState();
  }
}

class HomeMineBaseState extends State<HomeMineBaseInfo> {


  Map _userInfo = new Map();
  static String _defaultAvatarPng = "assets/images/default_avatar.png";

  void pushEditInfoWidGet({
    String title,String placeholder,String classKeyName
  }){

    UIKit.pushWidget( context: context, target: HomeMineInfoEdit(
        title: title,
        placeholder: placeholder,
        classKeyName:classKeyName,
        userInfo: _userInfo,
        editSuccessCallback: (Map rRsp){

          // 通知主界面刷新
          KOBServer.postKVO(kGetUserInfoNotification, rRsp);

          setState(() {
            _userInfo = rRsp;
          });
        },
    ));
  }

  List<Map> _lists = new List();
  void refreshLists(){
    List<Map> datalist = new List();

    // 第1模块
    datalist.add(factoryCellItem(
      title: "头像",
      rightArrowItem: (() {
        return Container(
          width: 80,
          height: 80,
//            color:Color(0xFFFF0000),
          padding: EdgeInsets.zero,
          child: Image.asset(_defaultAvatarPng),
        );
      })(),
    ));

    datalist.add(factoryCellItem(
      title: "登陆账号",
      arrowTitle: _userInfo["loginid"],
      hideRightArrow: true,
    ));

    datalist.add(factoryCellItem(
      title: "角色",
      arrowTitle: "学生",
      hideRightArrow: true,
    ));

    datalist.add(factoryCellItem(
      title: "称号",
      rightArrowItem: ((){

        List<Widget> strongLists = new List();
        List ls =  _userInfo["labels"];
        if (ls == null) {
          ls = new List();
        }
        for (Map item in ls)
        {
          strongLists.add(ClimbingLabelText(
            text:item["name"],
            themeColor: UIKit.labelLevelPaerser(item["level"]),
            margin: EdgeInsets.only(right: 5),
          ));
        }


        return Row(
          children: strongLists,
        );
      })(),
      hideRightArrow: true,
      isSperator:true,
    ));

    datalist.add(factoryCellItem(
      title: "昵称",
      arrowTitle: _userInfo["nickname"],
      onPress: ()=>pushEditInfoWidGet(
        title: "修改昵称",
        placeholder: "请输入新的昵称",
        classKeyName:"nickname",
      )
    ));

    datalist.add(factoryCellItem(
      title: "邮件",
      arrowTitle: _userInfo["mail"],
      onPress: ()=>pushEditInfoWidGet(
          title: "修改邮箱",
          placeholder: "请输入新的邮箱",
          classKeyName:"mail",
      )
    ));
    datalist.add(factoryCellItem(
      title: "手机号",
      arrowTitle: _userInfo["mobile"],
      onPress: ()=>pushEditInfoWidGet(
          title: "修改手机号",
          placeholder: "请输入新的手机号",
          classKeyName:"mobile",
      )
    ));
    _lists = datalist;
  }

  static Map factoryCellItem({
    String title,
    IconData icon,
    String arrowTitle,
    bool isSperator,
    VoidCallback onPress,
    bool hideRightArrow,
    Widget rightArrowItem,
  }) {
    Map item = new Map();
    item["title"] = title;
    item["icon"] = icon;
    item["arrowTitle"] = arrowTitle;
    item["isSperator"] = isSperator;
    item["onPress"] = onPress;
    item["hideRightArrow"] = hideRightArrow;
    item["rightArrowItem"] = rightArrowItem;
    return item;
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask((){
      UIKit.showLoading(
          context: context
      );
      AuthNetKit.FutureSyncGetUserInfo().then((rRsp){
        UIKit.hideLoading();

        Map status = rRsp["status"];
        if (status["code"] == 1)
        {
          Map custom = rRsp["custom"];
          _userInfo = custom;
          setState(() {});
        } else {

          UIKit.showMsg(
            context: context,
            msg:status["msg"]
          );
        }

      }).catchError((e){
        print(e);
        UIKit.hideLoading();
        UIKit.showMsg(
          context: context,
          msg:e.toString()
        );
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 刷新
    refreshLists();
    return BasePageWidget(
      title: "我的信息",

      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            Map item = _lists[index];
            return ClimbingCellBox(
              title: item["title"],
              arrowTitle: item["arrowTitle"],
              isHideRightArrow: item["hideRightArrow"],
              rightArrowItem: item["rightArrowItem"],
              onPress: (item["onPress"] == null) ? () => null : item["onPress"],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            Map item = _lists[index];
            bool isSeprator = item["isSperator"];
            if ((isSeprator != null) && (isSeprator == true)) {
              return Container(
                height: 20,
              );
            }
            return Container();
          },
          itemCount: _lists.length),
    );
  }
}
