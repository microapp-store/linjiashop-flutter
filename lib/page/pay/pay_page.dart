import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_app/view/my_icons.dart.dart';
import 'package:flutter_app/view/theme_ui.dart';

class PayPage extends StatefulWidget {
  final String orderSn;
  final String totalPrice;

  PayPage({this.orderSn, this.totalPrice});

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  int _radioGroupPay = 0;

  void _handleRadioValueChanged(int value) {
    setState(() {
      _radioGroupPay = value;
    });
  }

  Widget _getContent() {
    return Stack(children: <Widget>[
      Container(
          color: ThemeColor.appBg,
          child: Column(
            children: <Widget>[
              _myListTile('订单编号', widget.orderSn, ThemeTextStyle.detailStyle),
              _myListTile('应付金额', '¥' + widget.totalPrice,
                  ThemeTextStyle.detailStylePrice),
              _myListTileIcon(
                  Icon(
                    MyIcons.weixinpay,
                    size: 30,
                    color: Colors.green,
                  ),
                  0),
              ThemeView.divider(),
              _myListTileIcon(
                  Icon(MyIcons.zhifubpay, size: 40, color: Colors.blue), 1),
            ],
          )),
      Positioned(bottom: 0, left: 0, child: _btnBottom())
    ]);
  }

  Widget _btnBottom() {
    return InkWell(
      onTap: () {
        _launchAlipayURL();
      },
      child: Container(
        alignment: Alignment.center,
        width: AppSize.width(1080),
        height: AppSize.height(160),
        color: Colors.green,
        child: Text(
          '立即支付',
          style: TextStyle(color: Colors.white, fontSize: AppSize.sp(54)),
        ),
      ),
    );
  }

  Widget _myListTileIcon(Icon con, int index) {
    return Container(
      height: AppSize.height(180.0),
      color: Colors.white,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: con,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Checkbox(
                  value: _radioGroupPay == index,
                  activeColor: Colors.pink,
                  onChanged: (bool val) {
                    _handleRadioValueChanged(index);
                  },
                )),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _myListTile(String title, String subTitle, TextStyle style) {
    return Container(
      height: AppSize.height(120.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: ThemeTextStyle.personalShopNameStyle,
                )),
            flex: 1,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.right,
                  style: style,
                )),
            flex: 1,
          )
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
              title: "收银台", onBack: () => Navigator.pop(context)),
        ),
        body: _getContent());
  }

  _launchAlipayURL() async {
    if (Platform.isAndroid) {
      String urlAndroid = "alipays://platformapi/startapp?appId=20000123";
      if (await canLaunch(urlAndroid)) {
        await launch(urlAndroid);
      } else {
        throw 'Could not launch $urlAndroid';
      }
    } else {
      String urlIos = "taobao://item.taobao.com/item.html?id=41700658839";
      if (await canLaunch(urlIos)) {
        await launch(urlIos);
      } else {
        throw 'Could not launch $urlIos';
      }
    }
  }
}
