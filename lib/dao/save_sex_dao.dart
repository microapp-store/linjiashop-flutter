import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'dart:async';
import 'config.dart';
const SAVE_SEX_URL = '$SERVER_HOST/user/updateGender/';


class SaveSexDao{

  static Future<MsgEntity> fetch(String sex,String token) async{
    try {
      Map<String,String> map={"Authorization":token};
      Options options = Options(headers:map);
      Response response = await Dio().post(SAVE_SEX_URL+sex,
          options: options);
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




