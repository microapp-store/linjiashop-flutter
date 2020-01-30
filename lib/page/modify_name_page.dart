import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';

import 'package:flutter_app/dao/save_name_dao.dart';

import 'package:flutter_app/models/msg_entity.dart';

import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:provider/provider.dart';

class ModifyNamePage extends StatefulWidget {
  String name;

  ModifyNamePage({this.name});

  @override
  _ModifyNamePageState createState() => _ModifyNamePageState();
}

class _ModifyNamePageState extends State<ModifyNamePage> {
  String _inputText = '';

  Widget _buildName() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '*',
                        style: ThemeTextStyle.cardPriceStyle,
                      ),
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
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.end,
                        controller: TextEditingController.fromValue(
                            TextEditingValue(
                                text: _inputText.isEmpty
                                    ? widget.name
                                    : _inputText,
                                // 保持光标在最后
                                selection: TextSelection.fromPosition(
                                    TextPosition(
                                        affinity: TextAffinity.downstream,
                                        offset:_inputText.isEmpty
                                            ? widget.name.length
                                            : _inputText.length)))),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入姓名",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                        onChanged: (inputStr) {
                          _inputText = inputStr;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }

  Widget _btnSave() {
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
            borderRadius: new BorderRadius.circular(25.0),
            onTap: () {
              if (_inputText.isNotEmpty)
                loadSave(_inputText, AppConfig.token);
              else
                DialogUtil.buildToast('姓名没有修改');
            },
            child: Container(
              width: 300.0,
              height: 50.0,
              //设置child 居中
              alignment: Alignment(0, 0),
              child: Text("保   存",style: TextStyle(color: Colors.white,fontSize: 16.0),),
            ),
          ),
        ),
      ),
    ) ,
  );



  }

  void loadSave(String name, String token) async {
    MsgEntity entity = await SaveNameDao.fetch(name, token);
    if (entity?.msgModel != null) {
      DialogUtil.buildToast(entity.msgModel.msg);
      if (entity.msgModel.code == 20000) {
        AppConfig.nickName  = name;
        Navigator.pop(context);
      }
    } else {
      DialogUtil.buildToast('失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    return Scaffold(
      appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
              title: "修改姓名", onBack: () => Navigator.pop(context))),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildName(), _btnSave()],
        ),
      ),
    );
  }
}
