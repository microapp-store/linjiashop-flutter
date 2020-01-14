import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'package:flutter_app/models/hot_entity.dart';
import 'config.dart';
const NEW_GOODS_URL = '$SERVER_HOST/goods/searchNew';
class NewGoodsDao{
  static Future<HotEntity> fetch() async{
    try {
      Response response = await Dio().get(NEW_GOODS_URL);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<HotEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}