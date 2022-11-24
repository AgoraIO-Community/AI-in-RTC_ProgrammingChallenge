

import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:flutter/cupertino.dart';

class MessageNetKit
{

  static Future getGmessages({
    int page = 1
  })
  async {

    return NetKit.post(
      isShowMsg: false,
      isShowLoading: false,
      needToken: false,
      refreshToken: false,
      path: "/rest/message/gmessages_list_get",
      data: {
        "page": page
      },
    );
  }

}