import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  @override
  final Size preferredSize;

  const MyAppBar({
    Key key,
    @required this.child,
    @required this.preferredSize,
  }) : super(key: key);

  void initStateBar() async{
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    double _statusHeight = ScreenUtil.statusBarHeight;

    return Container(
      padding: EdgeInsets.only(left: 6, right: 6,top: _statusHeight),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff00C2FD), Color(0xff00C2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      height: preferredSize.height+_statusHeight,
//        color: Theme.of(context).primaryColor,
      child: this.child,
    );
  }
}
