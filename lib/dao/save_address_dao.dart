import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'dart:async';
import 'config.dart';
const SAVE_ADDRESS_URL = '$SERVER_HOST/user/address/save';

class SaveDao{

  static Future<MsgEntity> fetch(Map<String, dynamic> param,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token,"content-type":"application/json"});

//      Map<String, dynamic> body={"addressInfo":param};
//      FormData formData = new FormData.from({
//        "addressInfo": body
//
//      });
//      Map<String, dynamic> body={"addressInfo":param};
      Response response = await Dio().post(SAVE_ADDRESS_URL,
          data:json.encode(param),
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




