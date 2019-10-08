import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatefulWidget {
  final int id;

  DetailPage({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(id);
  }
}

class _DetailPageState extends State<DetailPage> {
  int id = 0;

  _DetailPageState(int id) {
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return new BasePageWidget(
      title: "详情",
      child: new Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: ScreenUtil().setHeight(1080),
                height: ScreenUtil().setHeight(130),
                color: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 130,
                        child: CupertinoTextField(
                          placeholder: '写下你的评论',
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black54, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset("assets/images/turned.png",
                          width: 30, height: 30),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset("assets/images/share.png",
                          width: 30, height: 30),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
