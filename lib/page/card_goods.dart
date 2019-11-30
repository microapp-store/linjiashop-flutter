import 'package:flutter/material.dart';
import 'package:flutter_app/models/goods_entity.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/view/custom_view.dart';
class CardGoods extends StatelessWidget {
  final List<GoodsModel> goodsModleDataList;
  String imgUrl = "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  CardGoods({Key key, this.goodsModleDataList}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color:Colors.white,
        margin: EdgeInsets.only(top: 5.0),
    padding:EdgeInsets.all(3.0),
    child:  _buildWidget(context)
    );
  }
  Widget _buildWidget(BuildContext context) {
    List<Widget> mGoodsCard = [];
    Widget content;
    for (int i = 0; i < goodsModleDataList.length; i++) {
      double priceDouble = goodsModleDataList[i].price/100;
      mGoodsCard.add(InkWell(
          onTap: () {
            onItemClick(context,i);
          },
          child: ThemeCard(
            title: goodsModleDataList[i].name,
            price:"¥"+priceDouble.toStringAsFixed(2) ,
            imgUrl:imgUrl+goodsModleDataList[i].pic,
            descript: goodsModleDataList[i].descript,
            number: "x"+goodsModleDataList[i].num.toString(),
          )
      )
      );
    }
    content = Column(
      children: mGoodsCard,
    );
    return content;
  }

  void onItemClick(BuildContext context,int i){
   String id = goodsModleDataList[i].id;
   Map<String, dynamic> p={"id":id};
   Routes.instance.navigateToParams(context,Routes.PRODUCT_DETAILS,params: p);
  }
}