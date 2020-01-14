import 'package:flutter/material.dart';
import 'package:flutter_app/models/topic_goods_query_entity.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 主题推荐
 */
class TopicCardGoods extends StatelessWidget {
  final List<TopicGoodsListModel> topicGoodsModleDataList;
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  TopicCardGoods({Key key, @required this.topicGoodsModleDataList})
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
      List<TopicGoodsListModel> subTopicGoodsModleDataList) {
    List<Widget> mSubGoodsCard = [];
    Widget content;
    final screenWidth = ScreenUtil.screenWidth;

    for (int i = 0; i < subTopicGoodsModleDataList.length; i++) {
      String id=subTopicGoodsModleDataList[i].id;
      if (i == 0) {
        mSubGoodsCard.add(

          InkWell(
              onTap: () {
                onItemClick(context, i,id);
              },
              child: Container(
                width: AppSize.width(screenWidth / 2 - 21),
                height: AppSize.height(230),
                child: Image.network(
                  imgUrl +
                      "${subTopicGoodsModleDataList[0].topicGoodsModel.img}",
                  fit: BoxFit.fill,
                ),
              )),
        );
      } else {
        mSubGoodsCard.add(InkWell(
          onTap: () {
            onItemClick(context, i,id);
          },
          child: Container(
            width: AppSize.width(screenWidth / 4 - 30),
            height: AppSize.height(230),
            child: Image.network(
              imgUrl + "${subTopicGoodsModleDataList[i].topicGoodsModel.img}",
              fit: BoxFit.fill,
            ),
          ),
        ));
      }
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
    List<TopicGoodsListModel> sub = List();
    for (int i = 0; i < topicGoodsModleDataList.length; i++) {
      if ((i + 1) % 3 == 1) {
        sub.add(topicGoodsModleDataList[i]);
        if (i == topicGoodsModleDataList.length - 1) {
          mTopCard.add(_buildRow(context, sub));
          sub.clear();
        }
      }
      if ((i + 1) % 3 == 2) {
        sub.add(topicGoodsModleDataList[i]);
        if (i == topicGoodsModleDataList.length - 1) {
          mTopCard.add(_buildRow(context, sub));
          sub.clear();
        }
      }
      if ((i + 1) % 3 == 0) {
        sub.add(topicGoodsModleDataList[i]);
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
