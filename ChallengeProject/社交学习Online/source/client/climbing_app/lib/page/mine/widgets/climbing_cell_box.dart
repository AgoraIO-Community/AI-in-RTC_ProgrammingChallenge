import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';

class ClimbingCellBox extends BaseStatelessWidget
{

  final String title;
  final Color textColor;
  final Icon icon;
  final String arrowTitle;
  final Color rightArrowColor;
  final VoidCallback onPress;
  bool isHideRightArrow;
  final Widget rightArrowItem;
  final Color backgroundColor;

  ClimbingCellBox({
    this.title,
    this.arrowTitle,
    this.icon,
    this.rightArrowColor,
    this.textColor,
    this.onPress,
    this.isHideRightArrow,
    this.rightArrowItem,
    this.backgroundColor
  }):super();


  @override
  Widget build(BuildContext context) {

    if (this.isHideRightArrow == null)
    {
      isHideRightArrow = false;
    }


    // TODO: implement build
    return CupertinoButton(
      color: (backgroundColor != null) ?backgroundColor:Color(0xFFFFFFFF),
      disabledColor:(backgroundColor != null) ?backgroundColor:Color(0xFFFFFFFF),
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
      minSize:0,
      pressedOpacity: 0.6,
      onPressed: this.onPress,
//      decoration: BoxDecoration(
//          border: Border(
//            bottom: BorderSide(
//              color: Color(0XFF302F4F),
//              width: 1
//            )
//          )
//      ),
      padding:EdgeInsets.fromLTRB(10, 8, 5, 8),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,//子组件的在交叉轴的对齐方式为起点
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,//子组件的排列方式为主轴两端对齐
        children: <Widget>[
          new Expanded(
            child: new Flex(
              direction:Axis.horizontal,
              children: ((){
                List<Widget> list = new List();

                if (this.icon != null)
                {
                  list.add(new Container(
                    alignment:Alignment.center,
                    child: this.icon,
                  ));
                }

                list.add(new Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.fromLTRB(6, 3, 0, 0),
                  child: ClimbingCellText(
                    data:this.title,
                    color: this.textColor,
                  ),
                ));

                return list;
              })(),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: ((){
                List<Widget> list = new List();

                if (this.rightArrowItem != null)
                {
                  list.add(new Container(
                    alignment:Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: this.rightArrowItem,
                  ));
                }
                else if (this.arrowTitle != null)
                {
                  list.add(new Container(
                    alignment:Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ClimbingCellText(
                      data:this.arrowTitle,
                      color: Color(0xFF999999),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ));
                }

                if (isHideRightArrow == false)
                {
                  list.add(new Container(
                    alignment:Alignment.center,
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: (this.rightArrowColor == null) ? Color(0xFF929292):this.rightArrowColor,
                      size: 20,
                    ),
                  ));
                } else {
                  list.add(new Container(
                    alignment:Alignment.center,
                    width: 15,
                  ));
                }


                return list;

              })(),
            ),
          ),
        ],
      ),
    );
  }
}