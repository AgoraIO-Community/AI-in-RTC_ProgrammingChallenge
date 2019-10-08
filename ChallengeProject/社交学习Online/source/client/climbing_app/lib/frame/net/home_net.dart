import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:flutter/cupertino.dart';

class HomeNetKit {
  static Future getFocusmapsList(BuildContext context) {
    return NetKit.post(
        path: "/rest/homepage/focusmaps_list_get",
        isShowLoading: false,
        context: context);
  }

  static Future getCoursesList(BuildContext context, int page) {
    return NetKit.post(
        path: "/rest/homepage/courses_list_get",
        isShowLoading: false,
        context: context,
        data: {"page": page});
  }
}
