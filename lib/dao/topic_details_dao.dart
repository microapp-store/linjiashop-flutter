import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/topic_details_entity.dart';
import 'dart:async';
import 'config.dart';
const TOPIC_DETAIL_URL = '$SERVER_HOST/topic/';


class TopicDetailsDao{

  static Future<TopicDetailsEntity> fetch(String id) async{
    try {
      Response response = await Dio().get(TOPIC_DETAIL_URL+id);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<TopicDetailsEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}