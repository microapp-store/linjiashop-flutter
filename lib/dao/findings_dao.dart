import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'package:flutter_app/models/goods_entity.dart';
import 'config.dart';
const FINDING_URL = '$SERVER_HOST/goods/queryGoods';
class FindingsDao{

  static Future<GoodsEntity> fetch(String id) async{
    try {
      Map<String,dynamic> map={"idCategory":id};
      Response response = await Dio().get(FINDING_URL,queryParameters: map);
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