import 'package:dio/dio.dart';
import 'package:flutter_app/models/cart_goods_query_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/order_detail_entity.dart';
import 'package:flutter_app/models/order_entity.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'dart:async';

import 'config.dart';

const OREDER_DETAIL_GET_URL = '$SERVER_HOST/user/order/';

class OrderDetailDao{

  static Future<OrderDetailEntry> fetch(String  orderSn,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});

      Response response = await Dio().get(OREDER_DETAIL_GET_URL+orderSn,options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<OrderDetailEntry>(response.data);
      }

    } catch (e) {
      print(e);
      return null;
    }
  }

}