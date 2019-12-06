import 'dart:async';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/shipping_address_dao.dart';
import 'package:flutter_app/models/shipping_entity.dart';
import 'package:flutter_app/page/load_state_layout.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/theme_ui.dart';

class ShippingEditAddressPage extends StatefulWidget {
  @override
  _ShippingEditAddressPageState createState() => _ShippingEditAddressPageState();
}

class _ShippingEditAddressPageState extends State<ShippingEditAddressPage> {

  String area='';
  String name='';
  String phone='';
  String address='';
  @override
  void initState() {

    super.initState();
  }

  Widget _btnSave() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
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

  Widget _getContent() {
    return Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    hintText: "收货人姓名",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AppSize.height(30))),
                onChanged: (value){
                  this.name=value;
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    hintText: "收货人电话",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AppSize.height(30))),
                onChanged: (value){
                  this.phone=value;
                },
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 5),
                height: AppSize.height(68),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_location),
                      this.area.length>0?Text('${this.area}', style: TextStyle(color: Colors.black54)):Text('省/市/区', style: TextStyle(color: Colors.black54))
                    ],
                  ),
                  onTap: () async{
                    Result result = await CityPickers.showCityPicker(
                        context: context,
                        height: 200,
                        cancelWidget:
                        Text("取消", style: TextStyle(color: Colors.blue)),
                        confirmWidget:
                        Text("确定", style: TextStyle(color: Colors.blue))
                    );

                    print(result);
                    setState(() {
                      this.area= "${result.provinceName}/${result.cityName}/${result.areaName}";
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    hintText: "详细地址",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AppSize.height(30))),
                maxLines: 4,

                onChanged: (value){
                  this.address="${this.area} ${value}";
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 40),

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
              title: "新增收货地址", onBack: () => Navigator.pop(context)),
        ),
        body: _getContent());
  }


}
