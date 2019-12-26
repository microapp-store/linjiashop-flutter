
import 'package:flutter/material.dart';
import 'package:flutter_app/models/order_form_entity.dart';
import 'package:flutter_app/res/colours.dart';

import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/view/theme_ui.dart';

import 'flutter_iconfont.dart';

typedef ImgBtnFunc = void Function(String);

class ImageButton extends StatelessWidget {
  double width;
  double height;
  double iconSize;
  Color iconColor;

  String assetPath;
  String text;

  TextStyle textStyle;
  ImgBtnFunc func;

  ImageButton(this.assetPath,
      {this.width, this.height, this.iconSize, this.text, this.textStyle
      ,this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>func(text),
      child: SizedBox(

        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(assetPath),

                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(text, style: textStyle),
              )
            ]),
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  double iconSize;
  Color iconColor;

  final IconData icon;
  String text;

  TextStyle textStyle;
  ImgBtnFunc func;

  IconBtn(this.icon,
      {this.iconColor, this.text, this.textStyle
        ,this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>func(text),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,color: iconColor),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(text, style: textStyle),
              )
            ]),
    );
  }
}


/**
 * 商品卡片
 */

class ThemeCard extends StatelessWidget {
  final String title;
  final String price;
  final String number;
  final String imgUrl;
  final String descript;
  ThemeCard({
    this.title,
    this.price,
    this.number,
    this.imgUrl,
    this.descript
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.height(268),
      decoration: ThemeDecoration.card2,
      child:
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child:  Container(
                      width: AppSize.height(600),
                      height: AppSize.height(232),
                      margin: EdgeInsets.only(left: 15),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              textAlign: TextAlign.left,
                              style: ThemeTextStyle.cardTitleStyle,
                            ),
                            Text(
                              descript,
                              textAlign: TextAlign.left,
                              style: ThemeTextStyle.cardNumStyle,
                            ),
                            Text(
                              price,
                              textAlign: TextAlign.left,
                              style: ThemeTextStyle.cardPriceStyle,
                            ),
                          ]
                      ),

                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Container(
                      alignment:Alignment.center,
                      height: AppSize.height(232),
                      child:Text(
                        number,
                        textAlign: TextAlign.center,
                        style: ThemeTextStyle.cardTitleStyle,
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: AppSize.height(2),
                color: Colours.gray_f5,
              )
            ],
          )

    );
  }
}

class ThemeBtnCard extends StatelessWidget {
  final String title;
  final String price;
  final String imgUrl;

  ThemeBtnCard({
    this.title,
    this.price,
    this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(20)),
      decoration: ThemeDecoration.card2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              child:Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),)
          ,
          Padding(
              child: Text(title,style: ThemeTextStyle.cardTitleStyle,
                maxLines:2,overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(price,style: ThemeTextStyle.cardPriceStyle)),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Image.asset("images/exchange_btn.png",fit: BoxFit.cover))
        ],
      ),
    );
  }
}




class Badge extends StatelessWidget {
  final String text;

  Badge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1,horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.subTextColor),
        borderRadius: BorderRadius.circular(2)
      ),
      child: Text(text,style: TextStyle(
        fontSize: AppSize.sp(24),
        color: ThemeColor.hintTextColor
      ),),
    );
  }
}

