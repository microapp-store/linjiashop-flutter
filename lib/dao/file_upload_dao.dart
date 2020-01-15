import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/models/entity_factory.dart';
import 'package:flutter_app/models/file_upload_entity.dart';
import 'dart:async';
import 'config.dart';
const FILE_UPLOAD_URL = '$SERVER_HOST/file/upload/base64';

class FileUploadDao{

  static Future<FileEntity> fetch(Map<String, dynamic> param,String token) async{
    try {
      Options options = Options(headers: {"Authorization":token,"content-type":"application/json"});

      Response response = await Dio().post(FILE_UPLOAD_URL,
          data:json.encode(param),
          options: options);
      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<FileEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




