
import 'package:flutter/cupertino.dart';

class ClimbingCellText extends Text
{

  final Color color;

  ClimbingCellText(
        {
          String data,
          this.color,
          double fontSize,
          FontWeight fontWeight,
          EdgeInsets margin,
          TextOverflow overflow,
          int maxLines,
      }):super((data == null) ? "":data,
      textAlign:TextAlign.left,
      maxLines:maxLines,
      overflow:(overflow == null)?TextOverflow.visible:overflow,
      style:TextStyle(
      fontSize: ((){
        if (fontSize.toString() == "null")
        {
          return 14.0;
        }
        return fontSize;
      })(),
      fontWeight: (fontWeight == null)?FontWeight.w400:fontWeight,
      color: (color == null) ? Color(0xFF333333):color,
      decoration: TextDecoration.none,
  ));

}