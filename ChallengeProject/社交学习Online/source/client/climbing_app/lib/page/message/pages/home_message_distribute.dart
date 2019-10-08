import 'dart:io';

import 'package:climbing_app/frame/constant.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:climbing_app/frame/kobserver.dart';
import 'package:climbing_app/frame/net/net_kit.dart';
import 'package:climbing_app/frame/pages/basepage_widget.dart';
import 'package:climbing_app/frame/pages/basestateful_widget.dart';
import 'package:climbing_app/frame/pages/basestateless_widget.dart';
import 'package:climbing_app/frame/pages/uikit.dart';
import 'package:climbing_app/frame/utils/device.dart';
import 'package:climbing_app/frame/utils/theme.dart';
import 'package:climbing_app/page/navigator_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;

class HomeMessageDistribute extends BaseStatelessWidget
{

  String _messageEditContent = "";
  List _editFileList = new List();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageWidget(
      bgColor: Color(0xFFFFFFFF),
      child: Container(
        margin: EdgeInsets.only(top: ClimbingDeviceUtil.statusBarHeight+44),
        child: Column(
          children: <Widget>[
            // 正文信息部分
            Container(
              padding: EdgeInsets.all(2),
              height: 150,
              width: ClimbingDeviceUtil.screenPixel.width,
              color: Color(0xFFFFFFFF),
              alignment: AlignmentDirectional.topStart,
              child: CupertinoTextField(
                onChanged: (text){
                  _messageEditContent = text;
                },
                decoration: null,
                showCursor:true,
                cursorColor: Color(ClimbingTheme.mineTopBackgroundColor),
                cursorWidth: 2,
                maxLines: 10,
                maxLengthEnforced: true,
                textInputAction: TextInputAction.unspecified,
                placeholder: "请输入文字信息",
//                controller: TextEditingController(
//                  text: "asdfadsf"
//                ),
                style: TextStyle(
                  fontSize: 16,
                  height: 1.1786,
                  color: Color(0xFF333333)
                ),

              ),
            ),

            // 图片选择部分
            Container(
              child: ClimbingUploadFiles(
                onAddedNewFile: (files){
                  _editFileList = files;
                },
              ),
            )

          ],
        ),
      ),
      rightItem: ClimbingNavigatorBtn(
        text: "完成",
        onPressed: ()=>saveAction(context),
      ),
      leftItem: ClimbingNavigatorBtn(
        text: "取消",
        onPressed: ()=>UIKit.popWidget(context: context),
      ),
    );
  }


  void saveAction(BuildContext context){

    KeyValueModel().where({ "key":kPlatformUserInfo }).queryOne().then((rUserRsp){

      String val = rUserRsp["value"];
      Map rUser = convert.jsonDecode(val);
      String rowguid = rUser["rowguid"];


      NetKit.post(
          path: "/rest/message/gmessages_add",
          data: {
            "content":_messageEditContent,
            "files":_editFileList,
            "userguid":rowguid
          },
          needToken: true,
          context: context,
          isShowMsg: true,
          isShowLoading: true
      ).then((rRsp){
        Map status = rRsp["status"];
        if (status["code"] == 1)
        {
          KOBServer.postKVO(kMessageNeedRefreshNotification, null);
          UIKit.popWidget(context:  context);
        }
      });


    });



  }
}


class ClimbingUploadFiles extends BaseStatefulWidget
{

  final Function(List) onAddedNewFile;

  ClimbingUploadFiles({
    this.onAddedNewFile,
  }):super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClimbingUpdateFileState(
      onAddedNewFile: onAddedNewFile
    );
  }
}


class ClimbingUpdateFileState extends State<ClimbingUploadFiles>
{

  List _filesList = new List();
  double _max = 4;
  double get imageWidth => (ClimbingDeviceUtil.screenPixel.width - _max*10)/_max;
  final Function(List) onAddedNewFile;

  ClimbingUpdateFileState({
    this.onAddedNewFile,
  }):super();

  Widget cPreviewImage({
    BuildContext context,
    String path,
  }){
    return Container(
      margin: EdgeInsets.all(5),
      color:Color(ClimbingTheme.messageCellPicBgColor),
      width: imageWidth,
      height: imageWidth,
      child: Image.network(path, fit: BoxFit.cover,),
    );
  }

  Widget cAddIcon(BuildContext context){
    return Container(
      margin: EdgeInsets.all(5),
      color:Color(0xFF999999),
      width: imageWidth,
      height: imageWidth,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.add, color: Color(0xFFFFFFFF), size: 40,),
        onPressed: (){
          ImagePicker.pickImage(source: ImageSource.gallery).then((rRsp){
            File file = rRsp;
            NetKit.uploadPost(
                filePath: file.path,
                context:context
            ).then((rRsp){

              Map status = rRsp["status"];
              if (status["code"] == 1)
              {
                Map custom = rRsp["custom"];
                List files = custom["files"];
                String path = files[0];

                path = NetKit.absolutePicURL(path);
                print(path);

                _filesList.add(path);
                setState(() {
                });
                if (onAddedNewFile != null)
                {
                  onAddedNewFile(_filesList);
                }
              }
            });
          });
        },
      ),

    );
  }


  @override
  Widget build(BuildContext context) {


    List<Widget> children = new List();
    for (int i = 0; i<_filesList.length+1; i++)
    {
      Row row;
      int dif = (i / 4).floor();

      if (i%4 == 0)
      {
        if ((children.length <= dif) || (children[dif] == null))
        {
          children.insert(dif, Row(
            children: new List(),
          ));
        }
      }
      row =  children[dif];

      if (i == _filesList.length)
      {
        row.children.add(cAddIcon(context));
      }
      else
      {
        row.children.add(cPreviewImage(
            context: context,
            path: _filesList[i]
        ));
      }
    }

    // TODO: implement build
    return Container(
//              color: Color(0xFFFF0000),
      child: Column(
        children: children,
      ),
    );
  }
}
