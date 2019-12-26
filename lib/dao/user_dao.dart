import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/login_entity.dart';
import 'package:flutter_app/models/user_entity.dart';
import 'dart:async';

import 'config.dart';
const USER_URL = '$SERVER_HOST/user/getInfo';

class UserDao{

  static Future<UserEntity> fetch(String token) async{
    try {
      Options options = Options(headers: {"Authorization":token});
      Response response = await Dio().get(USER_URL,options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<UserEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




