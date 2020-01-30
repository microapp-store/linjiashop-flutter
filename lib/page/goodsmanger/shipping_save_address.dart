import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';

import 'package:flutter_app/dao/save_address_dao.dart';



import 'package:flutter_app/models/msg_entity.dart';


import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:provider/provider.dart';
import '../../functions.dart';
class ShippingSaveAddressPage extends StatefulWidget {
  @override
  _ShippingSaveAddressPageState createState() =>
      _ShippingSaveAddressPageState();
}
class _ShippingSaveAddressPageState extends State<ShippingSaveAddressPage> {

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerTel = TextEditingController();

  TextEditingController _controllerStreet = TextEditingController();

  String name = '';
  String phone = '';
  String street = '';


 Result resultArr = new Result();
  @override
  void initState() {
    super.initState();
  }



  Widget _btnSave() {
    return InkWell(
      onTap: () {
        if(name.isEmpty){
          DialogUtil.buildToast("请填写收货人姓名");
          return;
        }
        if(phone.isEmpty){
          DialogUtil.buildToast("请填写手机号");
          return;
        }
        if(resultArr.areaId==null){
          DialogUtil.buildToast("请选择区域");
          return;
        }
        if(street.isEmpty){
          DialogUtil.buildToast("请填写详细地址");
          return;
        }
        Map<String, dynamic> param={"addressDetail":street,
          "areaCode":resultArr.areaId,
          "city":resultArr.cityName,
        "district":resultArr.areaName,
       "isDefault":_switchValue,
          "name":name,"postCode":resultArr.areaId,
          "province":resultArr.provinceName,
        "tel":phone};
        loadSave(param,AppConfig.token);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        width: AppSize.width(1080),
        height: AppSize.height(160),
        color: Colors.red,
        child: Text(
          '保存',
          style: TextStyle(color: Colors.white, fontSize: AppSize.sp(54)),
        ),
      ),
    );
  }
 void loadSave(Map<String, dynamic> param,String token) async{

   MsgEntity entity = await SaveDao.fetch(param,token);
   if(entity?.msgModel != null){
     if(entity.msgModel.code==20000){
       Navigator.pop(context);
     }
     eventBus.fire(OrderInEvent("succuss"));
     DialogUtil.buildToast(entity.msgModel.msg);
   }else{
     Routes.instance.navigateTo(context, Routes.login_page);
     AppConfig.token  = '';
   }

 }
  Widget _buildEditText(
      {double length,
      String title,
      String hint,
      TextEditingController controller,
      OnChangedCallback onChangedCallback}) {
    return Container(
      color: Colours.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: length),
                child: Text(
                  title,
                  style: ThemeTextStyle.primaryStyle,
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: ThemeTextStyle.detailStyle,
                  ),
                  onChanged: (inputStr) {
                    if (null != onChangedCallback) {
                      onChangedCallback();
                    }
                  },
                  controller: controller,
                ),
                flex: 1,
              )
            ],
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }
  Widget _buildAddressEditText({double length,
    String title,
    String hint,
  }) {
    return Container(
      color: Colours.white,
      child: Column(
        children: <Widget>[
          Container(
            height: AppSize.height(120.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: length),
                  child: Text(
                    title,
                    style: ThemeTextStyle.primaryStyle,
                  ),
                ),
                Expanded(

                  child:InkWell(
                    onTap: ()async{
                      Result tempResult = await CityPickers.showCityPicker(
                          context: context,
                          height: 200,
                          cancelWidget:
                          Text("取消", style: TextStyle(color: Colors.blue)),
                          confirmWidget:
                          Text("确定", style: TextStyle(color: Colors.blue))
                      );
                      if(tempResult != null){
                        setState(() {
                          resultArr = tempResult;
                        });
                      }
                    },
                    child: Text(
                      resultArr.areaId != null?getAddress(resultArr.provinceName):
                      hint,
                      style: ThemeTextStyle.primaryStyle,
                    ),
                  ),
//
                  flex: 1,
                )
              ],
            ), 
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }

  String getAddress(String province){
    String res='';
    if (province.contains("北京") ||
        province.contains("重庆") ||
       province.contains("天津") ||
        province.contains("上海") ||
       province.contains("深圳") ||
       province.contains("香港") ||
       province.contains("澳门")) {
      res=resultArr.cityName+resultArr.areaName;
    }else{
      res=resultArr.provinceName+resultArr.cityName+resultArr.areaName;
    }
    return res;

  }

  ///收货地址
  Widget _buildSwitch() {
    return Container(
      color: Colours.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '设为默认收货地址',
                    style: ThemeTextStyle.primaryStyle,
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 15.0),
                  alignment: Alignment.centerRight,
                  child: CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (bool value) {
                        setState(() {
                          _switchValue = value;
                        });
                      }),
                ),
                flex: 1,
              )
            ],
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }

  bool _switchValue = false;

  Widget _getContent() {
      return Container(
        color: Colours.green_e5,
        child: ListView(
          children: <Widget>[
            _buildEditText(
                length: 63,
                title: '姓名',
                hint: '收货人姓名',
                controller: _controllerName,
                onChangedCallback: () {
                  name = _controllerName.text.toString();
                }),
            _buildEditText(
                length: 63,
                title: '电话',
                hint: '收货人手机号',
                controller: _controllerTel,
                onChangedCallback: () {
                  phone = _controllerTel.text.toString();
                }),
            _buildAddressEditText(
                length: 63,
                title: '地区',
                hint: '请选择省/市/区',
               ),
            _buildEditText(
                length: 32,
                title: '详细地址',
                hint: '街道门派、楼层房间号等信息',
                controller: _controllerStreet,
                onChangedCallback: () {
                  street = _controllerStreet.text.toString();
                }),
            _buildSwitch(),
            _btnSave(),
          ],
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
              title: "编辑收货地址", onBack: () => Navigator.pop(context)),
        ),
        body: _getContent());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

}
