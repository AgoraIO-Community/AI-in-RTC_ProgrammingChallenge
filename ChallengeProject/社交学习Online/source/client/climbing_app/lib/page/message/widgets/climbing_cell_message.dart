import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:climbing_app/page/mine/widgets/climbing_label_text.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ClimbingMessageCell extends BaseStatefulWidget
{

  Map itemInfo;
  Function(Map row) onAvatarPressed;
  Function(Map row) onItemClick;

  ClimbingMessageCell({
    this.itemInfo,
    this.onAvatarPressed,
    this.onItemClick,
  }):super();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClimbingMessageCellState(
        itemInfo: itemInfo,
        onAvatarPressed: onAvatarPressed,
      onItemClick: onItemClick
    );
  }
}

class ClimbingMessageHeader extends BaseStatelessWidget
{

  Map itemInfo;
  Function(Map row) onPressed;
  VoidCallback onShowAllText;

  ClimbingMessageHeader({
    this.itemInfo,
    this.onPressed,
    this.onShowAllText,
  }):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // 头像
            Container(
              child: CupertinoButton(
                padding:EdgeInsets.zero,
                onPressed: ()=>this.onPressed(itemInfo),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset("assets/images/default_avatar.png", width: 50,height:50),
                ),
              ),
            ),

            // info
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ClimbingCellText(
                      data: itemInfo["climbing_account.nickname"],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: Row(
                      children: ((){

                        List<Widget> cs = new List();
                        cs.add(ClimbingCellText(
                          data: UIKit.readTimestamp(itemInfo["createdAt"]),
                          fontSize: 10,
                        ));

                        List labels = itemInfo["climbing_account.labels"];
                        if (labels != null)
                        {
                          for (Map l in labels)
                          {
                            cs.add(ClimbingLabelText(
                              text:l["name"],
                              fontSize: 8,
                              themeColor: UIKit.labelLevelPaerser(l["level"]),
                              margin: EdgeInsets.only(left: 5),
                            ));
                          }
                        }

                        return cs;
                      })(),
                    ),
                    alignment: Alignment.bottomLeft,
                  ),

                ],
              ),
            ),
          ],
        ),

        // 正文
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child:  Column(
            children: ((){

              return <Widget>[
                Container(
                  child: ExtendedText(
                    itemInfo["content"] == null?"":itemInfo["content"],
                    overFlowTextSpan: OverFlowTextSpan(
                      children: [
                        TextSpan(
                          text: "... "
                        ),
                        TextSpan(
                            text: '全文',
                            style: new TextStyle(
                              color: Color(ClimbingTheme.messageCellAllTextThemeColor),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            // 添加按钮手势
                            recognizer: TapGestureRecognizer()
                              ..onTap=(){
                                  if (onShowAllText != null) onShowAllText();
                              }
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 7,
                  ),
                  width: double.infinity,
                ),
              ];

            })(),
          ),
        ),

        // 图片 or 视频
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children:((){
              // 计算图片，并且填充图片
              List<Widget> pics = new List();
              List subs = itemInfo["gmessagesubs"];
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
        )

      ],
    );
  }
}

class ClimbingMessageCellState extends State<ClimbingMessageCell>
{

  Map itemInfo;
  Function(Map row) onAvatarPressed;
  Function(Map row) onItemClick;

  ClimbingMessageCellState({
    this.itemInfo,
    this.onAvatarPressed,
    this.onItemClick,
  }):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        if (this.onItemClick != null) this.onItemClick(itemInfo);
      },
      child: Container(
        color:Color(0xFFFFFFFF),
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: <Widget>[

            // 顶部信息栏目
            Container(
              child: ClimbingMessageHeader(
                itemInfo: itemInfo,
                onPressed: onAvatarPressed,
                onShowAllText: (){
                  if (onItemClick != null) onItemClick(itemInfo);
                },
              ),
            )

            // 正文内容
          ],
        ),
      ),
    );
  }

}