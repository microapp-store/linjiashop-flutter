import 'package:flutter/material.dart';
import 'package:flutter_app/models/topic_details_entity.dart';
import 'package:flutter_app/models/topic_goods_query_entity.dart';
import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 主题详情推荐
 */
class TopicDeatilsCardGoods extends StatelessWidget {
  final List<TopGoods> topicGoods;
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  TopicDeatilsCardGoods({Key key, @required this.topicGoods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.all(3.0),
        child: _buildWidget(context));
  }

  Row _buildRow(BuildContext context,
      List<TopGoods> sub) {
    List<Widget> mSubGoodsCard = [];
    Widget content;
    final screenWidth = ScreenUtil.screenWidth;

    for (int i = 0; i < sub.length; i++) {
      String pic=sub[i].pic;
      String name=sub[i].name;
        mSubGoodsCard.add(
          InkWell(
              onTap: () {
              },
              child: Column(
                children: <Widget>[
                  Container(
                    width: AppSize.width(screenWidth / 2 - 28),
                    height: AppSize.height(360),
                    margin: EdgeInsets.all(3.0),
                    child: Image.network(
                      imgUrl +pic,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: AppSize.width(screenWidth / 2 - 28),
                    height: AppSize.height(48),
                    color: Colours.gray_99,
                    child: Center(child: Text(name,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        style: TextStyle(color: Colors.white,fontSize: AppSize.sp(42)))) ,
                  )

                ],
              )
            ),
        );

    }

    content = Row(
      children: mSubGoodsCard,
    );
    return content;
  }

  void onItemClick(BuildContext context, int i,String id) {

    Map<String, String> p = {"id": id};
    Routes.instance.navigateToParams(context, Routes.topic_page, params: p);
  }

  Widget _buildWidget(BuildContext context) {
    List<Row> mTopCard = [];
    Widget content;
    List<TopGoods> sub = List();
    for (int i = 0; i < topicGoods.length; i++) {
      if ((i + 1) % 2 == 1) {
        sub.add(topicGoods[i]);
        if (i == topicGoods.length - 1) {
          mTopCard.add(_buildRow(context, sub));
          sub.clear();
        }
      }
      if ((i + 1) % 2 == 0) {
        sub.add(topicGoods[i]);
          mTopCard.add(_buildRow(context, sub));
          sub.clear();
      }

    }

    content = Column(
      children: mTopCard,
    );
    return content;
  }
}
