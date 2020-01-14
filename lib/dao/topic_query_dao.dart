import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/topic_goods_query_entity.dart';
import 'dart:async';
import 'config.dart';

const TOPIC_URL = '$SERVER_HOST/topic/list';
class TopicQueryDao{

  static Future<TopicGoodsQueryEntity> fetch() async{
    try {

      Response response = await Dio().get(TOPIC_URL);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<TopicGoodsQueryEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }

    } catch (e) {
      print(e);
      return null;
    }
  }

}