import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class ClimbingLoading extends BaseStatefulWidget
{
  final VoidCallback progressEndedCallback;
  final bool isAutoStart;

  ClimbingLoadingState lastState;


  ClimbingLoading({
    this.progressEndedCallback,
    this.isAutoStart
  }):super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    lastState = ClimbingLoadingState(
      progressEndedCallback: progressEndedCallback
    );
    return lastState;
  }

  void start(){
    lastState.start();
  }

  void stop(){
    lastState.stop();
  }

}

class ClimbingLoadingState extends State<ClimbingLoading>
    with SingleTickerProviderStateMixin<ClimbingLoading>
{

  final bool isAutoStart;
  final VoidCallback progressEndedCallback;
  AnimationController controller;

  void start(){
    controller.forward();
  }

  void stop(){
    controller.stop();
  }

  ClimbingLoadingState({
    this.progressEndedCallback,
    this.isAutoStart = true,
  }):super();


  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 1);

    var weakController =  controller;
    controller
      ..addStatusListener((status){

        if (status == AnimationStatus.completed)
        {
          weakController.value = 0;
          weakController.forward();
        }
      })
      ..addListener(() {
        setState((){});
      });
    if (isAutoStart)
    {
      controller..forward();
    }


    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    if (progressEndedCallback != null)
      progressEndedCallback();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: ClimbingLoadingCircle(
        value: controller.value,
      ),
    );
  }

}


class ClimbingLoadingCircle extends CustomPainter
{

  double value;
  double arcStart;
  double arcEnd;

  ClimbingLoadingCircle({
  @required this.value,
  }){
    //arcStart这样计算，看起来就是在转圈，否则只是单纯的绘制圆形，可以把下面的2去掉查看效果就明白了
    arcStart = math.pi + math.pi * value * 2;
    //math.pi * 2 的弧度是一个完整的圆形，这样动画结束的时候value是1，也就正好画出了一个圆形
    arcEnd = math.pi + math.pi * 0.6;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double minValue = math.min(size.width, size.height);
    Paint paint = Paint()
    //画笔颜色
      ..color = Color(ClimbingTheme.loadingThemeColor)
    //边缘平滑
      ..strokeCap = StrokeCap.round
    //画笔宽度
      ..strokeWidth = 3
    //不填充
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromLTWH(0, 0, minValue, minValue), arcStart, arcEnd, false, paint);
  }

  @override
  bool shouldRepaint(ClimbingLoadingCircle oldDelegate) {
    // TODO: implement shouldRepaint
    return value != oldDelegate.value;
  }

}