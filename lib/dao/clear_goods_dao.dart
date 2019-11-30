import 'package:dio/dio.dart';

import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'dart:async';
import 'config.dart';
const CLEAR_URL = '$SERVER_HOST/user/cart';

class ClearDao{

  static Future<MsgEntity> fetch(String id,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});
      Response response = await Dio().delete(CLEAR_URL,
          queryParameters: {"id":id},
          options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<MsgEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




