

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/file_upload_dao.dart';
import 'package:flutter_app/dao/user_dao.dart';
import 'package:flutter_app/models/file_upload_entity.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'package:flutter_app/models/user_entity.dart';
import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/bottom_dialog.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/flutter_iconfont.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SettingPage extends StatefulWidget{
  @override
  _SettingPageState createState() => _SettingPageState();
}
class _SettingPageState extends State<SettingPage> {
  String imgUrl = "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  File primaryFile;
  File compressedFile;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    return Scaffold(
        appBar: MyAppBar(
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child: CommonBackTopBar(
        title: "设置", onBack: () => Navigator.pop(context))),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildContainerHeader()
            ],
          ),
        ),
        );

  }
  ///头像是否为空
  Widget _buildIsHasHead(){
    if(AppConfig.avatar==null||AppConfig.avatar.isEmpty){
      return Image.asset(
        "images/icon_user.png",
        width: 28.0,
        height: 28.0,
      );
    }else{
      return CircleAvatar(radius: 16,
          backgroundImage: NetworkImage(imgUrl+AppConfig.avatar));
    }
  }
  ///头像
  Container _buildContainerHeader() {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                var list = List();
                list.add('拍照');
                list.add('相册');
                return CommonBottomSheet(
                  //uses the custom alert dialog
                  list: list,
                  onItemClickListener: (index) {
                    if (index == 0) {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    } else if (index == 2) {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    }
                  },
                );
              });
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child:Icon(Icons.local_florist),
                      ),
                      Expanded(
                        child: Text('头像',
                          style: TextStyle(
                              color: Colours.text_dark,
                              fontSize: 14,
                              decoration: TextDecoration.none),
                        ),
                        flex: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child:_buildIsHasHead(),
                      ),
                      Icon(IconFonts.arrow_right),

                    ],
                  ),
                ],
              ),
            ),
            ThemeView.divider(),
          ],
        ),
      ),
    );
  }
  String getImageBase64(File image) {
    var bytes = image.readAsBytesSync();
    var base64 = base64Encode(bytes);
    return base64;
  }
  ///上传头像
  _pickImage(ImageSource type) async {
    File imageFile = await ImagePicker.pickImage(source: type);
    setState(() {
      primaryFile = imageFile;
    });
    if (imageFile == null) return;
    final tempDir = await getTemporaryDirectory();

    CompressObject compressObject = CompressObject(
      imageFile: imageFile, //image
      path: tempDir.path, //compress to path
      quality: 85, //first compress quality, default 80
      step:
      6, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
    );
    Luban.compressImage(compressObject).then((_path) {
      compressedFile = File(_path);
      String strContent=getImageBase64(compressedFile);
      Map<String, dynamic> param={"base64":strContent,
        "name":"logo.jpg",
        "type":"image/jpeg"
     };
      loadSave(param,AppConfig.token);
    });
  }
  void loadSave(Map<String, dynamic> param,String token) async{
    FileEntity entity = await FileUploadDao.fetch(param,token);
    if(entity?.msgModel != null){
       setState(() {
         AppConfig.avatar = entity.msgModel.avatar;
       });
      }
    DialogUtil.buildToast(entity.msgModel.msg);
    }
  }