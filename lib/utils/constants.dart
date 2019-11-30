

import 'package:flutter/widgets.dart';


const HEAD_NAV_TEXT = const <String>[
  "积分商城",
  "知名品牌",
  "附近商圈",
  "女性课堂",
  "商家直播",
  "邀请好友",
  "星选好店",
  "医学美容"
];




class Screen{
  static double _w;
  static double _statusH;

  static void init(BuildContext c){
    if(_w == null) {
      MediaQueryData mqd = MediaQuery.of(c);

      _w = mqd.size.width;
      _statusH = mqd.padding.top;
    }
  }

  static double width(){
    if(_w != null){
      return _w;
    }
    return 0;
  }

  ///
  /// 状态栏高度
  ///
  static double statusH(){
    if(_statusH != null){
      return _statusH;
    }
    return 0;
  }

}







