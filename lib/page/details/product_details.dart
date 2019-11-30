import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/add_goods_cart_dao.dart';
import 'package:flutter_app/dao/cart_query_dao.dart';
import 'package:flutter_app/dao/details_dao.dart';
import 'package:flutter_app/models/cart_entity.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/models/details_entity.dart';
import 'package:flutter_app/page/details_top_area.dart';
import 'package:flutter_app/page/load_state_layout.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
///
/// 商品详情页
///
class ProductDetails extends StatefulWidget {
  final String id;
  ProductDetails({this.id});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>  {
  int num = 0;
  LoadState _loadStateDetails=LoadState.State_Loading;
  GoodsModelDetail goodsModel;


  @override
  void initState() {
    loadData();


    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async{
   DetailsEntity entity = await DetailsDao.fetch(widget.id.toString());
    if(entity?.goods != null){
      goodsModel=entity.goods;
      urls.clear();
      urls=goodsModel.gallery.split(",");
      setState(() {
        _loadStateDetails = LoadState.State_Success;
      });
    }else{
      setState(() {
        _loadStateDetails = LoadState.State_Error;
      });
    }
  }

  List<String> urls=List();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: _getHeader(),
        ),
      body: LoadStateLayout(
          state: _loadStateDetails,
          errorRetry: () {
            setState(() {
              _loadStateDetails = LoadState.State_Loading;
            });
            loadData();
          },
          successWidget:_getContent()
      )
    );

  }
  ///返回不同头部
  _getHeader(){
    if(null==goodsModel){
      return CommonBackTopBar(title: "详情",onBack:()=>Navigator.pop(context));
    }else{
      return CommonBackTopBar(title: goodsModel.name,onBack:()=>Navigator.pop(context));
    }
  }
  ///返回内容
  _getContent(){
    if(null==goodsModel){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
     return Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              DetailsTopArea(gallery: urls,descript:goodsModel.descript,name: goodsModel.name,
                  num:goodsModel.num,price: goodsModel.price),
           Html(data: goodsModel.detail)
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: detailBottom()
          )
        ],
      );
    }
  }
  /**
   * 底部详情
   */
  Widget detailBottom() {
    return Container(
      width:AppSize.width(1500),
      color: Colors.white,
      height:AppSize.width(160),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: (){

                  if(AppConfig.token.isEmpty)  {
                    Routes.instance.navigateTo(context, Routes.login_page);
                    return;
                  }
                  eventBus.fire(new IndexInEvent("2"));
                  Navigator.pop(context);

                },
                child: Container(
                  width:AppSize.width(300) ,
                  alignment: Alignment.center,
                  child:Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ) ,
              ),
           num==0?Container():
           Positioned(
                    top:0,
                    right: 10,
                    child: Container(
                      padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          color:Colors.pink,
                          border:Border.all(width: 2,color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child:
                     Text(
                   num.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSize.sp(22)
                        ),
                      ),
                    ),
                  )
            ],
          ),

          InkWell(
            onTap: ()async {

              if(AppConfig.token.isEmpty)  {
                Routes.instance.navigateTo(context, Routes.login_page);
                return;
              }
              addCart(widget.id, 1, AppConfig.token);
            },
            child: Container(
              alignment: Alignment.center,
              width: AppSize.width(400),
              height: AppSize.height(160),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white,fontSize: AppSize.sp(54)),
              ),
            ) ,
          ),
          InkWell(
            onTap: (){

              if(AppConfig.token.isEmpty)  {
                Routes.instance.navigateTo(context, Routes.login_page);
                return;
              }

              eventBus.fire(new IndexInEvent("2"));
              Navigator.pop(context);

            },
            child: Container(
              alignment: Alignment.center,
              width: AppSize.width(400),
              height: AppSize.height(160),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white,fontSize: AppSize.sp(54)),
              ),
            ) ,
          ),
        ],
      ),
    );
  }
  void addCart(String idGoods,int count,String token) async{
    CartEntity entity = await AddDao.fetch(idGoods,count,token);
    if(entity?.cartModel != null){
      if(entity.cartModel.code==20000){
        setState(() {
          num++;
        });
      }
      DialogUtil.buildToast(entity.cartModel.msg);
    }else{
      DialogUtil.buildToast("flutter_app~");
    }

  }


  void loadCartData(String token)async{
    CartGoodsQueryEntity entity = await CartQueryDao.fetch(token);
    if(entity?.goods != null){
      int numTmp=0;
      if(entity.goods.length>0){
        entity.goods.forEach((el){
          numTmp = numTmp+el.count;
        });
        ///更新总数
        setState(() {
         num = numTmp;
        });
      }

    }else{
      DialogUtil.buildToast("服务器错误1~");
    }
  }
  clearUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}
