import 'package:flutter/material.dart';
import 'package:flutter_app/res/colours.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/**
 * 商品详情头部
 */
class DetailsTopArea extends StatelessWidget {
  List<String> gallery=List();
  final String descript;
  final String name;
  final int num;
  final int price;
  double priceGoods;

  DetailsTopArea({Key key,this.gallery,this.descript,this.name,this.num,this.price}):super(key:key);
  String imgUrl="http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  @override
  Widget build(BuildContext context) {
            priceGoods=price/100;
            return Container(
              color: Colours.divider,
              child: Column(
                children: <Widget>[
                  _goodsImage(),
                  _goodsName(),
                  _goodsComment(),
                ],
              ),
            );
  }

  ///商品图片
  Widget _goodsImage(){
    return Container(
      height: AppSize.height(640),
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imgUrl+"${gallery[index]}",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: gallery.length,
        pagination: SwiperPagination(margin: EdgeInsets.all(1.0)),
        autoplay: true,
      ),
    );

  }

  ///商品名称
  Widget _goodsName(){

    return Container(
      width: double.infinity,
      color:  Colors.white,
      height: AppSize.height(360),
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  name,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: ThemeTextStyle.personalShopNameStyle,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  descript,
                  textAlign: TextAlign.left,
                  style: ThemeTextStyle.detailStyle,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15.0),
                child:Text(
                  "¥"+priceGoods.toStringAsFixed(2).toString(),
                  textAlign: TextAlign.left,
                  style: ThemeTextStyle.detailStylePrice,
                ),
              ),
              flex: 1,
            ),
            Container(
              width: double.infinity,
              height: AppSize.height(2),
              color: Colours.gray_f0,
            ),
            Expanded(
                   child: Row(
                      children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        '运费：免运费' ,
                                        textAlign: TextAlign.left,
                                        style: ThemeTextStyle.detailStyle
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        '剩余：'+num.toString(),
                                        textAlign: TextAlign.left,
                                          style: ThemeTextStyle.detailStyle
                                      ),
                                    ),
                                    flex: 1,
                                  )

                      ],
                    ),flex: 1),
            Container(
              width: double.infinity,
              height: AppSize.height(2),
              color: Colours.gray_f0,
            ),
          ],
        )

    );
  }

  ///查看商品评论

  Widget _goodsComment(){
//    return Container(
//      color: Colors.white,
//      height: AppSize.height(90),
//      child:
  return
  Container(
    width: double.infinity,
    color: Colors.white,
    child: ListTile(
  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      title:  Text(
          '查看商品评论' ,
          textAlign: TextAlign.left,
          style: ThemeTextStyle.primaryStyle
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 17.0,
      ),
    ) ,

  );



//      );

  }

}

