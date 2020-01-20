
import 'package:flutter/material.dart';

import '../global.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners();
  }
}
class UserModle extends ProfileChangeNotifier {
  String get token => _profile.token;
  set token(String token) {
    _profile.token = token;
    notifyListeners();
  }
  String get avatar => _profile.avatar;
  set avatar(String value) {
    _profile.avatar = value;
    notifyListeners();
  }
  String get nickName => _profile.nickName;
  set nickName(String value) {
    _profile.nickName = value;
    notifyListeners();
  }
  String get gender => _profile.gender;
  set gender(String value) {
    _profile.gender = value;
    notifyListeners();
  }
  void apiUpdate(Map data) {
    _profile.mobile = data['mobile'];
    _profile.gender = data['gender'];
    _profile.nickName = data['nickName'];
    _profile.avatar = data['avatar'];
  }
}