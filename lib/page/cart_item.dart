
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';

import 'package:flutter_app/dao/clear_goods_dao.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'package:flutter_app/page/count_item.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/theme_ui.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItem extends StatelessWidget {


  final  List<GoodsModel> goodsModels;


  CartItem(this.goodsModels);
  String imgUrl = "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  @override
  Widget build(BuildContext context) {
//    print(item);
    return Container(

        margin: EdgeInsets.only(top: 5.0),
        padding:EdgeInsets.all(3.0),
        child:  _buildWidget(context)
    );
  }
  Widget _buildWidget(BuildContext context) {
    List<Widget> mGoodsCard = [];
    Widget content;
    for (int i = 0; i < goodsModels.length; i++) {
      mGoodsCard.add(Slidable(
        key: Key(i.toString()),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child:Container(

          height: AppSize.height(350),
          margin: EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
          padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width:1,color:Colors.black12)
              )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _cartCheckBt(context,goodsModels[i]),
              _cartImage(goodsModels[i]),
              _cartGoodsName(goodsModels[i],AppConfig.token),
            ],
          ),
        ) ,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: '移除',
            color: Colors.red,
            icon: Icons.delete,
            closeOnTap: true,
            onTap: (){
              return showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('提示？'),
                      content: Text('确定删除该条记录？'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('取消'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text('确定'),
                          onPressed: () {
                            loadClearGoods(context,goodsModels[i].orderId,AppConfig.token,i);
                          },
                        ),
                      ],
                    );
                  }
              );
            },
          ),
        ],
      ));
    }
    mGoodsCard.add(Container(
      height: AppSize.height(140),
    ));
    content = Column(
      children: mGoodsCard,
    );
    return content;
  }

  void loadClearGoods(BuildContext context,String orderId,String token,int index) async{
    MsgEntity entity = await ClearDao.fetch(orderId,token);
    if(entity?.msgModel != null){
      if(entity.msgModel.code==20000){
        Navigator.of(context).pop(true);
        goodsModels.removeAt(index);
        eventBus.fire(new GoodsNumInEvent("clear"));
      }
      DialogUtil.buildToast(entity.msgModel.msg);
    }else{
      DialogUtil.buildToast("服务器错误2~");
    }
  }
  //多选按钮
  Widget _cartCheckBt(BuildContext context,GoodsModel item){
    return Expanded(
      child:Container(
        width: AppSize.width(150),
        height: AppSize.height(232),
        child:Checkbox(
                value: item.isCheck,
                activeColor:Colors.pink,
                onChanged: (bool val){
                  item.isCheck=val;
                  eventBus.fire(new GoodsNumInEvent("state"));
                },
              )),

      flex: 1,
    );
  }
  //商品图片
  Widget _cartImage(GoodsModel item){

    return Container(
      width: AppSize.height(232),
      height: AppSize.height(232),
      margin: EdgeInsets.only(left: 15),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
          child:Image(image:CachedNetworkImageProvider(imgUrl+item.pic),fit: BoxFit.cover,)),
    );
  }
  //商品名称
  Widget _cartGoodsName(GoodsModel item,String token){
    return
      Expanded(
        child: Container(
          width:AppSize.width(350),
          margin: EdgeInsets.only(left: 10.0, top: 10.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.name, textAlign: TextAlign.left,
                  style: ThemeTextStyle.cardTitleStyle),
              Text(item.descript, textAlign: TextAlign.left,
                  style: ThemeTextStyle.cardTitleStyle),
              Text('￥${(item.price/100).toStringAsFixed(2)}',
                  textAlign: TextAlign.left,
                  style: ThemeTextStyle.cardPriceStyle),
              CartCount(item)
            ],
          ),
        ),
        flex: 3,
      );
  }

}