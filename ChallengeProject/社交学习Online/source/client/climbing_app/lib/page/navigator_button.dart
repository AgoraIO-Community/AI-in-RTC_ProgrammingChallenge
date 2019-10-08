

import 'package:climbing_app/frame/utils/theme.dart';
import 'package:flutter/cupertino.dart';

class ClimbingNavigatorBtn extends CupertinoButton
{

  ClimbingNavigatorBtn({
    String text,
    VoidCallback onPressed,
  }):super(
    padding: EdgeInsets.zero,
    child: Text(text, style: TextStyle(fontSize: 16,color:Color(ClimbingTheme.mineTopBackgroundColor)),),
    pressedOpacity: 0.8,
    onPressed:onPressed
  );
}