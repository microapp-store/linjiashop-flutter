import 'package:dio/dio.dart';
import 'package:flutter_app/models/cart_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'config.dart';
const ADD_URL = '$SERVER_HOST/user/cart/add';

class AddDao{

  static Future<CartEntity> fetch(String idGoods,int count,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});
      Response response = await Dio().post(ADD_URL,
          queryParameters: {"idGoods":idGoods,"count":count},
          options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<CartEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




