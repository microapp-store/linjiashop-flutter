import 'package:dio/dio.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'dart:async';

import 'config.dart';

const CART_URL = '$SERVER_HOST/user/cart/queryByUser';
class CartQueryDao{

  static Future<CartGoodsQueryEntity> fetch(String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});
      Response response = await Dio().get(CART_URL,options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<CartGoodsQueryEntity>(response.data);
      }
      else{
        eventBus.fire(new UserLoggedInEvent("fail"));

      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}