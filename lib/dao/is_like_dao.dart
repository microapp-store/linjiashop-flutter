import 'package:dio/dio.dart';
import 'package:flutter_app/models/details_entity.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'package:flutter_app/models/msg_like_entity.dart';
import 'dart:async';
import 'config.dart';
const LIKE_URL = '$SERVER_HOST/user/favorite/ifLike/';
class LikeDao{

  static Future<MsgLikeEntity> fetch(String token,String id) async {
    try {
      Options options = Options(headers: {"Authorization": token});
      Response response = await Dio().get(LIKE_URL + id, options: options);
      if (response.statusCode == 200) {
        return EntityFactory.generateOBJ<MsgLikeEntity>(response.data);
      } else {
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}