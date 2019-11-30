import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'package:flutter_app/models/goods_entity.dart';
import 'config.dart';

const SEND_URL = '$SERVER_HOST/sendSmsCode ';
/**
 * 发送验证码
 */
class SendSmsDao{

  static Future<GoodsEntity> fetch(String mobile) async{
    try {
      Map<String,dynamic> map={"mobile":mobile};
      Response response = await Dio().get(SEND_URL,queryParameters: map);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<GoodsEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}