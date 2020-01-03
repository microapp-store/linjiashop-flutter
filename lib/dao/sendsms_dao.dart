import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'package:flutter_app/models/goods_entity.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'config.dart';

const SEND_URL = '$SERVER_HOST/sendSmsCode?mobile=';
/**
 * 发送验证码
 */
class SendSmsDao{

  static Future<MsgEntity> fetch(String mobile) async{
    try {

      Response response = await Dio().post(SEND_URL+mobile);
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