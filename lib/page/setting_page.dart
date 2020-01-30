import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';

import 'package:flutter_app/dao/file_upload_dao.dart';
import 'package:flutter_app/dao/save_sex_dao.dart';

import 'package:flutter_app/models/file_upload_entity.dart';
import 'package:flutter_app/models/msg_entity.dart';

import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/bottom_dialog.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/custom_view.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/flutter_iconfont.dart';
import 'package:flutter_app/view/my_icons.dart.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  File primaryFile;
  File compressedFile;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _userSubscription.cancel();
  }

  ///修改姓名
  Widget _buildModifyName() {
    return InkWell(
        onTap: () {
          Map<String, String> p = {"name": AppConfig.nickName};
          Routes.instance
              .navigateToParams(context, Routes.modify_name_page, params: p);
        },
        child: Container(
          color: Colors.white,
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
                          child: Icon(CupertinoIcons.profile_circled),
                        ),
                        Expanded(
                          child: Text(
                            '姓名',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Text(AppConfig.nickName,
                                style: TextStyle(
                                    color: Colours.text_gray,
                                    fontSize: 14,
                                    decoration: TextDecoration.none))),
                        Icon(IconFonts.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              ThemeView.divider(),
            ],
          ),
        ));
  }

  ///修改密码
  Widget _buildModifyPwd() {
    return InkWell(
        onTap: () {
          Routes.instance.navigateTo(context, Routes.modify_pwd_page);
        },
        child: Container(
          color: Colors.white,
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
                          child: Icon(Icons.lock_outline),
                        ),
                        Expanded(
                          child: Text(
                            '修改密码',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
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
        ));
  }
  ///更换手机
  Widget _buildChangePhone() {
    return InkWell(
        onTap: () {
          DialogUtil.buildToast("敬请期待");
        },
        child: Container(
          color: Colors.white,
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
                          child: Icon(Icons.phone_forwarded),
                        ),
                        Expanded(
                          child: Text(
                            '更换手机',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
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
        ));
  }
  String getGender(String str) {
    if ("male" == str) {
      return "男";
    } else {
      return "女";
    }
  }

  Widget _buildSex() {
    return InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                var list = List();
                list.add('男');
                list.add('女');
                return CommonBottomSheet(
                  //uses the custom alert dialog
                  list: list,
                  onItemClickListener: (index) {
                    if (index == 0) {
                      Navigator.pop(context);
                      loadSexSave("male", AppConfig.token);
                    } else if (index == 2) {
                      Navigator.pop(context);
                      loadSexSave("female", AppConfig.token);
                    }
                  },
                );
              });
        },
        child: Container(
          color: Colors.white,
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
                          child: Icon(MyIcons.sexicon),
                        ),
                        Expanded(
                          child: Text(
                            '性别',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Text(
                                AppConfig.gender.isEmpty
                                    ? "请选择"
                                    : getGender(  AppConfig.gender),
                                style: TextStyle(
                                    color: Colours.text_gray,
                                    fontSize: 14,
                                    decoration: TextDecoration.none))),
                        Icon(IconFonts.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              ThemeView.divider(),
            ],
          ),
        ));
  }

  void loadSexSave(String sex, String token) async {
    MsgEntity entity = await SaveSexDao.fetch(sex, token);
    if (entity?.msgModel != null) {
      if (entity.msgModel.code == 20000) {
        setState(() {
          AppConfig.gender=sex;


        });
      }
      DialogUtil.buildToast(entity.msgModel.msg);
    } else {
      DialogUtil.buildToast('失败');
    }
  }

  StreamSubscription _userSubscription;

  ///监听Bus events
  void _listen() {
    _userSubscription = eventBus.on<UserInfoInEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    _listen();

    return Scaffold(
      appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
              title: "设置", onBack: () => Navigator.pop(context))),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ///头像
            _buildContainerHeader(),
            ///姓名
            _buildModifyName(),
            ///性别
            _buildSex(),
            ///密码
            _buildModifyPwd(),
            ///更换手机
            _buildChangePhone(),
            _btnExit(context)
          ],
        ),
      ),
    );
  }
  ///退出登录
  Widget _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('温馨提示'),
          content: Text('确定要退出登录吗？'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () async {
                Navigator.of(context).pop();
                AppConfig.token='';
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("token", "");
                Routes.instance.navigateTo(context,Routes.ROOT);
              },
            ),
          ],
        );
      },
    );
  }
  Widget _btnExit(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child:Center(

        child:Material(
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(new Radius.circular(25.0)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: ()  {
                _showExitDialog(context);
              },
              child: Container(
                width: 300.0,
                height: 50.0,
                //设置child 居中
                alignment: Alignment(0, 0),
                child: Text("退出登录",style: TextStyle(color: Colors.white,fontSize: 16.0),),
              ),
            ),
          ),
        ),
      ) ,
    );



  }

  ///头像是否为空
  Widget _buildIsHasHead() {
    if (AppConfig.avatar.isEmpty) {
      return Image.asset(
        "images/icon_user.png",
        width: 28.0,
        height: 28.0,
      );
    } else {
      return CircleAvatar(
          radius: 16, backgroundImage: NetworkImage(imgUrl + AppConfig.avatar));
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
                        child: Icon(Icons.local_florist),
                      ),
                      Expanded(
                        child: Text(
                          '头像',
                          style: TextStyle(
                              color: Colours.text_dark,
                              fontSize: 14,
                              decoration: TextDecoration.none),
                        ),
                        flex: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: _buildIsHasHead(),
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
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LoadingDialog(
              text: "图片上传中…",
            );
          });
      String strContent = getImageBase64(compressedFile);
      Map<String, dynamic> param = {
        "base64": strContent,
        "name": "logo.jpg",
        "type": "image/jpeg"
      };
      loadSave(param,AppConfig.token);
    });
  }

  void loadSave(Map<String, dynamic> param, String token) async {
    FileEntity entity = await FileUploadDao.fetch(param, token);
    if (entity?.msgModel != null) {
      setState(() {
        AppConfig.avatar = entity.msgModel.avatar;
      });
    }
    Navigator.pop(context);
    DialogUtil.buildToast(entity.msgModel.msg);
  }
}
