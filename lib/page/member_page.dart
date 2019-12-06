import 'package:flutter/material.dart';
import 'package:flutter_app/functions.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';

import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/flutter_iconfont.dart';
import 'package:flutter_app/view/my_icons.dart.dart';


import '../common.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child: CommonTopBar(title: "我的"),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderType(context),
          _orderTitle(context),
          _actionList(context)
        ],
      ),
    );
  }

  //头像区域

  Widget _topHeader() {
    return Container(
      width: double.infinity,
      height: AppSize.height(450),
      child: Image(fit: BoxFit.fill, image: AssetImage("images/banner.jpg")),
    );
  }

  //我的订单顶部
  Widget _orderTitle(BuildContext context) {
    return InkWell(
      onTap: () {
        AppConfig.orderIndex = 0;
        Routes.instance.navigateTo(context, Routes.order_page);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: ListTile(
          leading: Icon(Icons.assignment),
          title: Text('全部订单'),
          trailing: Icon(IconFonts.arrow_right),
        ),
      ),
    );
  }

  Widget _orderType(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: AppSize.width(1080),
      height: AppSize.height(160),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              AppConfig.orderIndex = 0;
              Routes.instance.navigateTo(context, Routes.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.daifukuan,
                    size: 30,
                  ),
                  Text('待付款'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AppConfig.orderIndex = 1;
              Routes.instance.navigateTo(context, Routes.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.daifahuo,
                    size: 30,
                  ),
                  Text('待发货'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AppConfig.orderIndex = 2;
              Routes.instance.navigateTo(context, Routes.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.yifahuo,
                    size: 30,
                  ),
                  Text('已发货'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AppConfig.orderIndex = 3;
              Routes.instance.navigateTo(context, Routes.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.yiwancheng,
                    size: 30,
                  ),
                  Text('已完成'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
//
  Widget _myListTile({String title, Icon con, OnGoMineCallback onGoMineCallback}) {
    return InkWell(
      onTap:onGoMineCallback ,
      child:  Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: ListTile(
          leading: con,
          title: Text(title),
          trailing: Icon(IconFonts.arrow_right),
        ),
      ) ,
    );

  }

  Widget _actionList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile(title:'收货地址',con:Icon(MyIcons.addressholder),onGoMineCallback:()
          {
            Routes.instance.navigateTo(context, Routes.address_page);
          }),
          _myListTile(title:'我的积分',con:Icon(MyIcons.jifenholder),onGoMineCallback:()
          {
            Routes.instance.navigateTo(context, Routes.address_page);
          }),
          _myListTile(title:'我的优惠券',con:Icon(MyIcons.youhuiquanholder),onGoMineCallback:()
          {
            Routes.instance.navigateTo(context, Routes.address_page);
          }),
          _myListTile(title:'我的礼物',con:Icon(MyIcons.liwuholder),onGoMineCallback:()
          {
            Routes.instance.navigateTo(context, Routes.address_page);
          }),
        ],
      ),
    );
  }
}
