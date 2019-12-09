import 'dart:async';
import 'dart:ui' as prefix0;

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/save_address_dao.dart';
import 'package:flutter_app/dao/shipping_address_dao.dart';
import 'package:flutter_app/dao/shipping_address_edit_dao.dart';
import 'package:flutter_app/models/address_entity.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'package:flutter_app/models/shipping_entity.dart';
import 'package:flutter_app/page/load_state_layout.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/theme_ui.dart';

import '../../functions.dart';

class ShippingEditAddressPage extends StatefulWidget {
  final String id;

  ShippingEditAddressPage({this.id});

  @override
  _ShippingEditAddressPageState createState() =>
      _ShippingEditAddressPageState();
}

class _ShippingEditAddressPageState extends State<ShippingEditAddressPage> {
 AddressModel addressModelInfo=AddressModel();
  TextEditingController _controllerName;
  TextEditingController _controllerTel;
  TextEditingController _controllerDistrict ;
  TextEditingController _controllerStreet ;
  LoadState _layoutState = LoadState.State_Loading;
  String name = '';
  String phone = '';

  String street = '';
  bool _isLoading = false;
 Result resultArr = new Result();
  @override
  void initState() {
    _isLoading = true;
    loadData(AppConfig.token);
    super.initState();
  }

  void loadData(String token) async {
    AddressEditEntity entity =
        await ShippingEditAddressDao.fetch(token, widget.id);
    if (entity?.addressModel != null) {
      addressModelInfo = entity.addressModel;
      phone=addressModelInfo.tel;
      name=addressModelInfo.name;
      street=addressModelInfo.district;

      _switchValue= entity.addressModel.isDefault;
      _controllerName=TextEditingController.fromValue(
          TextEditingValue(
              text: addressModelInfo.name==null ? "":addressModelInfo.name,
              selection:TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: addressModelInfo.name==null?0:addressModelInfo.name.length
              )))
      );
      _controllerTel = TextEditingController.fromValue(
          TextEditingValue(
              text: addressModelInfo.tel==null ? "":addressModelInfo.tel,
              selection:TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: addressModelInfo.tel==null? 0:addressModelInfo.tel.length
              )))
      );
      _controllerDistrict = TextEditingController.fromValue(
          TextEditingValue(
              text: addressModelInfo.district==null ? "":addressModelInfo.city+addressModelInfo.district,
              selection:TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: addressModelInfo.city==null?0:(addressModelInfo.city+addressModelInfo.district).length
              )))
      );
      _controllerStreet  = TextEditingController.fromValue(
          TextEditingValue(
              text: addressModelInfo.addressDetail==null ? "":addressModelInfo.addressDetail,
              selection:TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: addressModelInfo.addressDetail==null? 0:addressModelInfo.addressDetail.length
              )))
      );
      if (mounted) {
        setState(() {
          _isLoading = false;
          _layoutState = LoadState.State_Success;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    }
  }

  Widget _btnSave() {
    return InkWell(
      onTap: () {

        Map<String, dynamic> param={"addressDetail":street,
          "areaCode":resultArr.areaId!=null?resultArr.areaId:addressModelInfo.areaCode,
          "city":resultArr.areaId!=null?resultArr.cityName:addressModelInfo.city,
        "district":street,"id":int.parse(addressModelInfo.id),
        "idUser":int.parse(addressModelInfo.idUser),"isDefault":_switchValue,"isDelete":addressModelInfo.isDelete,
          "name":name,"postCode":resultArr.areaId!=null?resultArr.areaId:addressModelInfo.areaCode,
          "province":resultArr.provinceId!=null?resultArr.provinceName:addressModelInfo.province,
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
     DialogUtil.buildToast(entity.msgModel.msg);
   }else{
     DialogUtil.buildToast("服务器错误~");
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
                          locationCode: resultArr.areaId != null?resultArr.areaId:
                          addressModelInfo.areaCode,
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
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
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
                hint:addressModelInfo.city+addressModelInfo.district,
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
        body: LoadStateLayout(
            state: _layoutState,
            errorRetry: () {
              setState(() {
                _layoutState = LoadState.State_Loading;
              });
              _isLoading = true;
              loadData(AppConfig.token);
            },
            successWidget: _getContent()));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

}
