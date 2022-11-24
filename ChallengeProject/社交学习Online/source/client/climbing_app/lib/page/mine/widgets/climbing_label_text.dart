

import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';

class ClimbingLabelText extends BaseStatelessWidget
{

  final String text;
  final int themeColor;
  final EdgeInsets margin;
  final double fontSize;

  ClimbingLabelText({
    @required this.text,
    this.themeColor,
    this.margin,
    this.fontSize,
  }):super();



  @override
  Widget build(BuildContext context) {

    int fontColor = 0xFF000000 + themeColor;
    int backgroundColor = 0x33000000 + themeColor;
    int borderColor = 0xFF000000 + themeColor;


    // TODO: implement build
    BorderSide borderSide = BorderSide(
        color: Color(borderColor),
        width: 1
    );

    return Container(
      margin: this.margin,
      decoration: BoxDecoration(
          color: Color(backgroundColor),
          borderRadius:BorderRadius.circular(4.0) ,
          border: Border(
            left: borderSide,
            right: borderSide,
            top: borderSide,
            bottom: borderSide,
          )
      ),
      padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
      child: ClimbingCellText(
        data: this.text,
        fontSize: (this.fontSize != null) ? this.fontSize : 12,
        fontWeight: FontWeight.w600,
        color: Color(fontColor),
      ),
    );
  }

}