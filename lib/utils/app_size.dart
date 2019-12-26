
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize{
  static void init(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
  }

  static double height(double value){
    return ScreenUtil.getInstance().setHeight(value);
  }

  static double width(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }

  static double sp(double value){
    return ScreenUtil.getInstance().setSp(value);
  }


}


