import 'package:climbing_app/frame/net/home_net.dart';
import 'package:climbing_app/frame/pages/list_page.dart';
import 'package:climbing_app/frame/pages/swipe_refresh_layout.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/page/detail_page.dart';
import 'package:climbing_app/page/mine/widgets/climbing_cell_text.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/page/home/widgets/climbing_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageTab1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageTab1State();
  }
}

class _HomePageTab1State extends State<HomePageTab1>
    with AutomaticKeepAliveClientMixin {
  List<String> imgUrls = new List();
  List itemDates = new List();
  int pageIndex = 1;

  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    imgUrls.add(
        'https://muse-img.huabanimg.com/13d7a1185c5b0fcd1e9c92ced66fa565c1a67cb59193-uykq7gco9a4i_/fw/880');

    Future.microtask(() {
      HomeNetKit.getFocusmapsList(context).then((r) {
        List urls = r["custom"]["focuses"];
        imgUrls = urls.map((d) => d["main"].toString()).toList();
        print(imgUrls);
        setState(() {});
      });
      HomeNetKit.getCoursesList(context, pageIndex).then((r) {
        itemDates = r["custom"]["data"];
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Color(0xFFFFFFFF),
        child: new SwipeRefreshLayout(
          onLoad: () {
            pageIndex = 1;
            return HomeNetKit.getCoursesList(context, pageIndex).then((r) {
              itemDates = r["custom"]["data"];
              setState(() {});
            });
          },
          onLoadMore: () {
            pageIndex++;
            return HomeNetKit.getCoursesList(context, pageIndex).then((r) {
              List data = r["custom"]["data"];
              itemDates.addAll(data);
              setState(() {
                if (itemDates.length == 0) {
                  pageIndex--;
                }
              });
            });
          },
          child: new ListPage(
              itemCount: itemDates.length,
              headerCount: 2,
              headerCreator: (BuildContext context, int position) {
                return getHeader(position);
              },
              itemWidgetCreator: (BuildContext context, int position) {
                return getItem(itemDates[position]);
              },
              itemClickListener: (BuildContext context, int position) {
//                UIKit.pushWidget(target: DetailPage(id: 999), context: context);
              }),
        ));
  }

  Widget getHeader(int position) {
    if (position == 0) {
      return Container(
        height: 50,
        color: Color(0xFFF4F8FB),
        child: Center(
            child: Text(
          "融资速递：WarDucks完成A轮融资",
          style: TextStyle(color: Color(0x88000000), fontSize: 15),
        )),
      );
    }
    return Container(
        margin: EdgeInsets.all(10),
        child: ClimbingSwiper(swiperDataList: imgUrls));
  }

  Widget getItem(Map date) {
    return Container(
      height: ScreenUtil().setHeight(250),
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0Xfff1f1f1), width: 1.0)),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //标题
                    ClimbingCellText(
                      margin: EdgeInsets.only(top: 5),
                      data: date["title"],
                      color: Color(0Xff131313),
                      fontSize: 14,
                    ),
                    Expanded(
                      flex: 1,
                      child: ClimbingCellText(
                        margin: EdgeInsets.only(top: 5),
                        data: date["content"],
                        color: Color(0Xff131313),
                        fontSize: 10,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        //时间
                        ClimbingCellText(
                          margin: EdgeInsets.only(top: 5),
                          data: UIKit.readTimestamp(date["createdAt"]),
                          color: Color(0Xffdadada),
                          fontSize: 12,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        //查看数
                        ClimbingCellText(
                          margin: EdgeInsets.only(top: 5),
                          data: "1000",
                          color: Color(0Xffdadada),
                          fontSize: 12,
                        ),
                      ],
                    )
                  ],
                ),
              )),
          //图片
          Container(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  image: date["cover"],
                  placeholder: "assets/images/default_avatar.png",
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
