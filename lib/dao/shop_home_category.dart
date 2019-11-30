import 'package:dio/dio.dart';
import 'package:flutter_app/models/category_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'dart:async';
import 'config.dart';
const CATEGORY_URL = '$SERVER_HOST/category/list';
class ShopHomeCategoryDao{

  static Future<CategoryEntity> fetch() async{
    try {
      Response response = await Dio().get(CATEGORY_URL);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<CategoryEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}