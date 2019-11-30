import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'package:flutter_app/models/hot_entity.dart';
import 'config.dart';
const SEAECH_URL = '$SERVER_HOST/goods/search';
class SearchDao{

  static Future<HotEntity> fetch(String key) async{
    try {
      Map<String,dynamic> map={"key":key};
      Response response = await Dio().get(SEAECH_URL,queryParameters: map);

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