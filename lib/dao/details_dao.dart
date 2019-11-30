import 'package:dio/dio.dart';
import 'package:flutter_app/models/details_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'package:flutter_app/models/goods_entity.dart';
import 'config.dart';
const FINDING_URL = '$SERVER_HOST/goods/';
class DetailsDao{

  static Future<DetailsEntity> fetch(String id) async{
    try {

      Response response = await Dio().get(FINDING_URL+id);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<DetailsEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}