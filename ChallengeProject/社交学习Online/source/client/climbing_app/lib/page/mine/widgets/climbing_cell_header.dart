import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:flutter/cupertino.dart';

class ClimbingCellHeader extends BaseStatelessWidget
{
  final Widget child;

  ClimbingCellHeader({
    this.child
  }):super();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: this.child,
    );
  }
}