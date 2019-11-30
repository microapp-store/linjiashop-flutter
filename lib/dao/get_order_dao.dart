import 'package:dio/dio.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/order_entity.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'dart:async';

import 'config.dart';

const OREDER_GET_URL = '$SERVER_HOST/user/order/getOrders';

class OrderQueryDao{

  static Future<OrderEntity> fetch(int status,int page,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});

      Response response = await Dio().get(OREDER_GET_URL,
          queryParameters: {"status":status,"page":page,"limt":20},options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<OrderEntity>(response.data);
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