import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_box.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/cupertino.dart';

class HomeMineAbout extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      title: "关于我们",
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: ClimbingDeviceUtil.statusBarHeight + 44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
              )),

            Container(
                margin: EdgeInsets.only(top: 15),
                child: ClimbingCellText(
                  data: "当前版本 v1.0.0",
                  fontSize: 14,
                )
            ),

            Container(
              margin: EdgeInsets.only(top: 70),
              child: ClimbingCellBox(
                backgroundColor: Color(0xFFFFFFFF),
                title: "检查更新",

              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 40),
                child: ClimbingCellText(
                  data: "感谢技术贡献者:C.w zdzhen",
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
