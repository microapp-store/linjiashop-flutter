import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/shipping_entity.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'dart:async';
import 'config.dart';
const SHIPPING_URL = '$SERVER_HOST/user/address/queryByUser';

class ShippingAddressDao{
  static Future<ShippingAddresEntry> fetch(String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});
      Response response = await Dio().get(SHIPPING_URL,
          options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<ShippingAddresEntry>(response.data);
      }else{
        eventBus.fire(UserLoggedInEvent("fail"));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




