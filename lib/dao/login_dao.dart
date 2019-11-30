import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/login_entity.dart';
import 'dart:async';
import 'package:flutter_app/models/store_entity.dart';
import 'config.dart';
const LOGIN_URL = '$SERVER_HOST/loginByPass';

class LoginDao{

  static Future<LoginEntity> fetch(String userName,String password) async{
    try {
      Map<String,dynamic> map={"mobile":userName,"password":password};
      Response response = await Dio().post(LOGIN_URL,queryParameters: map);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<LoginEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




