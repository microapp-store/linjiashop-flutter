library global;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Profile {
  String token = '';
  //  头像
  String avatar = '';
  //  昵称
  String nickName = '';
  //手机
  String mobile = '';
  //性别
  String gender = '';
  Profile();
  Profile.fromJson(Map json) {
    avatar = json['avatar'];
    mobile = json['mobile'];
    nickName = json['nickName'];
    gender = json ['gender'];
  }
  Map<String, dynamic> toJson() => {
    'token': token,
    'avatar': avatar,
    'mobile': mobile,
    'nickName': nickName,
    'gender': gender,
  };
}
class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    String _profile = _prefs.getString('profile');
    if (_profile != null) {
      try {
        Map decodeContent = jsonDecode(_profile != null ? _profile : '');
        profile = Profile.fromJson(decodeContent);
      } catch (e) {
        print(e);
      }
    }
  }
  static saveProfile() => _prefs.setString('profile', jsonEncode(profile.toJson()));
}
abstract class CommonInterface {
  String cToken(BuildContext context) {
    return Provider.of<UserModle>(context).token;
  }
  String cAvatar(BuildContext context) {
    return Provider.of<UserModle>(context).avatar;
  }
  String cNickName(BuildContext context) {
    return Provider.of<UserModle>(context).nickName;
  }
  String cGender(BuildContext context) {
    return Provider.of<UserModle>(context).gender;
  }
}