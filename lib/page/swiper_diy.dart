import 'package:flutter/material.dart';
import 'package:flutter_app/models/category_entity.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
/**
 * 轮播组件
 */
class SwiperDiy extends StatelessWidget{
  final List<CategoryInfoModel> swiperDataList;
  final double height;
  final double width;
  String imgUrl="http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  SwiperDiy({Key key,this.swiperDataList,this.height,this.width}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imgUrl+"${swiperDataList[index].idFile}",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(margin: EdgeInsets.all(1.0)),
        autoplay: true,
      ),
    );

  }
}