import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/login_entity.dart';
import 'dart:async';

import 'config.dart';

const LOGIN_REG_URL = '$SERVER_HOST/loginOrReg';

class LoginRegDao{

  static Future<LoginEntity> fetch(String userName,String smsCode) async{
    try {
      Map<String,dynamic> map={"mobile":userName,"smsCode":smsCode};
      Response response = await Dio().post(LOGIN_REG_URL,queryParameters: map);
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




