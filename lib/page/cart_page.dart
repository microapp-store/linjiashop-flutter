import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/cart_query_dao.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/page/cart_item.dart';
import 'package:flutter_app/provider/user_model.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/utils/app_size.dart';

import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:provider/provider.dart';

import '../cart_bottom.dart';
import '../global.dart';
import 'load_state_layout.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with CommonInterface {
  LoadState _layoutState = LoadState.State_Loading;
  List<GoodsModel> goodsModels = List();

  bool _isLoading = false;
  bool _isAllCheck = true;

  @override
  void initState() {
//    print("--*-- CartPage");
    super.initState();
    _isLoading = true;

    Future.microtask(() => loadCartData(cToken(context)));
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    _listen();
    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160.0)),
          child: CommonTopBar(title: "购物车"),
        ),
        body: LoadStateLayout(
            state: _layoutState,
            errorRetry: () {},
            successWidget: _getContent(context)));
  }

  Widget _getContent(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if(cToken(context).isEmpty){
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 128,
              ),
              Icon(CupertinoIcons.shopping_cart, size: 128),
              Text("还没有登录"),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Material(
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                          BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25.0),
                          onTap: () {
                            Routes.instance
                                .navigateTo(context, Routes.login_page);
                          },
                          child: Container(
                            width: 300.0,
                            height: 50.0,
                            //设置child 居中
                            alignment: Alignment(0, 0),
                            child: Text(
                              "立即登录",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      }else if(goodsModels.length==0){
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 128,
              ),
              Icon(CupertinoIcons.shopping_cart, size: 128),
              Text("购物车是空的"),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Material(
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                          BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25.0),
                          onTap: () {
                            Routes.instance
                                .navigateTo(context, Routes.ROOT);
                          },
                          child: Container(
                            width: 300.0,
                            height: 50.0,
                            //设置child 居中
                            alignment: Alignment(0, 0),
                            child: Text(
                              "去逛逛",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      }else{
        return Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: CartItem(goodsModels),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: CartBottom(goodsModels, _isAllCheck),
            )
          ],
        );
      }

    }
  }


  void loadCartData(String token) async {
    CartGoodsQueryEntity entity = await CartQueryDao.fetch(token);
    if (entity?.goods != null) {
      if (entity.goods.length > 0) {
        List<GoodsModel> goodsModelsTmp = List();
        entity.goods.forEach((el) {
          goodsModelsTmp.add(el.goodsModel);
        });
        if (mounted) {
          setState(() {
            _isLoading = false;
            _layoutState = LoadState.State_Success;
            goodsModels.clear();
            goodsModels.addAll(goodsModelsTmp);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            goodsModels.clear();

            _isLoading = false;
            _layoutState = LoadState.State_Success;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _layoutState = LoadState.State_Success;
          Provider.of<UserModle>(context).token = '';
        });
      }
    }
  }

  StreamSubscription _clearSubscription;
  StreamSubscription _loginSubscription;

  ///监听Bus events
  void _listen() {
    _clearSubscription = eventBus.on<GoodsNumInEvent>().listen((event) {
      if (mounted) {
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
          setState(() {});
        }
      }
    });
    _loginSubscription = eventBus.on<UserLoggedInEvent>().listen((event) {
      if (mounted) {
        if ('sucuss' == event.text) {
          loadCartData(cToken(context));

        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginSubscription.cancel();
    _clearSubscription.cancel();
  }
}
