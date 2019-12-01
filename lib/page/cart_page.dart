import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/cart_query_dao.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/page/cart_item.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart_bottom.dart';
import 'load_state_layout.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();

}

class _CartPageState extends State<CartPage> {
  LoadState _layoutState = LoadState.State_Loading;
  List<GoodsModel> goodsModels= List();
  String token ;
  bool _isLoading = false;
  bool _isAllCheck = true;
  @override
  void initState() {
    _isLoading=true;
    loadCartData(AppConfig.token);
    print("--*-- CartPage");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    Screen.init(context);
    _listen();
    return Scaffold(
              appBar: MyAppBar(
              preferredSize: Size.fromHeight(AppSize.height(160)),
              child: CommonTopBar(title: "购物车"),
              ),
              body: LoadStateLayout(
              state: _layoutState,
              errorRetry: () {
              setState(() {
              _layoutState = LoadState.State_Loading;
              });
              _isLoading=true;
              loadCartData(AppConfig.token);

              },
              successWidget: _getContent(context)
    )
    );
  }

  Widget _getContent(BuildContext context) {
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return Stack(
        children: <Widget>[
               SingleChildScrollView(
            child:CartItem(goodsModels),
         ),
                Positioned(
                  bottom:0,
                  left:0,
                  child: CartBottom(goodsModels,_isAllCheck),
                )
              ],
      );


    }
  }

  void loadCartData(String token)async{

      CartGoodsQueryEntity entity = await CartQueryDao.fetch(token);
      if(entity?.goods != null){
        if(entity.goods.length > 0){
          List<GoodsModel> goodsModelsTmp = List();
          entity.goods.forEach((el){
            goodsModelsTmp.add(el.goodsModel);
          });
          if(mounted) {
            setState(() {
              _isLoading = false;
              _layoutState = LoadState.State_Success;
              goodsModels.clear();
              goodsModels.addAll(goodsModelsTmp);
            });
          }
        }else{
          if(mounted) {
            setState(() {
              _layoutState = LoadState.State_Empty;
            });
          }

        }
      }else{
        if(mounted) {
          setState(() {
            _layoutState = LoadState.State_Error;

          });
        }
      }


  }
  StreamSubscription _failSubscription;
  StreamSubscription _clearSubscription;

  ///监听Bus events
  void _listen() {
    _failSubscription=eventBus.on<UserLoggedInEvent>().listen((event) {

      if("fail"==event.text&&!AppConfig.isUser) {
        AppConfig.isUser=true;
        DialogUtil.buildToast("请求失败~");
        Routes.instance.navigateTo(context, Routes.login_page);
       AppConfig.token='';
        setState(() {
          _layoutState = LoadState.State_Error;
        });

      }
    });

    _clearSubscription= eventBus.on<GoodsNumInEvent>().listen((event) {
      if(mounted) {
        if ('clear' == event.event) {
          setState(() {
            if (goodsModels.length == 0) {
              _layoutState = LoadState.State_Empty;
            }
          });
        } else {
          ///除了删除处理全选，添加操作
          if ('All' == event.event && goodsModels.length > 0) {
            _isAllCheck = goodsModels[0].isCheck;
          } else {
            _isAllCheck = false;
          }
          setState(() {

          });
        }
      }

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _failSubscription.cancel();
    _clearSubscription.cancel();
  }

}

