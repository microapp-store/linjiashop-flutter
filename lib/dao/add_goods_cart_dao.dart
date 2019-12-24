import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/models/cart_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';

import 'config.dart';
const ADD_URL = '$SERVER_HOST/user/cart/add';

class AddDao{

  static Future<CartEntity> fetch(String idGoods,int count,String idSku,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});

        Map<String, dynamic> param = {"idGoods": idGoods,
          "count": count,
          "idSku": idSku.isNotEmpty?int.parse(idSku):idSku};

      Response response = await Dio().post(ADD_URL,
          data:json.encode(param),
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




