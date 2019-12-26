import 'package:dio/dio.dart';
import 'package:flutter_app/models/address_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/shipping_entity.dart';
import 'package:flutter_app/receiver/event_bus.dart';
import 'dart:async';
import 'config.dart';
const SHIPPING_EDIT_URL = '$SERVER_HOST/user/address/';

class ShippingEditAddressDao{
  static Future<AddressEditEntity> fetch(String token,String id) async{
    try {
      Options options = Options(headers: {"Authorization":token});
      Response response = await Dio().get(SHIPPING_EDIT_URL+id,
          options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<AddressEditEntity>(response.data);
      }else{
        eventBus.fire(UserLoggedInEvent("fail"));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




